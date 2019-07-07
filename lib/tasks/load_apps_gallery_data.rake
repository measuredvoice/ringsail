namespace :load_apps_gallery_data do

  desc "fixing data for production deploy"
  task :data_fix, [:file] => :environment do |t,args|
    PublicActivity.enabled = false 
    MobileAppVersion.where(device: "Mobile Phone").update_all(device: "App - Phone/Tablet") 
    MobileAppVersion.where(device: "Tablet").update_all(device: "App - Tablet Only") 
    MobileAppVersion.where(device: "Mobile Web Browser").update_all(device: "Web") 
    MobileApp.all.each do |ma| 
      ma.long_description = ActionView::Base.full_sanitizer.sanitize(ma.long_description) 
      ma.save 
    end 
    Outlet.all.each do |out| 
      out.published! 
      out.save 
    end 

  end



  desc "actually publish"
  task :publish, [:file] => :environment do |t,args|
    PublicActivity.enabled = false
    puts "publish items that might not be actually published"
    Outlet.where("status = ?", Outlet.statuses[:published]).each { |outlet| outlet.published!}
    MobileApp.where("status = ?", MobileApp.statuses[:published]).each { |ma| ma.published!}
    Gallery.where("status = ?", Gallery.statuses[:published]).each { |ga| ga.published!}
    
    puts "outlets updates"
    Sponsorship.all.each do |sponsorship|
      sponsorship.update_counter_cache
    end
    OutletOfficialTag.all.each do |oot|
      oot.update_counter_cache
    end

    puts "mobile apps updates"
    MobileAppAgency.all.each do |maa|
      maa.update_counter_cache
    end
    MobileAppOfficialTag.all.each do |maot|
      maot.update_counter_cache
    end

    puts "gallery updates"
    GalleryAgency.all.each do |ga|
      ga.update_counter_cache
    end
    GalleryOfficialTag.all.each do |got|
      got.update_counter_cache
    end
  end

	desc "update all"
	task :update_all, [:file] => :environment do |t,args|
		PublicActivity.enabled = false
		Outlet.update_all(status: 1)
    Outlet.where(status: 1).each do |outlet|
      outlet.published!
    end
    MobileApp.update_all(status: 1)
    MobileApp.where(status: 1).each do |mobile_app|
      mobile_app.published!
    end
    Gallery.update_all(status: 1)
	end
  
  desc "Fill agencies"
  task :agencies, [:file] => :environment do |t, args|
  	filepath= args[:file] || "data/current/agencies.json"
  	PublicActivity.enabled = false
  	if filepath

		json = nil
	    File.readlines(filepath).each do |f|
	        item = JSON.load( f )
		    	agency = nil
		    	agencies = Agency.where("name LIKE ?", "%#{item["Name"]}%")
		    	if agencies.count == 0
		    		agency = Agency.find_or_create_by(name: item["Name"])
		    	else
		    		agency = agencies.first
		    	end
		    	agency.mongo_id = item["Id"]
		    	agency.parent_mongo_id = item["ParentId"]
		    	agency.shortname = item["Acronym"] ? item["Acronym"].downcase : nil
		    	agency.save!
	    end

	    Agency.all.each do |agency|
	    	if(agency.parent_mongo_id)
	    		parent = Agency.find_by(mongo_id: agency.parent_mongo_id)
		    	agency.parent_id = parent.id if parent
		    	
		    	agency.save!
		    end
	    end
  	else
  		puts "provide a file path relative to current working directory (or absolute)"
  	end
  end

  desc "Fill contacts"
  task :contacts, [:file] => :environment do |t, args|
  	filepath= args[:file] || "data/current/contacts.json"
  	PublicActivity.enabled = false
  	if filepath

  		json = nil
  	    File.readlines(filepath).each do |f|
  	      item = JSON.load( f )
  	    	user = nil
  	    	user = User.find_by(email: item["Email1"])
  	    	if user == nil
  	    		user = User.new(user: item["Id"])
  	    	end
  	    	user.email = item["Email1"] ? item["Email1"] : "replace#{rand(100000)}@please.gov"
  	    	user.first_name = item["FirstName"]
  	    	user.last_name = item["LastName"]
  	    	if item["Agency"] && item["Agency"] != []
  	    		user.agency = Agency.find_by(mongo_id: item["Agency"][0]["Id"])
  	    	end
  	    	user.phone = item["Phone1"]
  	    	user.save!
  	    end

  	else
  		puts "provide a file path relative to current working directory (or absolute)"
  	end
  end


  desc "Fill mobile apps"
  task :mobile_apps, [:file] => :environment do |t, args|
  	filepath= args[:file] || "data/current/registrations.json"
  	PublicActivity.enabled = false
    Gallery.skip_callback(:save)
    MobileApp.skip_callback(:save)
    MobileAppVersion.skip_callback(:save)
    Gallery.skip_callback(:create)
    MobileApp.skip_callback(:create)
    MobileAppVersion.skip_callback(:create)
  	if filepath
  	    File.readlines(filepath).each do |f|
  	      item = JSON.load( f )
  	    	app = MobileApp.find_or_create_by(mongo_id: item["Id"])
  	    	app.name = item["Name"]
  	    	app.short_description = item["Short_Description"]
  	    	app.long_description = item["Long_Description"]
  	    	if item["Icon"]
  		    	app.icon_url = item["Icon"].join(",")
  		    end
  	    	app.language = item["Language"] == "English" ? "English" : "Spanish"
          app.agencies = []
  	    	if item["Agency"] && item["Agency"] != []
  		    	item["Agency"].each do |agency|
  		    		agency = Agency.find_by(mongo_id: agency["Id"])
  		    		if agency
  		    			app.agencies << agency
  		    		else
  		    			puts "Couldn't find agency - #{agency.inspect}"
  		    		end
  		    	end
  		    end
  	    	case item["Status"]
  		    	when "PUBLIC"
  		    		app.status = 1
  		    	when "PENDING"
  		    		app.status = 0
  		    	when "UNDER_REVIEW"
  		    		app.status = 0
  		    	when "ARCHIVED"
  		    		app.status = 2
  	    	end
  	    	if item["Meta_Details"][0]
  		    	tags = []
  		    	tags << item["Meta_Details"][0]["Tag"]
  		    	tags << item["Meta_Details"][0]["Category"]
  		    	tags << item["Meta_Details"][0]["Topic"]
  		    	actual_tags = tags.flatten
            app.official_tags = []
  		    	actual_tags.each do |tag|
  		    		if !tag.blank?
  			    		app.official_tags << OfficialTag.find_or_create_by(tag_text: tag)
  			    	end
  		    	end
  		    end
  	    	contacts = item["Contact"].map{|item| item["Email1"]}
          app.users = []
  	    	contacts.each do |contact|
  	    		user = User.find_by(email: contact)
  	    		if user
  	    			app.users << user
  	    		end
  	    	end
          app.mobile_app_versions = []
  	    	if item["Version_Details"] && ["Version_Details"] != []
  		    	item["Version_Details"].each do |version_details|
  		    		mobile_app_version = MobileAppVersion.find_or_create_by(mongo_id: version_details["_id"]["$oid"])
  		    		mobile_app_version.store_url = version_details["Store_Url"]
  		    		mobile_app_version.platform = version_details["Platform"]
  		    		mobile_app_version.version_number = version_details["Version_Number"]
  		    		date = Time.now
  		    		if(version_details["Published"] =~ /\d{2}\/\d{2}\/\d{4}/)
  		    			date = Date.strptime(version_details["Published"], "%m/%d/%Y")
  		    		elsif(version_details["Published"].empty?)
  		    			date = Time.at(item["created"].to_i).iso8601.to_date
  		    		else
  		    			attempt_date = Date.parse(version_details["Published"]) rescue nil
  		    			if attempt_date
  		    				date = attempt_date
  		    			end
  		    		end
  		    		mobile_app_version.publish_date = date
  		    		mobile_app_version.description = version_details["Description"]
  		    		mobile_app_version.whats_new = version_details["Whats_New"]
  		    		mobile_app_version.screenshot = version_details["Screenshot"].empty? ? "" : version_details["Screenshot"].join("\n")
  		    		mobile_app_version.device = version_details["Device"][0]
  		    		mobile_app_version.language = version_details["Language"] == "EN" ? "English" : "Spanish"
  		    		mobile_app_version.average_rating = version_details["Rating"]
  		    		mobile_app_version.number_of_ratings = version_details["Rating_Count"]
  		    		mobile_app_version.save(:validate => false)
  		    		app.mobile_app_versions << mobile_app_version

  		    	end
  		    end
  	    	app.save(:validate => false)
  	    end

  	else
  		puts "provide a file path relative to current working directory (or absolute)"
  	end
  end

  desc "Update versions languages"
  task :fix_languages, [:file] => :environment do |t, args|
  	filepath= args[:file] || "data/current/registrations.json"
  	PublicActivity.enabled = false
    	Gallery.skip_callback(:save)
    	MobileApp.skip_callback(:save)
    	MobileAppVersion.skip_callback(:save)
    	Gallery.skip_callback(:create)
    	MobileApp.skip_callback(:create)
    	MobileAppVersion.skip_callback(:create)
  	if filepath
  	    File.readlines(filepath).each do |f|
  	      item = JSON.load( f )
  	    	if item["Version_Details"] && ["Version_Details"] != []
  		    	item["Version_Details"].each do |version_details|
  		    		language = version_details["Language"] == "EN" ? "English" : nil
  		    		language =  version_details["Language"] == "ES" ? "Spanish" : language
  		    		MobileAppVersion.where(mongo_id: 
  		    					version_details["_id"]["$oid"]).update_all(language: language)
  		    	end
  		end
  	    end

  	else
  		puts "provide a file path relative to current working directory (or absolute)"
  	end
  end
  
  desc "Fill galleries"
  task :galleries, [:file] => :environment do |t, args|
  	filepath= args[:file] || "data/current/galleries.json"
  	PublicActivity.enabled = false
    Gallery.skip_callback(:save)
    MobileApp.skip_callback(:save)
    MobileAppVersion.skip_callback(:save)
    Gallery.skip_callback(:create)
    MobileApp.skip_callback(:create)
    MobileAppVersion.skip_callback(:create)
  	if filepath

      File.readlines(filepath).each do |f|
        item = JSON.load( f )
      	gallery = Gallery.find_or_create_by(name: item["Name"],long_description: item["Description"])
      	
      	registrations = item["Registration"].map{|item| item["Id"]}

        gallery.mobile_apps = []
      	registrations.each do |registration|
      		mobile_app = MobileApp.find_by(mongo_id: registration)
      		if mobile_app
  	    		gallery.mobile_apps << mobile_app
  	    	end
      	end
        gallery.users = []
      	contacts = item["Contact"].map{|item| item["Email1"]}
      	contacts.each do |contact|
      		user = User.find_by(email: contact)
      		if user
      			gallery.users << user
      		end
      	end
      	gallery.save(:validate => false)
      end

  	else
  		puts "provide a file path relative to current working directory (or absolute)"
  	end
  end
end

namespace :load_apps_gallery_data do
  desc "Fill agencies"
  task :agencies, [:file] => :environment do |t, args|
	filepath= args[:file] || "data/current/agencies.json"
	PublicActivity.enabled = false
	if filepath

		json = nil
	    File.open( filepath, "r" ) do |f|
	        json = JSON.load( f )
	    end

	    json.each do |item|
	    	agency = Agency.find_or_create_by(name: item["Name"])
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
	    File.open( filepath, "r" ) do |f|
	        json = JSON.load( f )
	    end

	    json.each do |item|
	    	user = nil
	    	user = User.find_by(email: item["Email1"])
	    	if user == nil
	    		user = User.new(user: item["Id"])
	    	end
	    	user.email = item["Email1"] ? item["Email1"] : "replace#{rand(100000)}@please.gov"
	    	user.first_name = item["FirstName"]
	    	user.last_name = item["LastName"]
	    	user.agency = Agency.find_by(mongo_id: item["Agency"][0]["Id"])
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
	if filepath

		json = nil
	    File.open( filepath, "r" ) do |f|
	        json = JSON.load( f )
	    end
	    json.each do |item|
	    	app = MobileApp.find_or_create_by(mongo_id: item["Id"])
	    	app.name = item["Name"]
	    	app.short_description = item["Short_Description"]
	    	app.long_description = item["Long_Description"]
	    	app.icon_url = item["Icon"].join(",")
	    	app.language = item["Language"] == "EN" ? "English" : "Spanish"
	    	if item["Agency"][0]
	    		app.agency = Agency.find_by(mongo_id: item["Agency"][0]["Id"])
	    	end
	    	case item["Status"]
		    	when "PUBLIC"
		    		app.status = 1
		    	when "PENDING"
		    		app.status = 0
		    	when "UNDER_REVIEW"
		    		app.status = 2
		    	when "ARCHIVED"
		    		app.status = 3
	    	end
	    	if item["Meta_Details"][0]
		    	tags = []
		    	tags << item["Meta_Details"][0]["Tag"]
		    	tags << item["Meta_Details"][0]["Category"]
		    	tags << item["Meta_Details"][0]["Topic"]
		    	actual_tags = tags.flatten.join(",").downcase
		    	app.tag_list = actual_tags
		    end
	    	contacts = item["Contact"].map{|item| item["Email1"]}
	    	contacts.each do |contact|
	    		user = User.find_by(email: contact)
	    		if user
	    			app.users << user
	    		end
	    	end
	    	app.save!
	    end

	else
		puts "provide a file path relative to current working directory (or absolute)"
	end
  end

  desc "Fill galleries"
  task :galleries, [:file] => :environment do |t, args|
	filepath= args[:file] || "data/current/galleries.json"
	PublicActivity.enabled = false
	if filepath

		json = nil
	    File.open( filepath, "r" ) do |f|
	        json = JSON.load( f )
	    end

	    json.each do |item|
	    	gallery = Gallery.find_or_create_by(name: item["Name"],description: item["Description"])
	    	
	    	registrations = item["Registration"].map{|item| item["Id"]}

	    	registrations.each do |registration|
	    		gallery.mobile_apps << MobileApp.find_by(mongo_id: registration)
	    	end

	    	contacts = item["Contact"].map{|item| item["Email1"]}
	    	contacts.each do |contact|
	    		user = User.find_by(email: contact)
	    		if user
	    			gallery.users << user
	    		end
	    	end

	    	gallery.save!
	    end

	else
		puts "provide a file path relative to current working directory (or absolute)"
	end
  end
end

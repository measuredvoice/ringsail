namespace :generate_data do
  desc "Fill database with basic data"
  task :generate => :environment do
    agencies = Agency.order(name: :asc).page(0).per(25)
    tags = ActsAsTaggableOn::Tag.order(name: :asc).page(0).per(25)
    outlets = Outlet.order(organization: :asc).page(0).per(25)

    json_object = []
    (0..24).each do |item|
    	json_object << {id: "agency_id:#{agencies[item].id}", name: agencies[item].name }
    	json_object << {id: "tag_id:#{tags[item].id}", name: tags[item].name }
    	json_object << {id: "outlet_id:#{outlets[item].id}", name: outlets[item].organization }
    end

    File.open("testdata.json", 'w') { |file| file.write(json_object.to_json) }
  end

  # This outputs raw counts per agency (not by service, attempts to de-dup based on parent/child)

  task :report_agency_counts => :environment do 
    agency_counts = {}
    Outlet.includes(:agencies).references(:agencies).all.each do |account|
      agency = account.agencies.first

      while(agency.parent)
        agency = agency.parent
      end
      if agency_counts[agency.name.to_s]
        agency_counts[agency.name.to_s] = agency_counts[agency.name.to_s] + 1
      else
        agency_counts[agency.name.to_s] = 1
      end
    end
    puts agency_counts.inspect
    CSV.open("reports/agency_counts.csv", 'wb') { |csv| 
      csv << ["agency","number of accounts"]
      agency_counts.each do |(key,val)| 
        csv << [key.to_s, val.to_s]
      end
    }
  end


  # this reports one per "parent agency"
  task :report_agency_counts_by_service => :environment do 
    agency_counts = {}
    #prepare array
    services = Admin::Service.all.map{|item| item.shortname}
    Agency.all.each do |agency|
      agency_counts[agency.name] = {}
      services.each do |service|
        agency_counts[agency.name][service] = 0
      end
    end
    Outlet.includes(:agencies).references(:agencies).all.each do |account|
      agency = account.agencies.first

      while(agency.parent)
        agency = agency.parent
      end
      agency_counts[agency.name.to_s][account.service] = agency_counts[agency.name.to_s][account.service] + 1
    end
    puts agency_counts.inspect
    CSV.open("reports/agency_counts_by_service.csv", "wb"){ |csv| 
      csv << ['agency'] + services
      agency_counts.each do |(key,val)| 
        row = []
        row << key.to_s
        services.each do |service|
          row << agency_counts[key][service].to_s
        end
        csv << row
      end
    }
  end

  # This task goes by agency listed on account, raw data
  task :report_agency_counts_by_service_raw => :environment do 
    agency_counts = {}
    #prepare array
    services = Admin::Service.all.map{|item| item.shortname}
    Agency.all.each do |agency|
      agency_counts[agency.name] = {}
      services.each do |service|
        agency_counts[agency.name][service] = 0
      end
    end
    Agency.all.each do |agen|
      services.each do |service|
        agency_counts[agen.name.to_s][service] = Outlet.where(:agencies => { :id => agen.id }, :service => service,created_at:Time.new(2005,1,1)..Time.new(2017,8,31), updated_at: Time.new(2018, 4, 20)..Time.new(2018,9,31)).includes(:agencies).references(:agencies).count    
      end
    end
    puts agency_counts.inspect
    CSV.open("reports/agency_counts_raw_updated_since_purge_fiscal_2018.csv", "wb"){ |csv| 
      csv << ['agency'] + services
      agency_counts.each do |(key,val)| 
        row = []
        row << key.to_s
        services.each do |service|
          row << agency_counts[key][service].to_s
        end
        csv << row
      end
    }
  end


  task :report_services => :environment do 
    services = Admin::Service.all.map{|item| item.shortname}
    service_counts = {}
    services.each do |service|
      service_counts[service] = Outlet.where(:service => service).includes(:agencies).references(:agencies).all.count
    end
    puts service_counts.inspect
    CSV.open("reports/service_counts.csv", 'wb') { |csv| 
      csv << ["service","counts"]
      service_counts.each do |(key,val)| 
        csv << [key.to_s, val.to_s]
      end
    }
  end

  task :report_created_time_month => :environment do 
    # services = Admin::Service.all.map{|item| item.shortname}
    @outlets = Outlet.all
    @outlet_months = @outlets.group_by { |t| t.created_at.beginning_of_month }
    
    
    CSV.open("reports/months_created_outlets.csv", 'wb') { |csv| 
      csv << ["month","counts"]
      @outlet_months.each do |outlet_month|
        csv << [outlet_month[0],outlet_month[1].count]
      end
    }
    # CSV.open("reports/service_counts.csv", 'wb') { |csv| 
    #   csv << ["service","counts"]
    #   service_counts.each do |(key,val)| 
    #     csv << [key.to_s, val.to_s]
    #   end
    # }
  end

   task :report_created_time_year => :environment do 
    # services = Admin::Service.all.map{|item| item.shortname}
    @outlets = Outlet.all
    @outlet_months = @outlets.group_by { |t| t.created_at.beginning_of_year }
    
    
    CSV.open("reports/years_created_outlets.csv", 'wb') { |csv| 
      csv << ["month","counts"]
      @outlet_months.each do |outlet_month|
        csv << [outlet_month[0],outlet_month[1].count]
      end
    }
    # CSV.open("reports/service_counts.csv", 'wb') { |csv| 
    #   csv << ["service","counts"]
    #   service_counts.each do |(key,val)| 
    #     csv << [key.to_s, val.to_s]
    #   end
    # }
  end

   task :report_users => :environment do 
    
    @users = User.all.group_by(&:email)
   
    current_time = DateTime.now.strftime("%Y%m%d%H%M%S")
    CSV.open("reports/users_#{current_time}.csv", 'wb') { |csv| 
      csv << ["email","agency","role","sigh_in_count","last_sign_in"]
      @users.each do |user|  
        last_sign_in = user[1][0].last_sign_in_at ? user[1][0].last_sign_in_at.strftime("%B %e, %Y %H:%M %Z") : ""
        csv << [
          user[1][0].email,
          user[1][0].try(:agency).try(:name),
          user[1][0].role.try(:humanize),
          user[1][0].sign_in_count,
          last_sign_in
        ]
      end
    }
    # CSV.open("reports/service_counts.csv", 'wb') { |csv| 
    #   csv << ["service","counts"]
    #   service_counts.each do |(key,val)| 
    #     csv << [key.to_s, val.to_s]
    #   end
    # }
  end

end

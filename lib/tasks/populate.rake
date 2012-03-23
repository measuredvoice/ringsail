namespace :db do
  desc "Fill database with basic data"
  task :populate => :environment do
    make_agencies
    make_official_tags
  end
  task :forcerefresh => :environment do
    make_agencies(:force => true)
    make_official_tags(:force => true)
    make_accounts
  end
end

def make_agencies(options = {})
  agencies_file = Rails.root + "db/raw_data/agencies.csv"
  
  CSV.foreach(agencies_file) do |row|
    attrs = {:name => row[0], :info_url => row[1], :shortname => row[2]}

    agency = Agency.find_or_create_by_shortname(attrs)
    
    if (options[:force])
      agency.assign_attributes(attrs)
      puts "Forcing refresh for '#{agency.shortname}'" if agency.changed?
      agency.save
    end
  end
end

def make_official_tags(options = {})
  tags_file = Rails.root + "db/raw_data/official-tags.csv"
  
  CSV.foreach(tags_file) do |row|
    attrs = {:tag_text => row[0],}
    if OfficialTag.find_by_tag_text(attrs[:tag_text]).nil?
      OfficialTag.create(attrs)
    end
  end
end

def make_accounts(options = {})
  accounts_file = Rails.root + "db/raw_data/accounts.csv"
  
  CSV.foreach(accounts_file) do |row|
    attrs = {
      :info_url => row[0], 
      :organization => row[1],
      :language => row[4],
    }
    if attrs[:info_url] && attrs[:info_url] !~ %r{(?i)\Ahttps?://}
      attrs[:info_url] = 'http://' + attrs[:info_url] 
    end
    agencies = row[2].split(/\s*,\s*/).flat_map do |s|
      Agency.find_by_shortname(s) || []
    end
    service_url = row[3]
    tag_list = row[5]
    puts service_url

    if (account = Outlet.resolve(service_url))
      account.assign_attributes(attrs)
      account.agencies = agencies
      account.tag_list = tag_list
      account.save!
    else
      puts "--- Can't add account: (#{service_url})"
    end
  end
end

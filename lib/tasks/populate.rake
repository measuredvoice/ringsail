namespace :db do
  desc "Fill database with basic data"
  task :populate => :environment do
    make_agencies
    make_official_tags
  end
end

def make_agencies
  agencies_file = Rails.root + "db/raw_data/agencies.csv"
  
  CSV.foreach(agencies_file) do |row|
    attrs = {:name => row[0], :info_url => row[1], :shortname => row[2]}
    Agency.find_or_create_by_shortname(attrs)
  end
end

def make_official_tags
  tags_file = Rails.root + "db/raw_data/official-tags.csv"
  
  CSV.foreach(tags_file) do |row|
    attrs = {:tag_text => row[0],}
    if OfficialTag.find_by_tag_text(attrs[:tag_text]).nil?
      OfficialTag.create(attrs)
    end
  end
end


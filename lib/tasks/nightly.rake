require 'open-uri'
namespace :nightly do

  desc "Pull Government Urls Data"
  task :pull_government_urls, [:file] => :environment do |t,args|
    open('nightly_government_urls.csv', 'wb') do |file|
      file << open('https://raw.githubusercontent.com/GSA/govt-urls/master/2_govt_urls_federal_only.csv').read
    end
    CSV.foreach('nightly_government_urls.csv', :headers => true) do |row|
      url_record = GovernmentUrl.find_or_create_by(url: row[0])
      url_record.federal_agency = row[1]
      url_record.level_of_government = row[2]
      url_record.location = row[3]
      url_record.status = row[4]
      url_record.note = row[5]
      url_record.link = row[6]
      url_record.date_added = row[7]
      url_record.save

      ELASTIC_SEARCH_CLIENT.index  index: 'government_urls',
        type: 'government_url',
        id: url_record.id,
        body: url_record.as_indexed_json
    end
    begin
      File.open('nightly_government_urls.csv', 'r') do |f|
        File.delete(f)
      end
    rescue Errno::ENOENT
    end
  end

  desc "Update Mobile Apps Nightly"
  task :update_elastic_search_mobile_apps, [:file] => :environment do |t,args|
    ENV['CLASS'] = "MobileApp"
    ENV['FORCE'] = 'y'
    Rake::Task['elasticsearch:import:model'].invoke()
  end

  desc "Update Social Media Accounts Nightly"
  task :update_elastic_search_social_media, [:file] => :environment do |t,args|
    ENV['CLASS'] = "Outlet"
    ENV['FORCE'] = 'y'
    Rake::Task['elasticsearch:import:model'].invoke()
  end
end

require 'json'

namespace :agencies do
  
  desc "load formatted JSON data into system for agencies"
  task :update, [:file] => :environment do |t, args|
    begin
      PublicActivity.enabled = false
      filepath = "agency-contacts.json"
      raise 'No file path specified'  if filepath == nil 
      raise "No file found at #{filepath}" if !File.exists?(filepath)
      agencies = JSON.parse File.read(filepath)
      agencies = agencies["Contact"]
      english_agencies = []
      agencies.each do |agency| english_agencies << agency if agency["Language"] == "en" end
      english_agencies.each do |agency_api| 
        agency = Agency.find_by(api_id: agency_api["Id"])
        agency = Agency.find_or_create_by(name: agency_api["Name"]) if agency == nil
        agency.name = agency_api["Name"]
        agency.api_id = agency_api["Id"]
        agency.save(validate: false)
      end 
      puts "Imported all Agencies"
      puts "Agencies without API Mappings: #{Agency.where(api_id: nil).count}"
      puts Agency.where(api_id: nil).map(&:id).join("\n\r")
    rescue Exception => e
      puts "There was an error: #{e}"
      raise e
    end
  end

end

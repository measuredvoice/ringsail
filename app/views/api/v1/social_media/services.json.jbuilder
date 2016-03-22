json.metadata do
  json.set! :count, @services.count
end
json.results do 
  json.array! @services do |service|
    json.service_key service[0]
    json.service_display_name Admin::Service.find_by_shortname(service[0]).longname
    json.social_media_accounts service[1]
  end
end
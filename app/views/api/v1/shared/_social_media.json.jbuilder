json.set! :id, outlet.id
json.set! :organizaton, outlet.organization
json.set! :account, outlet.account
json.set! :service, outlet.service
json.set! :service_url, outlet.service_url
json.set! :info_url, outlet.info_url
json.set! :language, outlet.language
json.agencies do 
  outlet.agencies.each do |agency|
    json.partial! "api/v1/shared/agency", agency: agency
  end
end
json.tags do
  outlet.official_tags.each do |tag|
    json.partial! "api/v1/shared/official_tag", official_tag: tag
  end
end
json.set! :created_at, outlet.created_at
json.set! :udpated_at, outlet.updated_at

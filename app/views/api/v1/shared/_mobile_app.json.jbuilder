json.set! :id, mobile_app.id
json.set! :name, mobile_app.name
json.set! :short_description, mobile_app.short_description
json.set! :long_description, mobile_app.long_description
json.set! :icon_url, mobile_app.icon_url
json.set! :language, mobile_app.language
json.agencies do
  mobile_app.agencies.each do |agency|
    json.partial! "api/v1/shared/agency", agency: agency
  end
end
json.tags do
  mobile_app.official_tags.each do |tag|
    json.partial! "api/v1/shared/official_tag", official_tag: tag
  end
end
json.versions do
  mobile_app.mobile_app_versions do |version|
    json.set! :store_url, version.store_url
    json.set! :platform, version.platform
    json.set! :version_number, version.version_number
    json.set! :publish_date, version.publish_date
    json.set! :description, version.description
    json.set! :whats_new, version.whats_new
    json.set! :screenshot, version.screenshot
    json.set! :device, version.device
    json.set! :language, version.language
    json.set! :average_rating, version.average_rating
    json.set! :number_of_ratings, version.number_of_ratings
  end
end
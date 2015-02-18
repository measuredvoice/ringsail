json.array! @items do |item|
  if item.class == Service
    json.set! :key, "service&&&#{item.shortname}"
    json.set! :name, "Service: #{item.longname}"
    json.set! :count, @service_breakdown[item.shortname.to_s]
  elsif item.class == Agency
    json.set! :key, "agency&&&#{item.id}"
    json.set! :name, "Agency: #{item.name}"
    json.set! :count, item.published_mobile_app_count
  elsif item.class == OfficialTag
    json.set! :key, "tag&&&#{item.id}"
    json.set! :name, "Tag: #{item.tag_text}"
    json.set! :count, item.published_mobile_app_count
  else
    json.set! :key, "text&&&#{item}"
    json.set! :name, "Text: #{item}"
  end

end 
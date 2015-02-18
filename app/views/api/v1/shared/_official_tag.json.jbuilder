json.set! :id, official_tag.id
json.set! :tag_text, official_tag.tag_text
if counts
  json.set! :social_media_count, official_tag.published_outlet_count
  json.set! :mobile_app_count, official_tag.published_mobile_app_count
  json.set! :gallery_count, official_tag.published_gallery_count
end
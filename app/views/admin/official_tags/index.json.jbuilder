json.data @official_tags do |official_tag|
  json.set! "DT_RowId", official_tag.id
  json.set! :tag_text, official_tag.tag_text
  json.set! :tag_type, official_tag.tag_type
  json.set! :outlet_counts, "#{official_tag.draft_outlet_count} (#{official_tag.published_outlet_count})"
  json.set! :mobile_counts, "#{official_tag.draft_mobile_app_count} (#{official_tag.published_mobile_app_count})"
  json.set! :gallery_counts, "#{official_tag.draft_gallery_count} (#{official_tag.published_gallery_count})"
end
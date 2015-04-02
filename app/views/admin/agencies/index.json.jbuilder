json.data @agencies do |agency|
  json.set! "DT_RowId", agency.id
  json.set! :name, agency.name
  json.set! :outlet_counts, "#{agency.draft_outlet_count} (#{agency.published_outlet_count})"
  json.set! :mobile_counts, "#{agency.draft_mobile_app_count} (#{agency.published_mobile_app_count})"
  json.set! :gallery_counts, "#{agency.draft_gallery_count} (#{agency.published_gallery_count})"
end
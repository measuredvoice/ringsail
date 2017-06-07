json.data @agencies do |agency|
  json.set! "DT_RowId", agency.id
  json.set! :name, agency.name
  json.set! :parent_name, agency.parent ? agency.parent.name : ""
  json.set! :outlet_counts, "#{agency.draft_outlet_count} (#{agency.published_outlet_count})"
  json.set! :mobile_counts, "#{agency.draft_mobile_app_count} (#{agency.published_mobile_app_count})"
end
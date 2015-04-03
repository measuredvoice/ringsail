json.data @galleries do |gallery|
  json.set! "DT_RowId", gallery.id
  json.set! :agencies, gallery.agencies.map(&:name)
  json.set! :name, gallery.name
  json.set! :tags, gallery.official_tags.map(&:tag_link)
  json.set! :outlet_count, gallery.outlets.count
  json.set! :mobile_app_count, gallery.mobile_apps.count
  json.set! :status, gallery.status.try(:humanize)
  json.set! :updated_at, gallery.updated_at.strftime("%B %e, %Y %H:%M %Z")
end
json.set! :id, gallery.id
json.set! :name, gallery.name
json.set! :description, gallery.description
json.set! :mobile_apps_count, gallery.mobile_apps.count
json.set! :social_media_count, gallery.outlets.count
json.tags do
  json.array! gallery.official_tags, partial: "api/v1/shared/official_tag", as: :official_tag
end
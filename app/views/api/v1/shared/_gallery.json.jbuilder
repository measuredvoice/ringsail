json.set! :id, gallery.id
json.set! :name, gallery.name
json.set! :short_description, gallery.short_description
json.set! :long_description, gallery.long_description
json.set! :mobile_apps_count, gallery.published_mobile_app_count
json.set! :social_media_count, gallery.published_outlet_count
json.tags do
  json.array! gallery.official_tags, partial: "api/v1/shared/official_tag", as: :official_tag, counts: false
end
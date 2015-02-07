json.set! :id, gallery.id
json.set! :name, gallery.name
json.set! :description, gallery.description
json.set! :mobile_apps_count, gallery.published_mobile_apps.where(status: 1).count
json.set! :social_media_count, gallery.published_outlets.where(status: 1).count
json.tags do
  json.array! gallery.official_tags, partial: "api/v1/shared/official_tag", as: :official_tag, counts: false
end
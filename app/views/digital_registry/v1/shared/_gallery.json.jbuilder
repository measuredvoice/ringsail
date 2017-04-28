json.set! :id, gallery.draft_id
json.set! :name, gallery.name
json.set! :short_description, gallery.short_description
json.set! :long_description, gallery.long_description
json.set! :mobile_apps_count, gallery.mobile_apps.count
json.set! :social_media_count, gallery.outlets.count
json.tags do
  json.array! gallery.official_tags, partial: "digital_registry/v1/shared/official_tag", as: :official_tag, locals: {include_counts: false}
end
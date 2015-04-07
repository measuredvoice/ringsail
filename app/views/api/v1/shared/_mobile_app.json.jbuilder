json.set! :id, mobile_app.draft_id
json.set! :name, mobile_app.name
json.set! :short_description, mobile_app.short_description
json.set! :long_description, mobile_app.long_description
json.set! :icon_url, mobile_app.icon_url
json.set! :language, mobile_app.language
json.agencies do
  json.array! mobile_app.agencies, partial: "api/v1/shared/agency", as: :agency
end
json.tags do
  json.array! mobile_app.official_tags, partial: "api/v1/shared/official_tag", as: :official_tag, counts: false
end
if show_versions
  json.versions do
    json.array! mobile_app.mobile_app_versions, partial: "api/v1/shared/mobile_app_version", as: :version
  end
end
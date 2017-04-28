json.set! :id, outlet.draft_id
json.set! :organization, outlet.organization
json.set! :account, outlet.account
json.set! :service_key, outlet.service
json.set! :short_description, outlet.short_description
json.set! :long_description, outlet.long_description
json.set! :service_display_name, Admin::Service.find_by_shortname(outlet.service).longname
json.set! :service_url, outlet.service_url
json.set! :language, outlet.language
json.agencies do
  json.array! outlet.agencies, partial: "digital_registry/v1/shared/agency", as: :agency, locals: {include_counts: false}
end
json.tags do
  json.array! outlet.official_tags, partial: "digital_registry/v1/shared/official_tag", as: :official_tag, locals: {include_counts: false}
end
json.set! :created_at, outlet.created_at
json.set! :updated_at, outlet.updated_at

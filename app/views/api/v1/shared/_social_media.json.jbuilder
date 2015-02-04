json.set! :id, outlet.id
json.set! :organizaton, outlet.organization
json.set! :account, outlet.account
json.set! :service, outlet.service
json.set! :service_url, outlet.service_url
json.set! :info_url, outlet.info_url
json.set! :language, outlet.language
json.agencies do
  json.array! outlet.agencies, partial: "api/v1/shared/agency", as: :agency
end
json.tags do
  json.array! outlet.official_tags, partial: "api/v1/shared/official_tag", as: :official_tag
end
json.set! :created_at, outlet.created_at
json.set! :udpated_at, outlet.updated_at

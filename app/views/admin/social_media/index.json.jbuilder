json.data @outlets do |outlet|
  json.set! :id, outlet.id
  json.set! "DT_RowId", outlet.id
  json.set! :agencies, outlet.agencies.map(&:name)
  json.set! :service, outlet.service
  json.set! :account_name, outlet.organization
  json.set! :tags, outlet.official_tags.map(&:tag_link)
  json.set! :status, outlet.status.humanize
  json.set! :updated_at, outlet.updated_at.strftime("%B %e, %Y %H:%M %Z")
end
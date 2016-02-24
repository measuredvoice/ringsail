json.data @outlets do |outlet|
  json.set! "DT_RowId", outlet.id
  json.set! :agencies, outlet.agencies.map(&:name)
  json.set! :service, outlet.service
  json.set! :account_name, !outlet.organization.blank? ? outlet.organization : "n/a" 
  json.set! :account, outlet.account
  json.set! :status, outlet.status.humanize
  json.set! :updated_at, outlet.updated_at.strftime("%m/%d/%Y %H:%M %Z")
end

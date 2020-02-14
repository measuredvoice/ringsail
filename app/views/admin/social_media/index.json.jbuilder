json.set! "sEcho", params["sEcho"]
json.set! "iTotalRecords", @total_outlets
json.set! "iTotalDisplayRecords", @result_count
json.aaData @outlets do |outlet|
  json.set! "DT_RowId", outlet.id
  json.set! :agencies, outlet.agencies
  json.set! :contacts, outlet.contacts
  json.set! :service, Admin::Service.find_by_shortname(outlet.service).longname
  json.set! :account_name, outlet.account_name ? outlet.account_name : "n/a"
  json.set! :account, outlet.account
  json.set! :status, outlet.status.humanize
  json.set! :updated_at, Time.parse(outlet.updated_at).strftime("%m/%d/%Y %H:%M %Z")
end

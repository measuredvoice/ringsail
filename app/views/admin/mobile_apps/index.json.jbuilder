json.set! "sEcho", params["sEcho"]
json.set! "iTotalRecords", @total_mobile_apps
json.set! "iTotalDisplayRecords", @result_count
json.aaData @mobile_apps do |mobile_app|
  json.set! "DT_RowId", mobile_app.id
  json.set! :agencies, mobile_app.agencies
  json.set! :contacts, mobile_app.contacts
  json.set! :name, mobile_app.name
  json.set! :status, mobile_app.status.humanize
  json.set! :updated_at, Time.parse(mobile_app.updated_at).strftime("%m/%d/%Y %H:%M %Z")
end

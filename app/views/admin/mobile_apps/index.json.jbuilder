json.data @mobile_apps do |mobile_app|
  json.set! "DT_RowId", mobile_app.id
  json.set! :agencies, mobile_app.agencies.map(&:name)
  json.set! :contacts, mobile_app.users.map(&:email)
  json.set! :name, mobile_app.name
  json.set! :status, mobile_app.status.humanize
  json.set! :updated_at, mobile_app.updated_at.strftime("%m/%d/%Y %H:%M %Z")
  end

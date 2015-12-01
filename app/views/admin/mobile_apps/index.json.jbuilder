json.data @mobile_apps do |mobile_app|
  json.set! "DT_RowId", mobile_app.id
  json.set! :agencies, mobile_app.agencies.map(&:name)
  json.set! :name, mobile_app.name
  json.set! :status, mobile_app.status.humanize
  json.set! :updated_at, mobile_app.updated_at.strftime("%B %e, %Y %H:%M %Z")
  end

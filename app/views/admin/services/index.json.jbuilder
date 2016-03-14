json.data @admin_services do |service|
  json.set! "DT_RowId", service.id
  json.set! :name, service.longname
  json.set! :url_example, service.service_url_example
  json.set! :archived, service.archived
end

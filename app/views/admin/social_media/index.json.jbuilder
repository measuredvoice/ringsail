json.data @outlets do |outlet|
  json.set! :id, outlet.id
  json.set! :agencies, outlet.agencies.map(&:name)
  json.set! :service, outlet.service
  json.set! :account_name, outlet.organization
  json.set! :tags, outlet.official_tags.map(&:tag_link)
  json.set! :status, outlet.status.humanize
  json.set! :updated_at, outlet.updated_at.strftime("%B %e, %Y %H:%M %Z")
  json.set! :links, ["#{link_to "<i class =\"glyphicon glyphicon-info-sign\"></i>".html_safe, admin_outlet_path(outlet)}",
    "#{link_to "<i class = \"glyphicon glyphicon-pencil\"></i>".html_safe,edit_admin_outlet_path(outlet)}"]
end
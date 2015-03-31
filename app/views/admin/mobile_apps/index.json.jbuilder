json.data @mobile_apps do |mobile_app|
  json.set! :id, mobile_app.id
  json.set! :agencies, mobile_app.agencies.map(&:name)
  json.set! :name, mobile_app.name
  json.set! :tags, mobile_app.official_tags.map(&:tag_link)
  json.set! :status, mobile_app.status.humanize
  json.set! :updated_at, mobile_app.updated_at.strftime("%B %e, %Y %H:%M %Z")
  json.set! :links, ["#{link_to "<i class =\"glyphicon glyphicon-info-sign\"></i>".html_safe, admin_mobile_app_path(mobile_app)}",
    "#{link_to "<i class = \"glyphicon glyphicon-pencil\"></i>".html_safe,edit_admin_mobile_app_path(mobile_app) }"]
end
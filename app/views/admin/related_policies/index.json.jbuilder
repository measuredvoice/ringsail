json.data @related_policies do |related_policy|
  json.set! :title, related_policy.title
  json.set! :url, related_policy.url
  json.set! :service, related_policy.service
  json.set! "DT_RowId", related_policy.id
end
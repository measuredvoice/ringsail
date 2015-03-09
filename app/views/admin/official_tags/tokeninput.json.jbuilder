json.array! @official_tags do |official_tag|
  json.id official_tag.id
  json.name "#{official_tag.tag_type.humanize}: #{official_tag.tag_text}"
end
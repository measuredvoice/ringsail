json.array! @official_tags do |official_tag|
  json.id official_tag.tag_text
  json.name official_tag.tag_text
end

json.array! @tags do |tag|
  json.id tag.id
  json.name tag.tag_text
end
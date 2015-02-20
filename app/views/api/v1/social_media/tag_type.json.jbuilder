json.array! @tag_type_counts do |item|
  json.set! :type, OfficialTag.tag_types[item[0]]
  json.set! :count, item[1]
end
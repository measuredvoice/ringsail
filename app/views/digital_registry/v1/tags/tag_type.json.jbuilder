json.metadata do 
  json.count @tag_type_counts.count
end
json.results do
  json.array! @tag_type_counts do |item|
    json.set! :id, item[0]
    json.set! :type, OfficialTag.tag_types.keys[item[0]]
    json.set! :count, item[1]
  end
end
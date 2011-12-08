Boxer.box(:official_tag) do |box, tag|
  {
    :tag_id    => tag.shortname,
    :tag_text  => tag.tag_text,
  }
end

Boxer.box(:official_tags) do |box, tags|
  {
    :page_count => 1,
    :total_items => tags.count,
    :tags => tags.map { |tag| Boxer.ship(:official_tag, tag) },
  }
end

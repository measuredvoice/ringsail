Boxer.box(:agency) do |box, agency|
  {
    :name       => agency.name,
    :shortname  => agency.shortname,
  }
end

Boxer.box(:agencies) do |box, agencies|
  {
    :page_count => agencies.total_pages,
    :total_items => agencies.total_entries,
    :page_number => agencies.current_page,
    :page_size => agencies.per_page,
    :agencies => agencies.map { |agency| Boxer.ship(:agency, agency) },
  }
end

Boxer.box(:agency) do |box, agency|
  {
    :agency_id    => agency.shortname,
    :agency_name  => agency.name,
  }
end

Boxer.box(:agencies) do |box, agencies|
  {
    :page_count => agencies.num_pages,
    :total_items => agencies.total_count,
    :page_number => agencies.current_page,
    :agencies => agencies.map { |agency| Boxer.ship(:agency, agency) },
  }
end

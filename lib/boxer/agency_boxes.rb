Boxer.box(:agency) do |box, agency|
  {
    :name       => agency.name,
    :shortname  => agency.shortname,
  }
end

Boxer.box(:agencies) do |box, agencies|
  {
    :page_count => 1,
    :total_items => agencies.count,
    :agencies => agencies.map { |agency| Boxer.ship(:agency, agency) },
  }
end

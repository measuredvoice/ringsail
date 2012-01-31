Boxer.box(:service) do |box, service|
  {
    :name       => service.name,
    :shortname  => service.shortname,
  }
end

Boxer.box(:services) do |box, services|
  {
    :page_count => 1,
    :total_items => services.count,
    :services => services.map { |service| Boxer.ship(:service, service) },
  }
end

Boxer.box(:service) do |box, service|
  {
    :service_id   => service.shortname,
    :service_name => service.longname,
  }
end

Boxer.box(:services) do |box, services|
  {
    :page_count => 1,
    :total_items => services.count,
    :page_number => 1,
    :services => services.map { |service| Boxer.ship(:service, service) },
  }
end

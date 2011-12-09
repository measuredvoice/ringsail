Boxer.box(:location) do |box, location|
  {
    :location_id    => location.woe_id,
    :location_name  => location.display_name,
    :location_type  => location.location_type,
  }
end

Boxer.box(:locations) do |box, locations|
  {
    :default_id   => locations.empty? ? '' : locations[0].woe_id,
    :default_name => locations.empty? ? '' : locations[0].display_name,
    :default_type => locations.empty? ? '' : locations[0].location_type,
    :locations => locations.map { |l| Boxer.ship(:location, l) },
  }
end

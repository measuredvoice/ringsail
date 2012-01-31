Boxer.box(:outlet) do |box, outlet|
  box.view(:base) do
    {
      :service_url  => outlet.service_url,
      :verified     => outlet.verified?,
      :service      => outlet.service,
      :account      => outlet.account,
    }
  end
  box.view(:brief, :extends => :base) do
    if outlet.verified?
      {
        :details_url  => outlet.details_url,
        :agencies     => outlet.agencies.map { |agency| Boxer.ship(:agency, agency) },
        :organization => outlet.organization,
      }
    else
      {}
    end
  end
  box.view(:full, :extends => :brief) do
    if outlet.verified?
      {
        :info_url     => outlet.info_url,
        :agencies     => outlet.agencies.map { |agency| Boxer.ship(:agency, agency) },
        :language     => outlet.language,
        :display_name => outlet.service_info.display_name,
        :tags         => outlet.tags.map { |tag| tag.name },
        :updated_at   => outlet.updated_at.to_s(:iso),
        :updated_by   => outlet.masked_updated_by,
      }
    else
      {}
    end
  end
end

Boxer.box(:outlets) do |box, outlets|
  {
    :page_count => outlets.total_pages,
    :total_items => outlets.total_entries,
    :page_number => outlets.current_page,
    :page_size => outlets.per_page,
    :accounts => outlets.map { |outlet| Boxer.ship(:outlet, outlet, :view => :brief) },
  }
end

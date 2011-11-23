Boxer.box(:outlet) do |box, outlet|
  box.view(:base) do
    {
      :service_url  => outlet.service_url,
      :verified     => outlet.verified?,
      :service      => outlet.service,
      :account      => outlet.account,
    }
  end
  box.view(:full, :extends => :base) do
    if outlet.verified?
      {
        :organization => outlet.organization,
        :info_url     => outlet.info_url,
        :agencies     => outlet.agencies.map { |agency| Boxer.ship(:agency, agency) },
        :language     => outlet.language,
        :display_name => outlet.service_info.display_name,
        :updated_at   => outlet.updated_at.to_s(:iso),
        :updated_by   => (outlet.updated_by || '').gsub(/(\w)\w+@/, '\1*****@'),
      }
    else
      {}
    end
  end
end

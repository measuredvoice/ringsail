Boxer.box(:outlet) do |box, outlet|
  box.view(:base) do
    {
      :service_url  => outlet.service_url,
      :verified     => outlet.verified? ? 'true' : 'false',
      :service      => outlet.service ? outlet.service.shortname : nil,
      :account      => outlet.account,
    }
  end
  box.view(:verified, :extends => :base) do
    {
      :organization => outlet.organization,
      :info_url     => outlet.info_url,
      :agencies     => outlet.agencies.map { |agency| Boxer.ship(:agency, agency) },
      :language     => outlet.language,
      :updated_at   => outlet.updated_at.to_s(:iso),
    }
  end
end

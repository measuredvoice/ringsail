Boxer.box(:outlet) do |box, outlet|
  box.view(:base) do
    {
      :service_url  => outlet.service_url,
      :verified     => outlet.verified? ? 'true' : 'false',
      :service      => outlet.service ? outlet.service.shortname : nil,
      :account      => outlet.account,
      :organization => outlet.organization,
      :info_url     => outlet.info_url,
      :agencies     => outlet.agencies.map { |agency| Boxer.ship(:agency, agency) },
      :language     => outlet.language,
      :updated_at   => outlet.updated_at.to_s(:db), # FIXME: should be ISO 8601
    }
  end
end

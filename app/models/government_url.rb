class GovernmentUrl < ActiveRecord::Base
  include Elasticsearch::Model

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :id, type: :integer
      indexes :url, analyzer: 'english'
      indexes :federal_agency, analyzer: 'english'
      indexes :level_of_government, analyzer: 'english'
      indexes :location, analyzer: 'english'
      indexes :status, analyzer: 'english'
      indexes :note, analyzer: 'english'
      indexes :link, analyzer: 'english'
      indexes :date_added, analyzer: 'english'
      indexes :created_at, type: :date
      indexes :updated_at, type: :date
    end
  end

  def as_indexed_json(options={})
    result = {
      id: self.id,
      url: self.url,
      federal_agency: self.federal_agency,
      level_of_government: self.level_of_government,
      location: self.location,
      status: self.status,
      note: self.note,
      link: self.link,
      date_added: self.date_added,
      created_at: self.created_at,
      updated_at: self.updated_at
    }
    result
  end
end

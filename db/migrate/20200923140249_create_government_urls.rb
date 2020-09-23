class CreateGovernmentUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :government_urls do |t|
      t.string :url
      t.string :federal_agency
      t.string :level_of_government
      t.string :location
      t.string :status
      t.text :note
      t.string :link
      t.string :date_added
      t.timestamps
    end
  end
end

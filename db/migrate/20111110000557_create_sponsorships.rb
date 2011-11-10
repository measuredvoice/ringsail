class CreateSponsorships < ActiveRecord::Migration
  def change
    create_table :sponsorships do |t|
      t.integer :outlet_id
      t.integer :agency_id

      t.timestamps
    end
    add_index :sponsorships, :outlet_id
    add_index :sponsorships, :agency_id
    add_index :sponsorships, [:outlet_id, :agency_id], :unique => true
  end
end

class CreateAgencyContacts < ActiveRecord::Migration
  def change
    create_table :agency_contacts do |t|
      t.string :email
      t.string :agency_id

      t.timestamps
    end
    add_index :agency_contacts, :agency_id
  end
end

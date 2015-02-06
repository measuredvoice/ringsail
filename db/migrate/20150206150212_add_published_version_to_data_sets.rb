class AddPublishedVersionToDataSets < ActiveRecord::Migration
  def change
    add_column :outlets, :draft_id, :integer
    add_column :outlets, :short_description, :text
    add_column :outlets, :long_description, :text
    remove_column :outlets, :updated_by, :string

    add_column :mobile_apps, :draft_id, :integer

    add_column :galleries, :draft_id, :integer
    add_column :galleries, :short_description, :text
    add_column :galleries, :long_description, :text
    add_column :galleries, :status, :integer

    drop_table :agency_contacts
  end
end

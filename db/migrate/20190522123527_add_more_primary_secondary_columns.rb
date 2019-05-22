class AddMorePrimarySecondaryColumns < ActiveRecord::Migration
  def change

    add_column :mobile_apps, :primary_contact_id, :integer
    add_column :mobile_apps, :secondary_contact_id, :integer


    add_column :mobile_apps, :primary_agency_id, :integer
    add_column :mobile_apps, :secondary_agency_id, :integer

    add_column :outlets, :primary_agency_id, :integer
    add_column :outlets, :secondary_agency_id, :integer


    add_column :outlets, :notes, :text
    add_column :mobile_apps, :notes, :text
  end
end

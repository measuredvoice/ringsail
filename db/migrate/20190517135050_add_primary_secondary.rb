class AddPrimarySecondary < ActiveRecord::Migration
  def change


    add_column :outlets, :primary_contact_id, :integer
    add_column :outlets, :secondary_contact_id, :integer
  end
end

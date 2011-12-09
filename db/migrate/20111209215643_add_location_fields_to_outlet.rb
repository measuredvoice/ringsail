class AddLocationFieldsToOutlet < ActiveRecord::Migration
  def change
    add_column :outlets, :location_id, :integer
    add_column :outlets, :location_name, :string
  end
end

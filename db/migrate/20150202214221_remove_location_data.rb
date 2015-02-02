class RemoveLocationData < ActiveRecord::Migration
  def change
    remove_column :outlets, :location_id, :integer
    remove_column :outlets, :location_name, :string
  end
end

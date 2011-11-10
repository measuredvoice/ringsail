class AddServiceIdToOutlets < ActiveRecord::Migration
  def change
    add_column :outlets, :service_id, :integer
    add_index  :outlets, :service_id
    add_index  :outlets, [:service_id, :account], :unique => true
  end
end

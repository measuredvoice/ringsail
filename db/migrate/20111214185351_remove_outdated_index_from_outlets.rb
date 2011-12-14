class RemoveOutdatedIndexFromOutlets < ActiveRecord::Migration
  def up
    remove_index :outlets, :name => "index_outlets_on_service_id_and_account"
  end

  def down
    add_index "outlets", ["account"], :name => "index_outlets_on_service_id_and_account", :unique => true
  end
end

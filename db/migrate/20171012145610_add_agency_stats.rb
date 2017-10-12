class AddAgencyStats < ActiveRecord::Migration
  def change
    add_column :agencies, :stats_enabled, :boolean
  end
end

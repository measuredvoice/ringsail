class AddCountsToAgencies < ActiveRecord::Migration
  def change
    add_column :agencies, :outlet_count, :integer, default: 0
    add_column :agencies, :mobile_app_count, :integer, default: 0
    
  end
end

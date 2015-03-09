class AddCountsToAgencies < ActiveRecord::Migration
  def change
    add_column :agencies, :draft_outlet_count, :integer, default: 0
    add_column :agencies, :draft_mobile_app_count, :integer, default: 0

    add_column :agencies, :published_outlet_count, :integer, default: 0
    add_column :agencies, :published_mobile_app_count, :integer, default: 0
    
  end
end

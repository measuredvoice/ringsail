class AddCountsToAgencies < ActiveRecord::Migration
  def change
    add_column :agencies, :outlet_count, :integer, default: 0
    add_column :agencies, :mobile_app_count, :integer, default: 0
    Agency.find_each do |agency|
      Agency.update_counters agency.id, :outlet_count => agency.outlets.length
      Agency.update_counters agency.id, :mobile_app_count => agency.mobile_apps.length
    end
  end
end

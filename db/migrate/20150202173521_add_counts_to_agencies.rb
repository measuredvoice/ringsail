class AddCountsToAgencies < ActiveRecord::Migration
  def change
    add_column :agencies, :outlets_count, :integer, default: 0
    add_column :agencies, :mobile_apps_count, :integer, default: 0
    Agency.find_each do |agency|
      Agency.update_counters agency.id, :outlets_count => agency.outlets.length
      Agency.update_counters agency.id, :mobile_apps_count => agency.mobile_apps.length
    end
  end
end

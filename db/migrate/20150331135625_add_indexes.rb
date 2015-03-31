class AddIndexes < ActiveRecord::Migration
  def change
    add_index :outlets, :draft_id
    add_index :outlets, :service
    add_index :outlet_official_tags, :outlet_id
    add_index :outlet_official_tags, :official_tag_id
    add_index :mobile_app_versions, :platform
    
  end
end

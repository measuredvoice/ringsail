class AddMoreIndexes < ActiveRecord::Migration
  def change
    add_index :outlet_users, :outlet_id
    add_index :outlet_users, :user_id

    add_index :mobile_app_agencies, :agency_id
    add_index :mobile_app_agencies, :mobile_app_id

    add_index :mobile_app_users, :user_id
    add_index :mobile_app_users, :mobile_app_id
    
    add_index :mobile_app_official_tags, :official_tag_id
    add_index :mobile_app_official_tags, :mobile_app_id
  end
end

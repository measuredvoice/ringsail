class AddAppsGalleryAgencies < ActiveRecord::Migration
  def self.up
  	add_column :agencies, :mongo_id, :string
  	add_column :agencies, :parent_mongo_id, :string
  	add_column :agencies, :parent_id, :integer
  	#this index isnt necessary, and can't guarantee this on import
    remove_index :agencies, :shortname, :unique => true
  end

  def self.down
  	remove_column :agencies, :mongo_id, :string
  	remove_column :agencies, :parent_mongo_id, :string
  	remove_column :agemcoes, :parent_id, :integer
  end
end

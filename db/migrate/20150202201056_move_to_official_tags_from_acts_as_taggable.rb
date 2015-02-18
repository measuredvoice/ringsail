class MoveToOfficialTagsFromActsAsTaggable < ActiveRecord::Migration
  def change

    remove_column :official_tags, :shortname, :string
    add_column :official_tags, :draft_gallery_count, :integer, default: 0
    add_column :official_tags, :draft_mobile_app_count, :integer, default: 0
    add_column :official_tags, :draft_outlet_count, :integer, default: 0
    add_column :official_tags, :published_gallery_count, :integer, default: 0
    add_column :official_tags, :published_mobile_app_count, :integer, default: 0
    add_column :official_tags, :published_outlet_count, :integer, default: 0

    create_table :mobile_app_official_tags do |t|
      t.integer :mobile_app_id
      t.integer :official_tag_id
    end

    create_table :outlet_official_tags do |t|
      t.integer :outlet_id
      t.integer :official_tag_id
    end

    create_table :gallery_official_tags do |t|
      t.integer :gallery_id
      t.integer :official_tag_id
    end

    
  end
end

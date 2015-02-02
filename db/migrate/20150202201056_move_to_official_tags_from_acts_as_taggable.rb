class MoveToOfficialTagsFromActsAsTaggable < ActiveRecord::Migration
  def change

    remove_column :official_tags, :shortname, :string
    add_column :official_tags, :gallery_count, :integer
    add_column :official_tags, :mobile_app_count, :integer
    add_column :official_tags, :outlet_count, :integer

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

    Outlet.find_each do |outlet|
      outlet.tags.each do |tag|
        outlet.official_tags << OfficialTag.find_or_create_by(tag_text: tag.name)
      end
    end
  end
end

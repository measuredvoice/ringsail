class AddPublishedVersionToDataSets < ActiveRecord::Migration
  def change
    add_column :outlets, :draft_id, :integer
    add_column :outlets, :short_description, :text
    add_column :outlets, :long_description, :text
    remove_column :outlets, :updated_by, :string

    add_column :mobile_apps, :draft_id, :integer

    add_column :galleries, :draft_id, :integer
    add_column :galleries, :short_description, :text
    add_column :galleries, :long_description, :text
    add_column :galleries, :status, :integer

    drop_table :agency_contacts

    Agency.find_each do |agency|
      Agency.update_counters agency.id, :outlet_count => agency.outlets.length
      Agency.update_counters agency.id, :mobile_app_count => agency.mobile_apps.length
    end

    OfficialTag.find_each do |official_tag|
      OfficialTag.update_counters official_tag.id, :outlet_count => official_tag.outlets.length
      OfficialTag.update_counters official_tag.id, :mobile_app_count => official_tag.mobile_apps.length
      OfficialTag.update_counters official_tag.id, :gallery_count => official_tag.galleries.length
    end

    Outlet.find_each do |outlet|
      outlet.tags.each do |tag|
        outlet.official_tags << OfficialTag.find_or_create_by(tag_text: tag.name)
      end
    end
  end
end

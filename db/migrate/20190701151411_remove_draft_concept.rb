class RemoveDraftConcept < ActiveRecord::Migration
  def change
    PublicActivity.enabled = false
    Gallery.where("draft_id is NOT NUll").destroy_all
    Outlet.where("draft_id is NOT NULL").destroy_all
    MobileApp.where("draft_id is NOT NULL").destroy_all

    remove_column :outlets, :draft_id
    remove_column :mobile_apps, :draft_id
    remove_column :galleries, :draft_id
  end
end

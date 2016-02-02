class FixMobileAppsInSystem < ActiveRecord::Migration
  def change
    PublicActivity.enabled = false
    MobileApp.where("draft_id IS NULL AND status = ?", MobileApp.statuses[:published]).each { |ma| ma.published!}
  end
end

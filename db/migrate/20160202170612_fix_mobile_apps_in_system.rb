class FixMobileAppsInSystem < ActiveRecord::Migration
  def change
    MobileApp.where("draft_id IS NULL AND status = ?", MobileApp.statuses[:published]).each { |ma| ma.published!}
  end
end

class FixMobileAppsInSystem < ActiveRecord::Migration
  def change
    PublicActivity.enabled = false
    MobileApp.where("status = ?", MobileApp.statuses[:published]).each { |ma| ma.published!}
  end
end

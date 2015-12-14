class DeviceMigration < ActiveRecord::Migration
  def change
    PublicActivity.enabled = false
    MobileAppVersion.where(device: "Mobile Phone").update_all(device: "App - Phone/Tablet")
    MobileAppVersion.where(device: "Tablet").update_all(device: "App - Tablet Only")
    MobileAppVersion.where(device: "Mobile Web Browser").update_all(device: "Web")
    MobileApp.all.each do |ma|
      ma.long_description = ActionView::Base.full_sanitizer.sanitize(ma.long_description)
      ma.save
    end

    Outlet.all.each do |outlet|
      outlet.published!
      outlet.save
    end
  end
end

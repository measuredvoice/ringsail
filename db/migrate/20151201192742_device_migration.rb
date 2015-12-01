class DeviceMigration < ActiveRecord::Migration
  def change
    MobileAppVersion.where(device: "Mobile Phone").update_all(device: "App - Phone/Tablet")
    MobileAppVersion.where(device: "Tablet").update_all(device: "App - Tablet Only")
    MobileAppVersion.where(device: "Mobile Web Browser").update_all(device: "Web")
  end
end

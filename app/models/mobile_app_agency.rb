# == Schema Information
#
# Table name: mobile_app_agencies
#
#  id            :integer          not null, primary key
#  mobile_app_id :integer
#  agency_id     :integer
#

class MobileAppAgency < ActiveRecord::Base
  belongs_to :agency
  belongs_to :mobile_app


  after_save :update_counter_cache
  after_destroy :update_counter_cache
  
  def update_counter_cache
    self.agency.mobile_app_count = MobileApp.includes(:agencies).where(
      "agency.id = ? AND mobile_apps.draft_id IS NOT NULL", self.agency_id)
    self.agency.save
  end
end

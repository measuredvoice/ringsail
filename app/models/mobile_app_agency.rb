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
    self.agency.draft_mobile_app_count = self.agency.mobile_apps.where(status: 1).count
    self.agency.published_mobile_app_count = self.agency.mobile_apps.where(status: 1).count
    self.agency.save!
  end
end

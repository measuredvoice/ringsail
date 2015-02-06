# == Schema Information
#
# Table name: mobile_app_official_tags
#
#  id              :integer          not null, primary key
#  mobile_app_id   :integer
#  official_tag_id :integer
#

class MobileAppOfficialTag < ActiveRecord::Base
  belongs_to :mobile_app
  belongs_to :official_tag

  after_save :update_counter_cache
  after_destroy :update_counter_cache
  
  def update_counter_cache
    self.official_tag.mobile_app_count = MobileApp.includes(:official_tags).where(
      "official_tags.id = ? AND mobile_apps.draft_id IS NOT NULL", self.official_tag_id)
    self.official_tag.save
  end
end

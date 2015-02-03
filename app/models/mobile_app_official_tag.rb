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
  belongs_to :official_tag, counter_cache: :mobile_app_count
end

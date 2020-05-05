# == Schema Information
#
# Table name: mobile_app_versions
#
#  id                :integer          not null, primary key
#  mobile_app_id     :integer
#  store_url         :text(16777215)
#  platform          :string(255)
#  version_number    :string(255)
#  publish_date      :datetime
#  description       :text(16777215)
#  whats_new         :text(16777215)
#  screenshot        :text(16777215)
#  device            :string(255)
#  language          :string(255)
#  average_rating    :string(255)
#  number_of_ratings :integer
#  mongo_id          :string(255)
#
class MobileAppVersion < ActiveRecord::Base
	
  belongs_to :mobile_app

  validates :store_url, presence: true
  validates :platform, presence: true
  validates :device, presence: true
end

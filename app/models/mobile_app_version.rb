# == Schema Information
#
# Table name: mobile_app_versions
#
#  id                :integer          not null, primary key
#  mobile_app_id     :integer
#  store_url         :string(255)
#  platform          :string(255)
#  version_number    :string(255)
#  publish_date      :datetime
#  description       :text
#  whats_new         :text
#  screenshot        :text
#  device            :string(255)
#  language          :string(255)
#  average_rating    :string(255)
#  number_of_ratings :integer
#

class MobileAppVersion < ActiveRecord::Base
	
  belongs_to :mobile_app
end

# == Schema Information
#
# Table name: mobile_app_galleries
#
#  id            :integer          not null, primary key
#  gallery_id    :integer
#  mobile_app_id :integer
#

class MobileAppGallery < ActiveRecord::Base
  belongs_to :gallery
  belongs_to :mobile_app
end

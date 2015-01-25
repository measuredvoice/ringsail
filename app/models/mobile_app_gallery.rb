class MobileAppGallery < ActiveRecord::Base
  belongs_to :gallery
  belongs_to :mobile_app
end

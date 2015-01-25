class MobileAppUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :mobile_app
end

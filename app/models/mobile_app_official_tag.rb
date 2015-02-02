class MobileAppOfficialTag < ActiveRecord::Base
  belongs_to :mobile_app
  belongs_to :official_tag, counter_cache: :mobile_app_count
end

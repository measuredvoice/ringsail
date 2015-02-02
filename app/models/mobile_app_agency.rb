# == Schema Information
#
# Table name: mobile_app_agencies
#
#  id            :integer          not null, primary key
#  mobile_app_id :integer
#  agency_id     :integer
#

class MobileAppAgency < ActiveRecord::Base
  belongs_to :agency, :counter_cache => :mobile_apps_count
  belongs_to :mobile_app
end

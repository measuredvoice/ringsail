# == Schema Information
#
# Table name: mobile_app_agencies
#
#  id            :integer          not null, primary key
#  agency_id    :integer
#  mobile_app_id :integer
#

class MobileAppAgency < ActiveRecord::Base
  belongs_to :agency
  belongs_to :mobile_app
end

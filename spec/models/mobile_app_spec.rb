# == Schema Information
#
# Table name: mobile_apps
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  short_description :text(65535)
#  long_description  :text(65535)
#  icon_url          :string(255)
#  language          :string(255)
#  agency_id         :integer
#  status            :integer          default("0")
#  mongo_id          :string(255)
#  draft_id          :integer
#

require 'rails_helper'

RSpec.describe MobileApp, type: :model do 
	it "should pass validations" do
		mobile_app =  FactoryGirl.create(:mobile_app)
		expect(mobile_app.valid?).to eq(true)
	end
end

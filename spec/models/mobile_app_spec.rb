require 'rails_helper'

RSpec.describe MobileApp, type: :model do 
	it "should pass validations" do
		mobile_app =  FactoryGirl.create(:mobile_app)
		expect(mobile_app.valid?).to eq(true)
	end
end
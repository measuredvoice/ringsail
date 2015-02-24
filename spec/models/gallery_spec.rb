require 'rails_helper'

RSpec.describe Gallery, type: :model do
	it "should pass validations" do
		gallery = FactoryGirl.create(:gallery)
		expect(gallery.valid?).to eq(true)
	end
end
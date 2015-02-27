# == Schema Information
#
# Table name: galleries
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  draft_id          :integer
#  short_description :text(65535)
#  long_description  :text(65535)
#  status            :integer
#

require 'rails_helper'

RSpec.describe Gallery, type: :model do
	it "should pass validations" do
		gallery = FactoryGirl.create(:gallery)
		expect(gallery.valid?).to eq(true)
	end
end

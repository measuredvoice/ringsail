# == Schema Information
#
# Table name: outlets
#
#  id                :integer          not null, primary key
#  service_url       :string(255)
#  organization      :string(255)
#  account           :string(255)
#  language          :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  service           :string(255)
#  status            :integer          default(0)
#  draft_id          :integer
#  short_description :text(65535)
#  long_description  :text(65535)
#

require 'rails_helper'

RSpec.describe Outlet, type: :model do
  it "should pass validations" do
    outlet = FactoryGirl.create(:outlet)
    expect(outlet.valid?).to eq(true)
  end

end

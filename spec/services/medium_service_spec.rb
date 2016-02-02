require 'rails_helper'

RSpec.describe "MediumService" do
  it "should define a shortname" do
    shortname = MediumService.shortname
    expect(shortname).to eq(:medium)
  end

end
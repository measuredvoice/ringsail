require 'rails_helper'

RSpec.describe YelpService do
  it "should define a shortname" do
    shortname = YelpService.shortname
    expect(shortname).to eq(:yelp)
  end

end
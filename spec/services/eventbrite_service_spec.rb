require 'rails_helper'

RSpec.describe EventbriteService do
  it "should define a shortname" do
    shortname = EventbriteService.shortname
    expect(shortname).to eq(:eventbrite)
  end

end
require 'rails_helper'

RSpec.describe "TwitterService" do
  it "should define a shortname" do
    shortname = TwitterService.shortname
    expect(shortname).to eq(:twitter)
  end

end

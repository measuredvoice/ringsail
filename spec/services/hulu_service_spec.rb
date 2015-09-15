require 'rails_helper'

RSpec.describe HuluService do
  it "should define a shortname" do
    shortname = HuluService.shortname
    expect(shortname).to eq(:hulu)
  end

end
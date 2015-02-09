require 'rails_helper'

RSpec.describe <%= file_name.downcase.capitalize %>Service do
  it "should define a shortname" do
    shortname = <%= file_name.downcase.capitalize %>Service.shortname
    expect(shortname).to eq(:<%= file_name.downcase %>)
  end

end
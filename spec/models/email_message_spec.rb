require 'rails_helper'

RSpec.describe EmailMessage, type: :model do

  it "validations should run and be successful for the factory" do
    email = Factory(:email_message)
    email.valid?.should == true
  end
  
end
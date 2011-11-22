# == Schema Information
#
# Table name: auth_tokens
#
#  id           :integer(4)      not null, primary key
#  token        :string(255)
#  email        :string(255)
#  phone        :string(255)
#  admin        :boolean(1)
#  access_count :integer(4)
#  created_at   :datetime
#  updated_at   :datetime
#

require 'spec_helper'

describe AuthToken do

  before(:each) do
    @attr = { 
      :email => 'user@example.gov',
      :phone => '+1-555-555-1212 x175',
    }
  end
  
  it "should create a new instance given valid attributes" do
    AuthToken.create!(@attr)
  end
  
  it "should have a unique token when saved" do
    at = AuthToken.create!(@attr)
    at.token.should_not be_nil
  end
  
  it "should require an email address" do
    no_email_authtoken = AuthToken.new(@attr.merge(:email => ""))
    no_email_authtoken.should_not be_valid
  end

  it "should require a phone number" do
    no_phone_authtoken = AuthToken.new(@attr.merge(:phone => ""))
    no_phone_authtoken.should_not be_valid
  end
  
  it "should require a valid government email address" do
    not_gov = AuthToken.new(@attr.merge(:email => "dude@gmail.com"))
    not_gov.should_not be_valid
  end
end

# == Schema Information
#
# Table name: auth_tokens
#
#  id           :integer          not null, primary key
#  token        :string(255)
#  email        :string(255)
#  phone        :string(255)
#  admin        :boolean
#  access_count :integer
#  created_at   :datetime
#  updated_at   :datetime
#  duration     :string(255)      default("short")
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
  
  it "should stay valid if refreshed" do
    current = FactoryGirl.build(:auth_token, created_at: 8.hours.ago, updated_at: 2.hours.ago)
    current.should be_still_valid
  end
  
  it "should expire after a day" do
    expired = FactoryGirl.build(:auth_token, created_at: 2.days.ago, updated_at: 2.days.ago)
    expired.should_not be_still_valid
  end
  
  describe "find_recent" do
    it "should find a recently-requested token" do
      at = AuthToken.create!(@attr)
      sleep 2
      at2 = AuthToken.find_recent_by_email(@attr[:email])
      at2.should_not be_nil
      at2.token.should == at.token
    end
  end
  
  describe "long-duration tokens" do
    before(:each) do
      @long_attr = {
        :email    => @attr[:email],
      }
    end
    
    it "should create a long-duration instance given valid attributes" do
      at = AuthToken.new(@long_attr)
      at.duration = 'long'
      at.should be_valid
    end
    
    it "should still be valid after two weeks" do
      current = FactoryGirl.build(:auth_token_ld, created_at: 2.weeks.ago, updated_at: 2.weeks.ago)
      current.should be_still_valid
    end
    
    it "should not be valid after six weeks" do
      expired = FactoryGirl.build(:auth_token_ld, created_at: 6.weeks.ago, updated_at: 6.weeks.ago)
      expired.should_not be_still_valid
    end
    
    it "should not be returned when checking recent tokens" do
      at = FactoryGirl.create(:auth_token_ld)
      at2 = AuthToken.find_recent_by_email(at.email)
      at2.should be_nil
    end
  end
end

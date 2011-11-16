require 'spec_helper'

describe Service do

  it "should return nil for unknown services" do
    unknown = Service.find_by_url("http://example.com")
    unknown.should be_nil
  end
  
  describe "Twitter plugin" do
    
    it "should be chosen for Twitter URLs" do
      service = Service.find_by_url("http://twitter.com/usagov")
      service.shortname.should == :twitter
    end
    
    it "should provide account details" do
      service = Service.find_by_url("http://twitter.com/usagov")
      service.account.should == "usagov"
      service.profile_name.should_not be_nil
      service.profile_image.should_not be_nil
    end
    
    it "should gracefully handle invalid accounts" do
      invalid = Service.find_by_url("http://twitter.com/notappearinginthisfilm")
      invalid.account.should == "notappearinginthisfilm"
      invalid.profile_name.should be_nil
      invalid.profile_image.should be_nil
    end
  end
  
  describe "Facebook plugin" do
    
    it "should be chosen for Facebook URLs"
  end
  
  describe "Youtube plugin" do
    
    it "should be chosen for Youtube URLs"
  end
  
  describe "Flickr plugin" do
    
    it "should be chosen for Flickr URLs"
  end
end

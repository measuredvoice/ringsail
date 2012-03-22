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
    end
    
    it "should gracefully handle invalid accounts" do
      invalid = Service.find_by_url("http://twitter.com/notappearinginthisfilm")
      invalid.account.should == "notappearinginthisfilm"
    end
  end
  
  describe "Facebook plugin" do
    
    it "should be chosen for Facebook URLs" do
      service = Service.find_by_url("http://facebook.com/USAgov")
      service.shortname.should == :facebook
    end
  end
  
  describe "Youtube plugin" do
    
    it "should be chosen for Youtube URLs" do
      service = Service.find_by_url("http://www.youtube.com/USGovernment")
      service.shortname.should == :youtube
    end
  end
  
  describe "Flickr plugin" do
    
    it "should be chosen for Flickr URLs" do
      service = Service.find_by_url("http://www.flickr.com/groups/usagov/")
      service.shortname.should == :flickr
    end
  end
end

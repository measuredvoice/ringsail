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

    it "should ignore system URLs" do
      service = Service.find_by_url("http://www.youtube.com/watch")
      service.account.should be_nil
    end
  end
  
  describe "Flickr plugin" do
    
    it "should be chosen for Flickr URLs" do
      service = Service.find_by_url("http://www.flickr.com/groups/usagov/")
      service.shortname.should == :flickr
    end
  end
  
  describe "Google+ plugin" do
    
    it "should be chosen for Google+ URLs" do
      service = Service.find_by_url("https://plus.google.com/111769560327165905725/posts")
      service.shortname.should == :google_plus
    end
    
    it "should find both numeric and +name accounts" do
      service = Service.find_by_url("https://plus.google.com/111769560327165905725")
      service.account.should == '111769560327165905725'

      service = Service.find_by_url("https://plus.google.com/+NASA")
      service.account.should == '+NASA'
    end
    
    it "should accept but ignore /posts in URL" do
      service = Service.find_by_url("https://plus.google.com/111769560327165905725/posts")
      service.account.should == '111769560327165905725'

      service = Service.find_by_url("https://plus.google.com/+NASA/posts")
      service.account.should == '+NASA'
    end
  end

  describe "Slideshare plugin" do
    
    it "should be chosen for Slideshare URLs" do
      service = Service.find_by_url("http://www.slideshare.net/nasa")
      service.shortname.should == :slideshare
    end

    it "should ignore system URLs" do
      service = Service.find_by_url("http://www.slideshare.net/nasa")
      service.account.should == 'nasa'

      service = Service.find_by_url("http://www.slideshare.net/popular")
      service.account.should be_nil
    end
  end
end

require 'spec_helper'

describe Service do

  it "should return nil for unknown services" do
    unknown = Service.find_by_url("http://example.com")
    unknown.should be_nil
  end
  
  describe "definition for Twitter" do
    
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
  
  describe "definition for Facebook" do
    
    it "should be chosen for Facebook URLs" do
      service = Service.find_by_url("http://facebook.com/USAgov")
      service.shortname.should == :facebook
    end
  end
  
  describe "definition for Youtube" do
    
    it "should be chosen for Youtube URLs" do
      service = Service.find_by_url("http://www.youtube.com/USGovernment")
      service.shortname.should == :youtube
    end

    it "should ignore system URLs" do
      service = Service.find_by_url("http://www.youtube.com/watch")
      service.account.should be_nil
    end
  end
  
  describe "definition for Flickr" do
    
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

  describe "definition for Slideshare" do
    
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
  
  describe "definition for Pinterest" do
    it "should be chosen for Pinterest URLs" do
      service = Service.find_by_url("http://pinterest.com/michelleobama/")
      service.shortname.should == :pinterest
    end

    it "should pick out the correct account name" do
      service = Service.find_by_url("http://pinterest.com/michelleobama/")
      service.account.should == 'michelleobama'
    end
  end

  describe "definition for Instagram" do
    it "should be chosen for Instagram URLs" do
      service = Service.find_by_url("http://instagram.com/morgantown_wv/")
      service.shortname.should == :instagram
    end

    it "should pick out the correct account name" do
      service = Service.find_by_url("http://instagram.com/morgantown_wv/")
      service.shortname.should == :instagram
      service.account.should == 'morgantown_wv'
      
      service = Service.find_by_url("http://instagram.com/cityofdetroit#")
      service.shortname.should == :instagram
      service.account.should == 'cityofdetroit'
    end

    it "should ignore system URLs" do
      service = Service.find_by_url("http://instagram.com/about/us/")
      service.account.should be_nil

      service = Service.find_by_url("http://instagram.com/press/")
      service.account.should be_nil

      service = Service.find_by_url("http://blog.instagram.com/")
      service.should be_nil
    end
  end
end

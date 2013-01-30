# == Schema Information
#
# Table name: outlets
#
#  id            :integer(4)      not null, primary key
#  service_url   :string(255)
#  organization  :string(255)
#  info_url      :string(255)
#  account       :string(255)
#  language      :string(255)
#  updated_by    :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  service       :string(255)
#  location_id   :integer(4)
#  location_name :string(255)
#

require 'spec_helper'

describe Outlet do
  
  before(:each) do
    @good_token = AuthToken.create!(
      :email => "valid@example.gov", 
      :phone => "555-1212",
    )
    @agency = Agency.create!(:name => "Department of Examples", :shortname => 'examples')
    @attr = { 
      :service_url  => "http://twitter.com/example", 
      :organization => "Example Project",
      :info_url     => "http://example.gov",
      :language     => "English",
      :service      => :twitter,
      :account      => "something",
      :auth_token   => @good_token.token,
      :agency_ids   => [@agency.id],
      :tag_list     => "foo thing, bar, baz",
    }
  end
  
  it "should create a new instance given valid attributes" do 
    Outlet.create!(@attr)
  end  
  
  it "should record the correct updated_by email" do
    outlet = Outlet.create!(@attr)
    outlet.updated_by.should_not be_nil
  end
  
  describe "new-object validation" do
    it "should require a service URL" do
      no_url_outlet = Outlet.new(@attr.merge(:service_url => ""))
      no_url_outlet.should_not be_valid
    end

    it "should not allow bulk updates of updated_by" do
      bad_actor = 'someone@something.com'
      bulked_outlet = Outlet.create!(@attr.merge(:updated_by => bad_actor))
      bulked_outlet.updated_by.should_not == bad_actor
    end
    
    invalid_url = "blern.foo.com"
  
    it "should require a valid service URL" do
      bad_url_outlet = Outlet.new(@attr.merge(:service_url => invalid_url))
      bad_url_outlet.should_not be_valid
    end

    it "should accept a missing info URL" do
      missing_url_outlet = Outlet.new(@attr.merge(:info_url => ""))
      missing_url_outlet.should be_valid
    end

    it "should require a valid info URL" do
      bad_url_outlet = Outlet.new(@attr.merge(:info_url => invalid_url))
      bad_url_outlet.should_not be_valid
    end
    
    it "should require a valid account name" do
      bad_account_outlet = Outlet.new(@attr.merge(:account => '', :service_url => 'http://twitter.com/'))
      bad_account_outlet.should_not be_valid
    end    

    it "should require the language field" do
      no_language_outlet = Outlet.new(@attr.merge(:language => ''))
      no_language_outlet.should_not be_valid
    end    
  end
  
  describe "resolve" do

    it "should produce a new instance if not present" do
      new_outlet_url = "http://twitter.com/example2"
      new_outlet = Outlet.resolve(new_outlet_url)
      new_outlet.service_url.should == new_outlet_url
      new_outlet.account.should_not be_nil
      new_outlet.service.should_not be_nil
    end
    
    it "should return an existing instance if present" do
      outlet = Outlet.resolve(@attr[:service_url])
      outlet.auth_token = @attr[:auth_token]
      outlet.agencies.push @agency
      outlet.language = 'English'
      outlet.save
      resolved_outlet = Outlet.resolve(@attr[:service_url])
      resolved_outlet.should == outlet
    end
    
    it "should add HTTP by default to URLs" do
      outlet = Outlet.resolve("twitter.com/example3")
      outlet.should_not be_nil
    end
    
    it "should allow HTTPS URLs" do
      outlet = Outlet.resolve("https://twitter.com/example3")
      outlet.should_not be_nil
    end
    
    it "should ignore case in the protocol" do
      outlet = Outlet.resolve("Http://twitter.com/example3")
      outlet.should_not be_nil
    end
    
    it "should ignore case in the hostname" do
      outlet = Outlet.resolve("http://TWitter.com/example3")
      outlet.should_not be_nil
    end
    
    describe "with an invalid URL" do
      it "should not return an outlet" do
        outlet = Outlet.resolve("this URL is invalid")
        outlet.should be_nil
      end
    end
  end
  
  describe "sponsorships" do
    before(:each) do
      @outlet = Outlet.create!(@attr)
    end
    
    it "should have a sponsorships method" do
      @outlet.should respond_to(:sponsorships)
    end

    it "should set the sponsoring agency" do
      @outlet.sponsorships.create!(:agency_id => @agency)
    end
  end
  
  describe "service" do
    before(:each) do
      @outlet = Outlet.create!(@attr)
    end
    
    it "should have a service method" do
      @outlet.should respond_to(:service)
    end
    
    it "should return the service type" do
      @outlet.service.should_not be_nil
    end
    
    it "should provide service-specific information" do
      @outlet.should respond_to(:service_info)
      @outlet.service_info.account.should_not be_nil
    end
  end
  
  describe "verification" do
  
    before(:each) do
      @outlet = Outlet.create!(@attr)
    end
    
    it "should have a verified? method" do
      @outlet.should respond_to(:verified?)
    end
  end
  
  describe "tagging" do
  
    before(:each) do
      @outlet = Outlet.create!(@attr)
    end
      
    it "should return tags" do
      @outlet.tag_list.should_not be_empty
      @outlet.tags.first.to_s.should == 'foo thing'
    end
  end
  
  describe "lists" do
    before(:each) do
      # Generate outlets that were created/updated over the past year
      12.times do |n|
        outlet = FactoryGirl.build(:outlet, created_at: n.months.ago, updated_at: n.months.ago)
        outlet.agencies << FactoryGirl.create(:agency)
        outlet.save!
      end
    end
    
    describe "to review" do
      it "should only list outlets older than 6 months" do
        @outlets = Outlet.to_review
        @outlets.first.updated_at.should <= 6.months.ago
      end
      
      it "should be in order by update time" do
        @outlets = Outlet.to_review
        @outlets[0].updated_at.should <= @outlets[1].updated_at
      end
      
      it "should be filterable by email address" do
        # Make a special outlet updated by a specific email
        @auth_token = FactoryGirl.create(:auth_token)
        @outlet_a = FactoryGirl.build(:outlet, created_at: 9.months.ago, updated_at: 9.months.ago)
        @outlet_a.auth_token = @auth_token.token
        @outlet_a.agencies << FactoryGirl.create(:agency)
        @outlet_a.save!
        
        @outlets = Outlet.to_review.updated_by(@auth_token.email)
        @outlets[0].updated_by.should == @outlet_a.updated_by
        
      end
    end
  end
end

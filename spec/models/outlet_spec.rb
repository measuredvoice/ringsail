# == Schema Information
#
# Table name: outlets
#
#  id           :integer(4)      not null, primary key
#  service_url  :string(255)
#  organization :string(255)
#  info_url     :string(255)
#  account      :string(255)
#  language     :string(255)
#  updated_by   :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

require 'spec_helper'

describe Outlet do
  
  before(:each) do
    @attr = { 
      :service_url  => "http://twitter.com/example", 
      :organization => "Example Project",
      :info_url     => "http://example.gov",
      :account      => "example",
      :language     => "English",
      :updated_by   => "user@example.gov",
    }
  end
  
  it "should create a new instance given valid attributes" do 
    Outlet.create!(@attr)
  end
  
  it "should record the correct updated_by email"
  
  describe "new-object validation" do
    it "should require a service URL" do
      no_url_outlet = Outlet.new(@attr.merge(:service_url => ""))
      no_url_outlet.should_not be_valid
    end

    invalid_url = "blern.foo.com"
  
    it "should require a valid service URL" do
      bad_url_outlet = Outlet.new(@attr.merge(:service_url => invalid_url))
      bad_url_outlet.should_not be_valid
    end

    it "should require a valid info URL" do
      bad_url_outlet = Outlet.new(@attr.merge(:info_url => invalid_url))
      bad_url_outlet.should_not be_valid
    end
  end
  
  describe "resolve" do
    before(:each) do
      @outlet = Outlet.create!(@attr)
    end
    
    it "should produce an empty instance if not present" do
      new_outlet_url = "http://emergency.gov"
      new_outlet = Outlet.resolve(new_outlet_url)
      new_outlet.service_url.should == new_outlet_url
    end
    
    pending "should return an existing instance if present" do
      resolved_outlet = Outlet.resolve(@attr[:service_url])
      resolved_outlet.should == @outlet
    end
    
  end
end

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
      :service_url => "http://twitter.com/example", 
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
  
  it "should require a service URL" do
    no_url_outlet = Outlet.new(@attr.merge(:service_url => ""))
    no_url_outlet.should_not be_valid
  end

  it "should require valid URLs" do
    no_url_outlet = Outlet.new(@attr.merge(:service_url => "blern.foo.com"))
    no_url_outlet.should_not be_valid
  end
end

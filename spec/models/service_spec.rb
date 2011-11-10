# == Schema Information
#
# Table name: services
#
#  id         :integer(4)      not null, primary key
#  shortname  :string(255)
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Service do

  before(:each) do
    @attr = { 
      :shortname  => "example", 
      :name       => "Example Service",
    }
  end
  
  it "should create a new instance given valid attributes" do 
    Service.create!(@attr)
  end
  
  describe "new-object validation" do
    it "should require a shortname" do
      no_name = Service.new(@attr.merge(:shortname => ""))
      no_name.should_not be_valid
    end

    it "should require a name" do
      no_name = Service.new(@attr.merge(:name => ""))
      no_name.should_not be_valid
    end
  end
  
  describe "find by shortname" do
    it "should find the right service" do
      Service.create!(@attr)
      found = Service.find_by_shortname(@attr[:shortname])
      found.should_not be_nil
      found.name.should == @attr[:name]
    end
  end
end

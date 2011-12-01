# == Schema Information
#
# Table name: agencies
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  shortname  :string(255)
#  info_url   :string(255)
#

require 'spec_helper'

describe Agency do

  before(:each) do
    @attr = { 
      :name      => "Department of Examples", 
      :shortname => "example",
    }
  end
  
  it "should create a new instance given valid attributes" do 
    Agency.create!(@attr)
  end

  describe "creation" do
  
    it "should reject an agency without a shortname" do
      noname = Agency.new(@attr.merge(:shortname => ""))
      noname.should_not be_valid
    end
    
    it "should reject an agency without a name" do
      noname = Agency.new(@attr.merge(:name => ""))
      noname.should_not be_valid
    end
  end
end

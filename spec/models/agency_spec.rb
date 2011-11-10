# == Schema Information
#
# Table name: agencies
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  shortname  :string(255)
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
end

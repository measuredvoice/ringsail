# == Schema Information
#
# Table name: agencies
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  shortname       :string(255)
#  info_url        :string(255)
#  mongo_id        :string(255)
#  parent_mongo_id :string(255)
#  parent_id       :integer
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
  
  describe "outlet count" do
    before(:each) do
      @agency = Agency.create!( 
        :name      => "Department of Examples", 
        :shortname => "example",
      )
      
      @first_outlet = Outlet.create!(
        :service_url  => "http://twitter.com/example1", 
        :language     => "English",
        :service      => :twitter,
        :account      => "example1",
        :agency_ids   => [@agency.id],
      )
    end
    
    it "should change when an outlet is added" do
      lambda do
        Outlet.create!(
          :service_url  => "http://twitter.com/example2", 
          :language     => "English",
          :service      => :twitter,
          :account      => "example2",
          :agency_ids   => [@agency.id],
        )
      end.should change(@agency, :outlets_count).by(1)
    end

    it "should change when an outlet is removed" do
      lambda do
        @first_outlet.destroy
      end.should change(@agency, :outlets_count).by(-1)
    end
  end
end

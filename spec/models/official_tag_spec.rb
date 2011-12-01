# == Schema Information
#
# Table name: official_tags
#
#  id         :integer(4)      not null, primary key
#  shortname  :string(255)
#  tag_text   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe OfficialTag do
  before(:each) do
    @attr = { 
      :shortname => "sometag",
      :tag_text  => "Some Official Tag",
    }
  end

  describe "creation" do
    it "should create a new instance given valid attributes" do 
      OfficialTag.create!(@attr)
    end  
    
    it "should reject a tag without text" do
      notag = OfficialTag.new(:shortname => "", :tag_text => "")
      notag.should_not be_valid
    end
    
    it "should auto-create the shortname based on the tag text" do
      tag = OfficialTag.new(:tag_text => "Something Else")
      tag.should be_valid
      tag.shortname.should == 'somethingelse'
    end    
    
    it "should auto-create the tag text based on the shortname" do
      tag = OfficialTag.new(:shortname => "somethingnew")
      tag.should be_valid
      tag.tag_text.should == 'somethingnew'
    end    

    it "should not modify either field if provided and correct" do
      tag = OfficialTag.new(@attr)
      tag.should be_valid
      tag.tag_text.should == @attr[:tag_text]
      tag.shortname.should == @attr[:shortname]
    end    
  end
end

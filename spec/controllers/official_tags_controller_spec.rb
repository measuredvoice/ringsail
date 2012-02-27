require 'spec_helper'

describe OfficialTagsController do
  render_views

  before(:each) do
    OfficialTag.create!(:tag_text => "One", :shortname => "one")
    OfficialTag.create!(:tag_text => "Two", :shortname => "two")
    OfficialTag.create!(:tag_text => "Three", :shortname => "three")
    OfficialTag.create!(:tag_text => "Four", :shortname => "four")
    OfficialTag.create!(:tag_text => "Five", :shortname => "five")
    OfficialTag.create!(:tag_text => "Six", :shortname => "six")
    OfficialTag.create!(:tag_text => "Seven", :shortname => "seven")
    OfficialTag.create!(:tag_text => "Eight", :shortname => "eight")
    OfficialTag.create!(:tag_text => "Nine", :shortname => "nine")
    OfficialTag.create!(:tag_text => "Ten", :shortname => "ten")
    OfficialTag.create!(:tag_text => "Ten Plus", :shortname => "tenplus")
    OfficialTag.create!(:tag_text => "Ten Again", :shortname => "tenagain")
  end
  
  describe "GET 'list'" do
    it "should be successful" do
      get :list
      response.should be_success
    end
    
    it "should respond with all tags by default"  do
      get :list
      response.should have_selector("li", :content => "Ten Again")
    end
    
    describe "with a keyword" do
      it "should list the tags that match the provided text" do
        get :list, :q => 'ten'
        response.should have_selector("li", :content => "Ten Again")
        response.should_not have_selector("li", :content => "Seven")
      end
    end
  end
end

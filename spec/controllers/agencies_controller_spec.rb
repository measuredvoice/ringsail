require 'spec_helper'

describe AgenciesController do
  render_views

  before(:each) do
    Agency.create!(:name => "Department of One", :shortname => "one")
    Agency.create!(:name => "Department of Two", :shortname => "two")
    Agency.create!(:name => "Department of Three", :shortname => "three")
    Agency.create!(:name => "Department of Four", :shortname => "four")
  end
  
  describe "GET 'list'" do
    it "should be successful" do
      get :list
      response.should be_success
    end
    
    it "should respond with all agencies" do
      get :list
      response.should have_selector("li", :content => Agency.first.name)
      response.should have_selector("li", :content => Agency.last.name)
    end
  end
end

require 'spec_helper'

describe OutletsController do
  render_views

  describe "GET 'add'" do
    it "should be successful" do
      get :add
      response.should be_success
    end
    
    it "should ask for a service_url if one was not given"
    
    describe "with a service_url" do
      it "should display the full form with service_url filled in"
    end
  end

  describe "POST 'update'" do
    
    describe "failure" do

      before(:each) do
        @attr = {
          :service_url => "",
          :organization => "",
          :info_url => "",
          :language => ""
        }
      end
      
      it "should not add an outlet" do
        lambda do
          post :update, :service_url => @attr[:service_url]
        end.should_not change(Outlet, :count)
      end
    end
    
    describe "success" do
      before(:each) do
        Service.create!(:name => "Twitter", :shortname => "Twitter")
        @attr = {
          :service_url => "http://twitter.com/example",
          :organization => "Example Project",
          :info_url => "http://example.gov",
          :language => "English"
        }
      end
      
      it "should add an outlet" do
        lambda do
          post :update, @attr
        end.should change(Outlet, :count).by(1)
      end
      
      it "should set the outlet's attributes" do
        post :update, @attr
        new_outlet = Outlet.find_by_service_url(@attr[:service_url])
        new_outlet.service_url.should  == @attr[:service_url]
        new_outlet.organization.should  == @attr[:organization]
        new_outlet.service.should_not be_nil
      end
      
    end
    
  end

  describe "GET 'verify'" do
  
    describe "for an unverified outlet" do
    
      before(:each) do
        Service.create!(:name => "Twitter", :shortname => "twitter")
      end
    
      it "should be successful" do
        get :verify
        response.should be_success
      end
      
      it "should return an unverified indication" do
        unverified_url = "http://twitter.com/unverified"
        get :verify, :service_url => unverified_url
        response.should have_selector("p", :content => "NOT VERIFIED")
        response.should have_selector("h1", :content => unverified_url)
      end
      
      it "should return no outlet attributes" do
        unverified_url = "http://twitter.com/unverified"
        get :verify, :service_url => unverified_url
        response.should_not have_selector("p", :content => "Organization:")
      end
    end
    
    describe "for a verified outlet" do
      it "should be successful"
      
      it "should return a verified indication"
      
      it "should return the attributes of the outlet"
    end
  end
end

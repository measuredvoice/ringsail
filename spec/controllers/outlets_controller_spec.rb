require 'spec_helper'

describe OutletsController do
  render_views

  before(:each) do
    @good_token = AuthToken.create!(
      :email => "valid@example.gov", 
      :phone => "555-1212",
    )
    @agency = Agency.create!(:name => "Department of Examples", :shortname => "example")
  end
  
  describe "GET 'add'" do
    it "should be successful" do
      get :add, :auth_token => @good_token.token
      response.should be_success
    end
    
    it "should ask for a service_url if one was not given" do
      get :add, :auth_token => @good_token.token
      response.should have_selector("p", :content => "type the full URL")
    end
    
    describe "with a service_url" do
      it "should display the full form with service_url filled in" do
        service_url = 'http://twitter.com/somethingorother'
        get :add, :service_url => service_url, :auth_token => @good_token.token
        response.should have_selector("p", :content => "Update registry information")
        response.should have_selector("a", :href => service_url)
      end
    end
  end

  describe "POST 'update'" do
    
    describe "authorization checking" do

      before(:each) do
        @attr = {
          :auth_token => @good_token.token,
          :service_url => "http://twitter.com/example",
          :organization => "Example Project",
          :info_url => "http://example.gov",
          :language => "English"
        }
      end
      
      it "should reject a missing auth token" do
        post :update, @attr.merge(:auth_token => "")
        response.should redirect_to(new_path)
      end
      
      it "should reject a bogus auth token" do
        post :update, @attr.merge(:auth_token => "ABCDEFG")
        response.should redirect_to(new_path)
      end
      
      it "should reject an old auth token"
    end
    
    describe "failure" do

      before(:each) do
        @attr = {
          :auth_token => @good_token.token,
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
        @attr = {
          :auth_token => @good_token.token,
          :service_url => "http://twitter.com/example",
          :organization => "Example Project",
          :info_url => "http://example.gov",
          :language => "English",
          :agency_id => [@agency.shortname],
          :tags      => "foo, bar baz, example",
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
        new_outlet.tag_list.should_not be_empty
      end
      
    end
    
  end

  describe "GET 'verify'" do
  
    it "should be successful" do
      get :verify
      response.should be_success
    end
    
    it "should prepend http:// if missing" do
      unverified_url = "twitter.com/unverified"
      get :verify, :service_url => unverified_url
      response.should have_selector("p", :content => "is not registered")
      response.should have_selector("a", :href => 'http://' + unverified_url)
    end
    
    describe "for an unverified outlet" do
        
      it "should return an unverified indication" do
        unverified_url = "http://twitter.com/unverified"
        get :verify, :service_url => unverified_url
        response.should have_selector("p", :content => "is not registered")
        response.should have_selector("a", :href => unverified_url)
      end
      
      it "should return no outlet attributes" do
        unverified_url = "http://twitter.com/unverified"
        get :verify, :service_url => unverified_url
        response.should_not have_selector("p", :content => "Organization:")
      end
    end
    
    describe "for a verified outlet" do
      before(:each) do
        # FIXME: Get thee to a factory
        @verified_url = "http://twitter.com/deptofexample"
        @outlet = Outlet.resolve(@verified_url)
        @outlet.language = 'English';
        @outlet.organization = 'Example Campaign'
        @outlet.agencies.push @agency
        @good_token = AuthToken.create!(
          :email => "valid@example.gov", 
          :phone => "555-1212",
        )
        @outlet.auth_token = @good_token.token
        @outlet.save!
      end
      
      it "should be successful" do
        get :verify, :service_url => @verified_url
        response.should be_success
      end
      
      it "should return a verified indication" do
        get :verify, :service_url => @verified_url
        response.should have_selector("p", :content => "is registered")
      end
      
      it "should return the attributes of the outlet" do
        get :verify, :service_url => @verified_url
        response.should have_selector("p", :content => "is registered")
        response.should have_selector("p", :content => @outlet.organization)
        response.should have_selector("p", :content => @outlet.language)
      end
    end
  end

  describe "DELETE 'destroy'" do
  
    before(:each) do
      # FIXME: Get thee to a factory
      @verified_url = "http://twitter.com/deptofexample"
      @outlet = Outlet.resolve(@verified_url)
      @outlet.language = 'English';
      @outlet.organization = 'Example Campaign'
      @outlet.agencies.push @agency
      @outlet.auth_token = @good_token.token
      @outlet.save!
    end
    
    it "should destroy the outlet" do
      lambda do
       delete :destroy, :service => @outlet.service, :account => @outlet.account, :auth_token => @good_token.token

      end.should change(Outlet, :count).by(-1)
    end

    it "should redirect to the add page" do
      delete :destroy, :service => @outlet.service, :account => @outlet.account, :auth_token => @good_token.token
      response.should redirect_to(add_path)
    end
  end

  describe "POST 'remove'" do
  
    before(:each) do
      # FIXME: Get thee to a factory
      @verified_url = "http://twitter.com/deptofexample"
      @outlet = Outlet.resolve(@verified_url)
      @outlet.language = 'English';
      @outlet.organization = 'Example Campaign'
      @outlet.agencies.push @agency
      @outlet.auth_token = @good_token.token
      @outlet.save!
    end
    
    describe "as an admin user" do

      it "should destroy the outlet" do
        lambda do
          post :remove, :service_url => @outlet.service_url, :auth_token => @good_token.token
        end.should change(Outlet, :count).by(-1)
      end

      it "should redirect to the add page" do
        post :remove, :service_url => @outlet.service_url, :auth_token => @good_token.token
        response.should redirect_to(verify_path(:service_url => @outlet.service_url))
      end
    end
  end
end

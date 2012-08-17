require 'spec_helper'

describe HowtoController do
  render_views
  
  describe "GET 'verify'" do
    it "should be successful" do
      get :verify
      response.should be_success
    end
        
        
    describe "for a verified outlet" do
      before(:each) do
        # FIXME: Get thee to a factory
        @verified_url = "http://twitter.com/deptofexample"
        @outlet = Outlet.resolve(@verified_url)
        @outlet.language = 'English';
        @outlet.organization = 'Example Campaign'
        @agency = Agency.create!(:name => "Department of Examples", :shortname => "example")
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
      
      describe "with a valid auth token" do
        it "should allow registering another" do
          get :verify, :service_url => @verified_url, :auth_token => @good_token.token
          response.should have_selector("input", :value => @good_token.token)
        end
      end
    end
  end
  
  describe "GET 'review'" do
    describe "without a valid auth token"
  
    describe "with a valid auth token" do
      before(:each) do
        @good_token = FactoryGirl.create(:auth_token)

        @outlet = FactoryGirl.build(:outlet, created_at: 9.months.ago, updated_at: 9.months.ago)
        @outlet.auth_token = @good_token.token
        @outlet.agencies << FactoryGirl.create(:agency)
        @outlet.save!
      end
      
      it "should be successful" do
        get :review, :auth_token => @good_token.token
        response.should be_success
      end
      
      it "should show outlets for the authenticated email" do
        get :review, :auth_token => @good_token.token
        response.should have_selector("td", :content => @outlet.service_url)
      end
    end
  end
  
  describe "POST 'confirm'" do
    before(:each) do
      @outlet = FactoryGirl.build(:outlet, created_at: 9.months.ago, updated_at: 9.months.ago)
      @outlet.agencies << FactoryGirl.create(:agency)
      @outlet.save!
    end
    
    describe "with a valid auth token" do
      before(:each) do
        @good_token = FactoryGirl.create(:auth_token)
      end
      
      it "should update the updated_at" do
        post :confirm, :service_url => @outlet.service_url, :auth_token => @good_token.token
        @outlet.reload
        @outlet.updated_at.should > 1.day.ago
      end
      
      it "should update the updated_by" do
        post :confirm, :service_url => @outlet.service_url, :auth_token => @good_token.token
        @outlet.reload
        @outlet.updated_by.should == @good_token.email
      end
    end
  end
end
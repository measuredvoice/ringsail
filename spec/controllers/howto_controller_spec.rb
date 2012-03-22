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
end
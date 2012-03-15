require 'spec_helper'

describe GobiernoController do
  render_views
  
  describe "GET 'verify'" do
    it "should be successful" do
      get :verify
      response.should be_success
    end
        
    it "should be translated" do
      get :verify
      response.should have_selector("p", :content => "Herramientas")      
    end
        
    describe "for an unrecognized service" do
      it "should display a translated error" do
        unrecognized_url = "http://florndip.com/invalid"
        get :verify, :service_url => unrecognized_url
        response.should have_selector("p", :content => "sentimos")
      end
    end
    
    describe "for an unparseable account URL" do
      it "should display a translated error" do
        problem_url = "http://twitter.com/"
        get :verify, :service_url => problem_url
        response.should have_selector("p", :content => "incompleto")
      end
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
      
      it "should be translated" do
        get :verify, :service_url => @verified_url
        response.should have_selector("p", :content => "oficial")      
      end
    end
  end
end
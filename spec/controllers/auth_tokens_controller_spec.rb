require 'spec_helper'

describe AuthTokensController do
  render_views

  describe "GET 'request'" do
    it "should be successful" do
      get :new
      response.should be_success
    end
    
    it "should ask for email and phone" do
      get :new
      response.should have_selector("p", :content => "email address below")
    end
  end
  
  describe "POST 'request'" do
    describe "failure" do

      before(:each) do
        @attr = {
          :email => "",
          :phone => "",
        }
      end
      
      it "should not add an auth token" do
        lambda do
          post :create, @attr
        end.should_not change(AuthToken, :count)
      end

      it "should have the right title" do
        post :create, @attr
        response.should have_selector("title", :content => "Request authorization")
      end
      
      it "should render the 'new' page" do
        post :create, @attr
        response.should render_template('new')
      end
    end

    describe "success" do

      before(:each) do
        @attr = {
          :email => "example@example.gov",
          :phone => "555-1212",
        }
      end
      
      it "should add an auth token" do
        lambda do
          post :create, @attr
        end.should change(AuthToken, :count).by(1)
      end
    end
  end  
end

require 'rails_helper'
RSpec.describe Admin::AgenciesController, type: :controller do
  
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      sign_in FactoryGirl.create(:limited_user)
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "should redirect users who are banned" do
      sign_in FactoryGirl.create(:banned_user)
      get :index
      expect(response).to redirect_to(admin_about_url)
    end
  end

end
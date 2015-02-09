require 'rails_helper'
RSpec.describe Admin::AgenciesController, type: :controller do
  
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code for admin users" do
      sign_in FactoryGirl.create(:admin_user)
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "should redirect users who are not admins" do
      sign_in FactoryGirl.create(:banned_user)
      get :index
      expect(response).to redirect_to(admin_about_url)

      sign_in FactoryGirl.create(:limited_user)
      get :index
      expect(response).to redirect_to(admin_about_url)

      sign_in FactoryGirl.create(:full_user)
      get :index
      expect(response).to redirect_to(admin_about_url)
    end

    it "should render the index view" do
      sign_in FactoryGirl.create(:admin_user)
      get :index
      expect(response).to render_template("index")
    end

    it "load all agencies" do 
      build_agencies = build_list(:agency,20)
      sign_in FactoryGirl.create(:admin_user)
      get :index
      expect(assigns(:agencies)).to match_array(Agency.all)
    end
   end

   describe "POST #create" do 
    it "creates an agency" do
      sign_in FactoryGirl.create(:admin_user)
      agency = FactoryGirl.attributes_for(:agency)
      post :create, agency: agency
      expect(response).to redirect_to(admin_agency_path(assigns(:agency)))
    end
   end

end
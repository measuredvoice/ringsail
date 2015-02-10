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

  describe "GET #show/:id" do
    it "responds successfully with an HTTP 200 status code for admin users" do
      sign_in FactoryGirl.create(:admin_user)
      agency = FactoryGirl.create(:agency)
      get :show, id: agency.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "should redirect users who are not admins" do
      sign_in FactoryGirl.create(:banned_user)
      agency = FactoryGirl.create(:agency)
      get :show, id: agency.id
      expect(response).to redirect_to (admin_about_url)

      sign_in FactoryGirl.create(:limited_user)
      get :show, id: agency.id
      expect(response).to redirect_to (admin_about_url)

      sign_in FactoryGirl.create(:full_user)
      get :show, id: agency.id
      expect(response).to redirect_to (admin_about_url)
    end

    it "should render the show view" do
      sign_in FactoryGirl.create(:admin_user)
      agency = FactoryGirl.create(:agency)
      get :show, id: agency.id
      expect(response).to render_template("show")
    end
  end

  describe "GET #edit/:id" do
    it "responds successfully with an HTTP 200 status code fo admin users" do
      sign_in FactoryGirl.create(:admin_user)
      agency = FactoryGirl.create(:agency)
      get :edit, id: agency.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "should redirect users who are not admins" do
      sign_in FactoryGirl.create(:banned_user)
      agency = FactoryGirl.create(:agency)
      get :edit, id: agency.id
      expect(response).to redirect_to (admin_about_url)

      sign_in FactoryGirl.create(:limited_user)
      get :edit, id: agency.id
      expect(response).to redirect_to (admin_about_url)

      sign_in FactoryGirl.create(:full_user)
      get :edit, id: agency.id
      expect(response).to redirect_to (admin_about_url)
    end

    it "should render the edit view" do
      sign_in FactoryGirl.create(:admin_user)
      agency = FactoryGirl.create(:agency)
      get :edit, id: agency.id
      expect(response).to render_template("edit")
    end
  end


  describe "POST #create" do 
    it "creates an agency" do
      sign_in FactoryGirl.create(:admin_user)
      agency = FactoryGirl.attributes_for(:agency)
      post :create, agency: agency
      expect(response).to redirect_to(admin_agency_path(assigns(:agency)))
    end

    it "should redirect users who are not admins" do
      sign_in FactoryGirl.create(:banned_user)
      agency = FactoryGirl.create(:agency)
      post :create, agency: agency
      expect(response).to redirect_to (admin_about_url)

      sign_in FactoryGirl.create(:limited_user)
      post :create, agency: agency
      expect(response).to redirect_to (admin_about_url)

      sign_in FactoryGirl.create(:full_user)
      post :create, agency: agency
      expect(response).to redirect_to (admin_about_url)
    end
  end

  describe "GET #new" do
    it "responds successfully with an HTTP 200 status code for admin users" do
      sign_in FactoryGirl.create(:admin_user)
      agency = FactoryGirl.create(:agency)
      get :new
      expect(response).to render_template("new")
    end

    it "should redirect users who are not admins" do
      sign_in FactoryGirl.create(:banned_user)
      agency = FactoryGirl.create(:agency)
      get :new
      expect(response).to redirect_to (admin_about_url)

      sign_in FactoryGirl.create(:limited_user)
      get :new
      expect(response).to redirect_to (admin_about_url)

      sign_in FactoryGirl.create(:full_user)
      get :new
      expect(response).to redirect_to (admin_about_url)
    end
  end

  describe "PUT #update/:id" do
    it "responds successfully with an HTTP 200 status code for admin users" do
      sign_in FactoryGirl.create(:admin_user)
      agency = FactoryGirl.attributes_for(:agency, :name => "abcdedfh")
      put :update, agency: agency
      response.should be_success
      expect(response).to redirect_to(admin_agency_path(assigns(:agency)))
     end

    it "should redirect users who are not admins" do
      sign_in FactoryGirl.create(:banned_user)
      agency = FactoryGirl.create(:agency)
      put :update, id: agency.id
      expect(response).to redirect_to (admin_about_url)

      sign_in FactoryGirl.create(:limited_user)
      agency = FactoryGirl.create(:agency)
      put :update, id: agency.id
      expect(response).to redirect_to (admin_about_url)

      sign_in FactoryGirl.create(:full_user)
      agency = FactoryGirl.create(:agency)
      put :update, id: agency.id
      expect(response).to redirect_to (admin_about_url)
    end
  end


end
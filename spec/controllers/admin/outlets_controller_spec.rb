require 'rails_helper'
RSpec.describe Admin::OutletsController, type: :controller do
  
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

    it "load all outlets" do 
      build_outlets = build_list(:outlet,20)
      sign_in FactoryGirl.create(:admin_user)
      get :index
      expect(assigns(:outlets)).to match_array(Outlet.all)
    end
  end

  describe "GET #show/:id" do
    it "responds successfully with an HTTP 200 status code for admin users" do
      sign_in FactoryGirl.create(:admin_user)
      outlet = FactoryGirl.create(:outlet)
      get :show, id: outlet.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "should redirect users who are not admins" do
      sign_in FactoryGirl.create(:banned_user)
      outlet = FactoryGirl.create(:outlet)
      get :show, id: outlet.id
      expect(response).to redirect_to (admin_about_url)

      sign_in FactoryGirl.create(:limited_user)
      get :show, id: outlet.id
      expect(response).to redirect_to (admin_about_url)

      sign_in FactoryGirl.create(:full_user)
      get :show, id: outlet.id
      expect(response).to redirect_to (admin_about_url)
    end

    it "should render the show view" do
      sign_in FactoryGirl.create(:admin_user)
      outlet = FactoryGirl.create(:outlet)
      get :show, id: outlet.id
      expect(response).to render_template("show")
    end
  end

  describe "GET #edit/:id" do
    it "responds successfully with an HTTP 200 status code fo admin users" do
      sign_in FactoryGirl.create(:admin_user)
      outlet = FactoryGirl.create(:outlet)
      get :edit, id: outlet.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "should redirect users who are not admins" do
      sign_in FactoryGirl.create(:banned_user)
      outlet = FactoryGirl.create(:outlet)
      get :edit, id: outlet.id
      expect(response).to redirect_to (admin_about_url)

      sign_in FactoryGirl.create(:limited_user)
      get :edit, id: outlet.id
      expect(response).to redirect_to (admin_about_url)

      sign_in FactoryGirl.create(:full_user)
      get :edit, id: outlet.id
      expect(response).to redirect_to (admin_about_url)
    end

    it "should render the edit view" do
      sign_in FactoryGirl.create(:admin_user)
      outlet = FactoryGirl.create(:outlet)
      get :edit, id: outlet.id
      expect(response).to render_template("edit")
    end
  end


  describe "POST #create" do 
    it "creates an outlet" do
      user = FactoryGirl.create(:admin_user)
      sign_in user
      outlet = FactoryGirl.attributes_for(:outlet)
      outlet[:agency_tokens] = user.agency_id.to_s
      outlet[:user_tokens] = user.id.to_s
      post :create, outlet: outlet
      expect(response).to redirect_to(admin_outlet_path(assigns(:outlet)))
    end

    it "should redirect users who are can not create outlets" do
      sign_in FactoryGirl.create(:banned_user)
      outlet = FactoryGirl.create(:outlet)
      post :create, outlet: outlet
      expect(response).to redirect_to (admin_about_url)
    end
  end

  describe "GET #new" do
    it "responds successfully with an HTTP 200 status code for user who can create outlets" do
      sign_in FactoryGirl.create(:admin_user)
      outlet = FactoryGirl.create(:outlet)
      get :new
      expect(response).to render_template("new")

      sign_in FactoryGirl.create(:limited_user)
      outlet = FactoryGirl.create(:outlet)
      get :new
      expect(response).to render_template("new")

      sign_in FactoryGirl.create(:full_user)
      outlet = FactoryGirl.create(:outlet)
      get :new
      expect(response).to render_template("new")
    end

    it "should redirect users who can not create outlets" do
      sign_in FactoryGirl.create(:banned_user)
      outlet = FactoryGirl.create(:outlet)
      get :new
      expect(response).to redirect_to (admin_about_url)
    end
  end

  describe "PUT #update/:id" do
    it "responds successfully with an HTTP 200 status code for users with permission to do so" do
      sign_in FactoryGirl.create(:admin_user)
      outlet = FactoryGirl.create(:outlet)
      outlet_attributes = FactoryGirl.attributes_for(:outlet)
      put :update, id: outlet.id, outlet: outlet_attributes
      expect(response).to redirect_to(admin_outlet_path(assigns(:outlet)))


      sign_in FactoryGirl.create(:limited_user)
      outlet = FactoryGirl.create(:outlet)
      outlet_attributes = FactoryGirl.attributes_for(:outlet)
      put :update, id: outlet.id, outlet: outlet_attributes
      expect(response).to redirect_to(admin_outlet_path(assigns(:outlet)))

      sign_in FactoryGirl.create(:full_user)
      outlet = FactoryGirl.create(:outlet)
      outlet_attributes = FactoryGirl.attributes_for(:outlet)
      put :update, id: outlet.id, outlet: outlet_attributes
      expect(response).to redirect_to(admin_outlet_path(assigns(:outlet)))
     end

    it "should redirect users who are not admins" do
      sign_in FactoryGirl.create(:banned_user)
      outlet = FactoryGirl.create(:outlet)
      put :update, id: outlet.id
      expect(response).to redirect_to (admin_about_url)
  end


  describe "GET /outlets/:id/publish" do
    it "should allow admins to publish an outlet" do
      sign_in FactoryGirl.create(:admin_user)
      outlet = FactoryGirl.create(:outlet)
      get :publish, id: outlet.id
      expect(response).to redirect_to(admin_outlet_path(assigns(:outlet)))
    end

    it "should redirect non-admins trying to publish an outlet" do
      sign_in FactoryGirl.create(:banned_user)
      outlet = FactoryGirl.create(:outlet)
      get :publish, id: outlet.id
      expect(response).to redirect_to (admin_about_url)

      sign_in FactoryGirl.create(:limited_user)
      outlet = FactoryGirl.create(:outlet)
      get :publish, id: outlet.id
      expect(response).to redirect_to (admin_about_url)

      sign_in FactoryGirl.create(:full_user)
      outlet = FactoryGirl.create(:outlet)
      get :publish, id: outlet.id
      expect(response).to redirect_to (admin_about_url)
    end
  end

  describe "GET /outlets/:id/archived" do
    it "should allow admins to archive an outlet" do
      sign_in FactoryGirl.create(:admin_user)
      outlet = FactoryGirl.create(:outlet)
      outlet.published!
      get :archive, id: outlet.id
      expect(response).to redirect_to(admin_outlet_path(assigns(:outlet)))
    end

    it "should redirect non-admins trying to archive an outlet" do
      sign_in FactoryGirl.create(:banned_user)
      outlet = FactoryGirl.create(:outlet)
      get :archive, id: outlet.id
      expect(response).to redirect_to (admin_about_url)

      sign_in FactoryGirl.create(:limited_user)
      outlet = FactoryGirl.create(:outlet)
      get :archive, id: outlet.id
      expect(response).to redirect_to (admin_about_url)

      sign_in FactoryGirl.create(:full_user)
      outlet = FactoryGirl.create(:outlet)
      get :archive, id: outlet.id
      expect(response).to redirect_to (admin_about_url)
    end
  end

  describe "GET /outlets/activities" do
    it "should allow users to view all activities" do
      sign_in FactoryGirl.create(:admin_user)
      get :activities
      expect(response).to be_success
      expect(assigns[:activities]).to match_array(PublicActivity::Activity.where(trackable_type: "Outlet"))
      expect(response).to render_template("activities")
    end
  end

  describe "GET /outlets/:id/history" do
    it "should allow users to view all activities" do
      sign_in FactoryGirl.create(:admin_user)
      outlet = FactoryGirl.create(:outlet)
      outlet.published!
      get :history, id: outlet.id
      expect(response).to be_success
      expect(assigns[:versions]).to match(outlet.versions)
      expect(response).to render_template("history")
    end
  end

end
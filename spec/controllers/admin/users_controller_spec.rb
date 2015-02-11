require 'rails_helper'
RSpec.describe Admin::UsersController, type: :controller do
  
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code for admin users" do
      sign_in FactoryGirl.create(:admin_user)
      user = FactoryGirl.create(:user)
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "should redirect users who are not admins" do
      sign_in FactoryGirl.create(:banned_user)
      user = FactoryGirl.create(:user)
      get :index
      expect(response).to redirect_to(admin_about_url)

      sign_in FactoryGirl.create(:limited_user)
      user = FactoryGirl.create(:user)
      get :index
      expect(response).to redirect_to(admin_about_url)

      sign_in FactoryGirl.create(:full_user)
      user = FactoryGirl.create(:user)
      get :index
      expect(response).to redirect_to(admin_about_url)
    end

    it "should render the index view" do
      sign_in FactoryGirl.create(:admin_user)
      user = FactoryGirl.create(:user)
      get :index
      expect(response).to render_template("index")
    end

    it "load all users" do 
      build_users = build_list(:user,20)
      sign_in FactoryGirl.create(:admin_user)
      get :index
      expect(assigns(:users)).to match_array(User.all)
    end
  end

  describe "GET #show/:id" do
    it "responds successfully with an HTTP 200 status code for admin users" do
      sign_in FactoryGirl.create(:admin_user)
      user = FactoryGirl.create(:user)
      get :show, id: user.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "should redirect users who are not admins" do
      sign_in FactoryGirl.create(:banned_user)
      user = FactoryGirl.create(:user)
      get :show, id: user.id
      expect(response).to redirect_to (admin_about_url)

      sign_in FactoryGirl.create(:limited_user)
      user = FactoryGirl.create(:user)
      get :show, id: user.id
      expect(response).to redirect_to (admin_about_url)

      sign_in FactoryGirl.create(:full_user)
      user = FactoryGirl.create(:user)
      get :show, id: user.id
      expect(response).to redirect_to (admin_about_url)
    end

    it "should render the show view" do
      sign_in FactoryGirl.create(:admin_user)
      user = FactoryGirl.create(:user)
      get :show, id: user.id
      expect(response).to render_template("show")
    end
  end

  describe "GET #edit/:id" do
    it "responds successfully with an HTTP 200 status code fo admin users" do
      sign_in FactoryGirl.create(:admin_user)
      user = FactoryGirl.create(:user)
      get :edit, id: user.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "should redirect users who are not admins" do
      sign_in FactoryGirl.create(:banned_user)
      user = FactoryGirl.create(:user)
      get :edit, id: user.id
      expect(response).to redirect_to (admin_about_url)

      sign_in FactoryGirl.create(:limited_user)
      user = FactoryGirl.create(:user)
      get :edit, id: user.id
      expect(response).to redirect_to (admin_about_url)

      sign_in FactoryGirl.create(:full_user)
      user = FactoryGirl.create(:user)
      get :edit, id: user.id
      expect(response).to redirect_to (admin_about_url)
    end

    it "should render the edit view" do
      sign_in FactoryGirl.create(:admin_user)
      user = FactoryGirl.create(:user)
      get :edit, id: user.id
      expect(response).to render_template("edit")
    end
  end

  describe "POST #create" do
    it "responds successfully with an HTTP 200 status code for admin users" do
      sign_in FactoryGirl.create(:admin_user)
      user = FactoryGirl.attributes_for(:user)
      user[:role] = "limited_user"
      post :create, user: user
      expect(response).to redirect_to(admin_user_path(assigns(:user)))
    end

    it "should redirect users who are not admins" do
      sign_in FactoryGirl.create(:banned_user)
      user = FactoryGirl.attributes_for(:user)
      post :create, user: user
      expect(response).to redirect_to(admin_about_url)

      sign_in FactoryGirl.create(:limited_user)
      user = FactoryGirl.attributes_for(:user)
      post :create, user: user
      expect(response).to redirect_to(admin_about_url)

      sign_in FactoryGirl.create(:full_user)
      user = FactoryGirl.attributes_for(:user)
      post :create, user: user
      expect(response).to redirect_to(admin_about_url)
    end
  end

  describe "GET #new" do
    it "responds successfully with an HTTP 200 status code for admin users" do
      sign_in FactoryGirl.create(:admin_user)
      user = FactoryGirl.create(:user)
      get :new
      expect(response).to render_template("new")
    end

    it "should redirect users who are not admins" do
      sign_in FactoryGirl.create(:banned_user)
      user = FactoryGirl.create(:user)
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

  describe "GET /users/tokeninput" do
    it "should allow lookup of users by text" do
      user = FactoryGirl.create(:admin_user)
      sign_in user
      get :tokeninput, format: :json, q: user.first_name.first(2)
      expect(assigns[:users]).to match([user])
      expect(response).to render_template("tokeninput")
    end
  end

end
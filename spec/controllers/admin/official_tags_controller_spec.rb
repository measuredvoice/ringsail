require 'rails_helper'
RSpec.describe Admin::OfficialTagsController, type: :controller do

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code for admin users" do
      sign_in FactoryGirl.create(:admin_user)
      official_tag = FactoryGirl.create(:official_tag)
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "should redirect users who are not admins" do
      sign_in FactoryGirl.create(:banned_user)
      official_tag = FactoryGirl.create(:official_tag)
      get :index
      expect(response).to redirect_to(admin_about_url)

      sign_in FactoryGirl.create(:user)
      official_tag = FactoryGirl.create(:official_tag)
      get :index
      expect(response).to redirect_to(admin_about_url)

      sign_in FactoryGirl.create(:super_user)
      official_tag = FactoryGirl.create(:official_tag)
      get :index
      expect(response).to redirect_to(admin_about_url)
    end

    it "should render the index view" do
      sign_in FactoryGirl.create(:admin_user)
      official_tag = FactoryGirl.create(:official_tag)
      get :index
      expect(response).to render_template("index")
    end

    it "load all official tags" do
      build_official_tags = build_list(:official_tag,20)
      sign_in FactoryGirl.create(:admin_user)
      get :index
      expect(assigns(:official_tags)).to match_array(OfficialTag.all)
    end
  end

  describe "GET #show/:id" do
    it "responds successfully with an HTTP 200 status code for admin users" do
      sign_in FactoryGirl.create(:admin_user)
      official_tag = FactoryGirl.create(:official_tag)
      get :show, id: official_tag.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "should redirect users who are not admins" do
      sign_in FactoryGirl.create(:banned_user)
      official_tag = FactoryGirl.create(:official_tag)
      get :show, id: official_tag.id
      expect(response).to redirect_to (admin_about_url)

      sign_in FactoryGirl.create(:user)
      get :show, id: official_tag.id
      expect(response).to redirect_to (admin_about_url)

      sign_in FactoryGirl.create(:super_user)
      get :show, id: official_tag.id
      expect(response).to redirect_to (admin_about_url)
    end

    it "should render the show view" do
      sign_in FactoryGirl.create(:admin_user)
      official_tag = FactoryGirl.create(:official_tag)
      get :show, id: official_tag.id
      expect(response).to render_template("show")
    end
  end

  describe "GET #edit/:id" do
    it "responds successfully with an HTTP 200 status code fo admin users" do
      sign_in FactoryGirl.create(:admin_user)
      official_tag = FactoryGirl.create(:official_tag)
      get :edit, id: official_tag.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "should redirect users who are not admins" do
      sign_in FactoryGirl.create(:banned_user)
      official_tag = FactoryGirl.create(:official_tag)
      get :edit, id: official_tag.id
      expect(response).to redirect_to (admin_about_url)

      sign_in FactoryGirl.create(:user)
      get :edit, id: official_tag.id
      expect(response).to redirect_to (admin_about_url)

      sign_in FactoryGirl.create(:super_user)
      get :edit, id: official_tag.id
      expect(response).to redirect_to (admin_about_url)
    end

    it "should render the edit view" do
      sign_in FactoryGirl.create(:admin_user)
      official_tag = FactoryGirl.create(:official_tag)
      get :edit, id: official_tag.id
      expect(response).to render_template("edit")
    end
  end


  describe "POST #create" do
    it "creates an official_tag" do
      sign_in FactoryGirl.create(:admin_user)
      official_tag = FactoryGirl.attributes_for(:official_tag)
      post :create, official_tag: official_tag
      expect(response).to redirect_to(admin_official_tag_path(assigns(:official_tag)))
    end

    it "should redirect users who are not admins" do
      sign_in FactoryGirl.create(:banned_user)
      official_tag = FactoryGirl.attributes_for(:official_tag)
      post :create, official_tag: official_tag
      expect(response).to redirect_to (admin_about_url)

      sign_in FactoryGirl.create(:user)
      official_tag = FactoryGirl.attributes_for(:official_tag)
      post :create, official_tag: official_tag
      expect(response).to redirect_to (admin_about_url)

      sign_in FactoryGirl.create(:super_user)
      official_tag = FactoryGirl.attributes_for(:official_tag)
      post :create, official_tag: official_tag
      expect(response).to redirect_to (admin_about_url)
    end
  end

  describe "GET #new" do
    it "responds successfully with an HTTP 200 status code for admin users" do
      sign_in FactoryGirl.create(:admin_user)
      official_tag = FactoryGirl.create(:official_tag)
      get :new
      expect(response).to be_success
      expect(response).to render_template("new")
    end

    it "should redirect users who are not admins" do
      sign_in FactoryGirl.create(:banned_user)
      official_tag = FactoryGirl.create(:official_tag)
      get :new
      expect(response).to redirect_to(admin_about_url)

      sign_in FactoryGirl.create(:user)
      get :new
      expect(response).to redirect_to(admin_about_url)

      sign_in FactoryGirl.create(:super_user)
      get :new
      expect(response).to redirect_to(admin_about_url)
    end
  end

  describe "PUT #update/:id" do
    it "responds successfully with an HTTP 200 status code for admin users" do
      sign_in FactoryGirl.create(:admin_user)
      official_tag = FactoryGirl.create(:official_tag)
      official_tag_attributes = FactoryGirl.attributes_for(:official_tag)
      put :update, id: official_tag.id, official_tag: official_tag_attributes
      expect(response).to redirect_to(admin_official_tag_path(assigns(:official_tag)))
     end

    it "should redirect users who are not admins" do
      sign_in FactoryGirl.create(:banned_user)
      official_tag = FactoryGirl.create(:official_tag)
      put :update, id: official_tag.id
      expect(response).to redirect_to (admin_about_url)

      sign_in FactoryGirl.create(:user)
      official_tag = FactoryGirl.create(:official_tag)
      put :update, id: official_tag.id
      expect(response).to redirect_to (admin_about_url)

      sign_in FactoryGirl.create(:super_user)
      official_tag = FactoryGirl.create(:official_tag)
      put :update, id: official_tag.id
      expect(response).to redirect_to (admin_about_url)
    end
  end

  # describe "GET /official_tags/tokeninput" do
  #   it "should allow lookup of tags by text" do
  #     sign_in FactoryGirl.create(:admin_user)
  #     official_tag = FactoryGirl.create(:official_tag)
  #     get :tokeninput, format: :json, q: official_tag.tag_text.first(2)
  #     expect(assigns[:official_tags]).to match([official_tag])
  #     expect(response).to render_template("tokeninput")
  #   end
  # end

end

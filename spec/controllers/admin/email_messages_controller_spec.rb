require 'rails_helper'
RSpec.describe Admin::EmailMessagesController, type: :controller do
  
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code for admin users" do
      sign_in FactoryGirl.create(:admin_user)
      email_message = FactoryGirl.create(:email_message)
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "should redirect users who are not admins" do
      sign_in FactoryGirl.create(:banned_user)
      get :index
      expect(response).to redirect_to(admin_about_url)

      sign_in FactoryGirl.create(:user)
      get :index
      expect(response).to redirect_to(admin_about_url)

      sign_in FactoryGirl.create(:super_user)
      get :index
      expect(response).to redirect_to(admin_about_url)
    end

    it "should render the index view" do
      sign_in FactoryGirl.create(:admin_user)
      get :index
      expect(response).to render_template("index")
    end

    it "load all email messages" do 
      build_emails = build_list(:email_message,20)
      sign_in FactoryGirl.create(:admin_user)
      get :index
      expect(assigns(:email_messages)).to match_array(EmailMessage.all)
    end
  end

   describe "POST #create" do
    it "responds successfully with an HTTP 200 status and render sent template" do
      sign_in FactoryGirl.create(:admin_user)
      email_message = FactoryGirl.attributes_for(:email_message)
      post :create, email_message: email_message
      expect(response).to be_success
      expect(response).to render_template("sent")


      sign_in FactoryGirl.create(:user)
      email_message = FactoryGirl.attributes_for(:email_message)
      post :create, email_message: email_message
      expect(response).to be_success
      expect(response).to render_template("sent")

      sign_in FactoryGirl.create(:super_user)
      email_message = FactoryGirl.attributes_for(:email_message)
      post :create, email_message: email_message
      expect(response).to be_success
      expect(response).to render_template("sent")
    end

    it "should redirect users who are banned" do
      sign_in FactoryGirl.create(:banned_user)
      email_message = FactoryGirl.attributes_for(:email_message)
      post :create, email_message: email_message
      expect(response).to redirect_to (admin_about_url)
    end
  end

  describe "GET #new" do
    it "responds successfully with an HTTP 200 status code for admin users" do
      sign_in FactoryGirl.create(:admin_user)
      email_message = FactoryGirl.create(:email_message)
      get :new
      expect(response).to be_success
      expect(response).to render_template("new")

      sign_in FactoryGirl.create(:user)
      email_message = FactoryGirl.create(:email_message)
      get :new
      expect(response).to be_success
      expect(response).to render_template("new")

      sign_in FactoryGirl.create(:super_user)
      email_message = FactoryGirl.create(:email_message)
      get :new
      expect(response).to be_success
      expect(response).to render_template("new")
    end

    it "should redirect users who are baned" do
      sign_in FactoryGirl.create(:banned_user)
      email_message = FactoryGirl.create(:email_message)
      get :new
      expect(response).to redirect_to (admin_about_url)
    end
  end


end
require 'rails_helper'
RSpec.describe Admin::MobileAppsController, type: :controller do 

	describe "GET #index" do
		it "responds successfully with an HTTP 200 status code for admin users" do
			sign_in FactoryGirl.create(:admin_user)
			get :index
			expect(response).to be_success
			expect(response).to have_http_status(200)
		end

		it  "should redirect users who are not admins" do 
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

		it "load all mobile apps" do
			build_mobile_apps = build_list(:mobile_app,20)
			sign_in FactoryGirl.create(:admin_user)
			get :index
			expect(assigns(:mobile_apps)).to match_array(MobileApp.all)
		end
	end

	describe "GET #show/:id" do
		it "responds successfully with an HTTP 200 status code for admin users" do
			sign_in FactoryGirl.create(:admin_user)
			mobile_app = FactoryGirl.create(:mobile_app)
			get :show, id: mobile_app.id
			expect(response).to be_success
			expect(response).to have_http_status(200)
		end

		it "should redirect users who are not admins" do
			sign_in FactoryGirl.create(:banned_user)
			mobile_app = FactoryGirl.create(:mobile_app)
			get :show, id: mobile_app.id
			expect(response).to redirect_to (admin_about_url)

			sign_in FactoryGirl.create(:user)
			get :show, id: mobile_app.id
			expect(response).to redirect_to (admin_about_url)

			sign_in FactoryGirl.create(:super_user)
			get :show, id: mobile_app.id
			expect(response).to redirect_to (admin_about_url)
		end

		it "should render the show view" do
			sign_in FactoryGirl.create(:admin_user)
			mobile_app = FactoryGirl.create(:mobile_app)
			get :show, id: mobile_app.id
			expect(response).to render_template("show")
		end
	end

	describe "Get #edit/:id" do
		it "responds successfully with an HTTP 200 status code for admin users" do
			sign_in FactoryGirl.create(:admin_user)
			mobile_app = FactoryGirl.create(:mobile_app)
			get :edit, id: mobile_app.id
			expect(response).to be_success
			expect(response).to have_http_status(200)
		end

		it "should redirect users who are not admins" do
			sign_in FactoryGirl.create(:banned_user)
      		mobile_app = FactoryGirl.create(:mobile_app)
      		get :edit, id: mobile_app.id
      		expect(response).to redirect_to(admin_about_url)

      		sign_in FactoryGirl.create(:user)
      		get :edit, id: mobile_app.id
      		expect(response).to redirect_to(admin_about_url)

      		sign_in FactoryGirl.create(:super_user)
      		get :edit, id: mobile_app.id
      		expect(response).to redirect_to(admin_about_url)
		end

		it "should render the edit view" do
      		sign_in FactoryGirl.create(:admin_user)
      		mobile_app = FactoryGirl.create(:mobile_app)
      		get :edit, id: mobile_app.id
      		expect(response).to render_template("edit")
    	end
	end

	describe "POST #create" do
		it "creates a mobile app" do
			sign_in FactoryGirl.create(:banned_user)
			mobile_app = FactoryGirl.attributes_for(:mobile_app)
			post :create, mobile_app: mobile_app
			expect(response).to redirect_to(admin_about_url)
		end

		it "should redirect users who are not admins" do
			sign_in FactoryGirl.create(:banned_user)
			mobile_app = FactoryGirl.create(:mobile_app)
			post :create, mobile_app: mobile_app
			expect(response).to redirect_to(admin_about_url)

			sign_in FactoryGirl.create(:user)
			post :create, mobile_app: mobile_app
			expect(response).to redirect_to(admin_about_url)

			sign_in FactoryGirl.create(:super_user)
			post :create, mobile_app: mobile_app
			expect(response).to redirect_to(admin_about_url)
		end
	end

  	describe "GET #new" do
	    it "responds successfully with an HTTP 200 status code for admin users" do
			sign_in FactoryGirl.create(:admin_user)
			mobile_app = FactoryGirl.create(:mobile_app)
			get :new
			expect(response).to render_template("new")
	    end

	    it "should redirect users who are not admins" do
			sign_in FactoryGirl.create(:banned_user)
			mobile_app = FactoryGirl.create(:mobile_app)
			get :new
			expect(response).to redirect_to (admin_about_url)

			sign_in FactoryGirl.create(:user)
			get :new
			expect(response).to redirect_to (admin_about_url)

			sign_in FactoryGirl.create(:super_user)
			get :new
			expect(response).to redirect_to (admin_about_url)
	    end
  	end

  	describe "PUT #update/:id" do
		it "responds successfully with an HTTP 200 status code for admin users" do
			sign_in FactoryGirl.create(:admin_user)
			mobile_app = FactoryGirl.create(:mobile_app)
			mobile_app_attributes = FactoryGirl.attributes_for(:mobile_app)
			put :update, id: mobile_app.id, mobile_app: mobile_app_attributes
			expect(response).to redirect_to(admin_mobile_app_url(assigns(:mobile_app)))
		end

		it "should redirect users who are not admins" do
			sign_in FactoryGirl.create(:banned_user)
			mobile_app = FactoryGirl.create(:mobile_app)
			put :update, id: mobile_app.id
			expect(response).to redirect_to (admin_about_url)

			sign_in FactoryGirl.create(:user)
			mobile_app = FactoryGirl.create(:mobile_app)
			put :update, id: mobile_app.id
			expect(response).to redirect_to (admin_about_url)

			sign_in FactoryGirl.create(:super_user)
			mobile_app = FactoryGirl.create(:mobile_app)
			put :update, id: mobile_app.id
			expect(response).to redirect_to (admin_about_url)
		end
    end
end
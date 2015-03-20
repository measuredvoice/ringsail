require 'rails_helper'
RSpec.describe Admin::GalleriesController, type: :controller do
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

		it "load all galleries" do 
			build_galleries = build_list(:gallery,20)
			sign_in FactoryGirl.create(:admin_user)
			get :index
			expect(assigns(:galleries)).to match_array(Gallery.all)
		end
	end

	describe "GET #show/:id" do
		it "responds successfully with an HTTP 200 status code for admin users" do
			sign_in FactoryGirl.create(:admin_user)
			gallery = FactoryGirl.create(:gallery)
			get :show, id: gallery.id
			expect(response).to be_success
			expect(response).to have_http_status(200)
		end

		it "should redirect users who are not admins" do
			sign_in FactoryGirl.create(:banned_user)
			gallery = FactoryGirl.create(:gallery)
			get :show, id: gallery.id
			expect(response).to redirect_to (admin_about_url)

			sign_in FactoryGirl.create(:user)
			get :show, id: gallery.id
			expect(response).to redirect_to (admin_about_url)

			sign_in FactoryGirl.create(:super_user)
			get :show, id: gallery.id
			expect(response).to redirect_to (admin_about_url)
		end

		it "should render the show view" do
			sign_in FactoryGirl.create(:admin_user)
			gallery = FactoryGirl.create(:gallery)
			get :show, id: gallery.id
			expect(response).to render_template("show")
		end
	end

	describe "GET #edit/:id" do
		it "responds successfully with an HTTP 200 status code fo admin users" do
			sign_in FactoryGirl.create(:admin_user)
			gallery = FactoryGirl.create(:gallery)
			get :edit, id: gallery.id
			expect(response).to be_success
			expect(response).to have_http_status(200)
		end

		it "should redirect users who are not admins" do
			sign_in FactoryGirl.create(:banned_user)
			gallery = FactoryGirl.create(:gallery)
			get :edit, id: gallery.id
			expect(response).to redirect_to (admin_about_url)

			sign_in FactoryGirl.create(:user)
			get :edit, id: gallery.id
			expect(response).to redirect_to (admin_about_url)

			sign_in FactoryGirl.create(:super_user)
			get :edit, id: gallery.id
			expect(response).to redirect_to (admin_about_url)
		end

		it "should render the edit view" do
	 		sign_in FactoryGirl.create(:admin_user)
	 		gallery = FactoryGirl.create(:gallery)
	  		get :edit, id: gallery.id
	  		expect(response).to render_template("edit")
		end
	end


	describe "POST #create" do 
		it "creates a gallery" do
				user = FactoryGirl.create(:admin_user)
	  		sign_in user
	  		gallery = FactoryGirl.attributes_for(:gallery)
	  		gallery[:agency_tokens] = user.agency_id.to_s
      	gallery[:user_tokens] = user.id.to_s
	  		post :create, gallery: gallery
	  		expect(response).to redirect_to(admin_gallery_path(assigns(:gallery)))
		end

		it "should redirect users who are not admins" do
			sign_in FactoryGirl.create(:banned_user)
			gallery = FactoryGirl.create(:gallery)
			post :create, gallery: gallery
			expect(response).to redirect_to (admin_about_url)

			sign_in FactoryGirl.create(:user)
			post :create, gallery: gallery
			expect(response).to redirect_to (admin_about_url)

			sign_in FactoryGirl.create(:super_user)
			post :create, gallery: gallery
			expect(response).to redirect_to (admin_about_url)
		end
	end

	describe "GET #new" do
		it "responds successfully with an HTTP 200 status code for admin users" do
			sign_in FactoryGirl.create(:admin_user)
			gallery = FactoryGirl.create(:gallery)
			get :new
			expect(response).to render_template("new")
		end

		it "should redirect users who are not admins" do
			sign_in FactoryGirl.create(:banned_user)
			gallery = FactoryGirl.create(:gallery)
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
	  		gallery = FactoryGirl.create(:gallery)
	  		gallery_attributes = FactoryGirl.attributes_for(:gallery)
	  		put :update, id: gallery.id, gallery: gallery_attributes
	  		expect(response).to redirect_to(admin_gallery_url(assigns(:gallery)))
	 	end

		it "should redirect users who are not admins" do
	  		sign_in FactoryGirl.create(:banned_user)
	  		gallery = FactoryGirl.create(:gallery)
	  		put :update, id: gallery.id
	  		expect(response).to redirect_to (admin_about_url)

	  		sign_in FactoryGirl.create(:user)
	  		gallery = FactoryGirl.create(:gallery)
	  		put :update, id: gallery.id
	  		expect(response).to redirect_to (admin_about_url)

	  		sign_in FactoryGirl.create(:super_user)
	  		gallery = FactoryGirl.create(:gallery)
	  		put :update, id: gallery.id
	  		expect(response).to redirect_to (admin_about_url)
		end
	end
end
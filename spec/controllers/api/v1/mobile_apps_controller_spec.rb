require 'rails_helper'
RSpec.describe Api::V1::MobileAppsController, type: :controller do
	describe "GET #index" do
		it 'responds successfully with an HTTP 200 status code' do
			get :index, format: :json 
			expect(response).to be_success
			expect(response).to have_http_status(200)
		end

		it 'should render the index view' do
			get :index, format: :json
			expect(response).to render_template("index")
		end

		it 'loads all mobile_apps' do
			build_mobile_apps = build_list(:mobile_app, 20)
			get :index, format: :json
			expect(assigns(:mobile_apps)).to match_array(MobileApp.all)
		end
	end

	describe "GET #show/:id" do
		it 'responds successfully with an http status code' do
			mobile_app = FactoryGirl.create(:mobile_app)
			get :show, id: mobile_app.id, format: :json
			expect(response).to be_success
			expect(response).to have_http_status(200)
		end
		it 'should render the show view' do
			mobile_app = FactoryGirl.create(:mobile_app)
			get :show, id: mobile_app.id, format: :json
			expect(response).to render_template("show")
		end
	end
end
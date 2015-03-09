require 'rails_helper'
RSpec.describe Api::V1::SocialMediaController, type: :controller do
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

		it 'loads all outlets' do
			build_outlets = build_list(:outlet, 20)
			get :index, format: :json
			expect(assigns(:outlets)).to match_array(Outlet.all)
		end
	end

	describe "GET #show/:id" do
		it 'responds successfully with an http status code' do
			outlet = FactoryGirl.create(:outlet)
			get :show, id: outlet.id, format: :json
			expect(response).to be_success
			expect(response).to have_http_status(200)
		end
		it 'should render the show view' do
			outlet = FactoryGirl.create(:outlet)
			get :show, id: outlet.id, format: :json
			expect(response).to render_template("show")
		end
	end



end
require 'rails_helper'
RSpec.describe Api::V1::AgenciesController, type: :controller do
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

		it 'loads all agencies' do
			build_agencies = build_list(:agency, 20)
			get :index, format: :json
			expect(assigns(:agencies)).to match_array(Agency.all)
		end
	end

	describe "GET #show/:id" do
		it 'responds successfully with an http status code' do
			agency = FactoryGirl.create(:agency)
			get :show, id: agency.id, format: :json
			expect(response).to be_success
			expect(response).to have_http_status(200)
		end
		it 'should render the show view' do
			agency = FactoryGirl.create(:agency)
			get :show, id: agency.id, format: :json
			expect(response).to render_template("show")
		end
	end
end
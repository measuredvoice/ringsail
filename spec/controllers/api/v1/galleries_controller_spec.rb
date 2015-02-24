require 'rails_helper'
RSpec.describe Api::V1::GalleriesController, type: :controller do
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

		it 'loads all galleries' do
			build_galleries = build_list(:gallery, 20)
			get :index, format: :json
			expect(assigns(:galleries)).to match_array(Gallery.all)
		end
	end

	describe "GET #show/:id" do
		it 'responds successfully with an http status code' do
			gallery = FactoryGirl.create(:gallery)
			get :show, id: gallery.id, format: :json
			expect(response).to be_success
			expect(response).to have_http_status(200)
		end
		it 'should render the show view' do
			gallery = FactoryGirl.create(:gallery)
			get :show, id: gallery.id, format: :json
			expect(response).to render_template("show")
		end
	end
end
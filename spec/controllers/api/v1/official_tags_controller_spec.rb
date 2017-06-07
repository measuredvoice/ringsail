require 'rails_helper'
RSpec.describe DigitalRegistry::V1::TagsController, type: :controller do

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

		it 'loads all official tags' do
			build_official_tags = build_list(:official_tag, 20)
			get :index, format: :json
			expect(assigns(:official_tags)).to match_array(OfficialTag.all)
		end
	end

	describe "GET #show/:id" do
		it 'responds successfully with an http status code' do
			official_tag = FactoryGirl.create(:official_tag)
			get :show, id: official_tag.id, format: :json
			expect(response).to be_success
			expect(response).to have_http_status(200)
		end
		it 'should render the show view' do
			official_tag = FactoryGirl.create(:official_tag)
			get :show, id: official_tag.id, format: :json
			expect(response).to render_template("show")
		end
	end



end
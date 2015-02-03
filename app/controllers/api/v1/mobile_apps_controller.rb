class Api::V1::MobileAppsController < Api::ApiController
	swagger_controller :mobile_apps, "Government Mobile Apps"

	swagger_api :index do
		summary "Fetches all mobile apps"
    notes "This lists all active mobile apps.  It accepts parameters to perform basic search."
    param :query, :q, :string, :optional, "String to compare to the name & short description of the mobile apps."
    param :query, :page_size, :integer, :optional, "Number of results per page"
    param :query, :page, :integer, :optional, "Page number"
    response :ok, "Success"
    response :not_acceptable, "The request you made is not acceptable"
    response :requested_range_not_satisfiable		
		response :not_found
	end

	PAGE_SIZE=25
	DEFAULT_PAGE=1

	def index
		if params[:q]
			@mobile_apps =  MobileApp.where("name LIKE ? or short_description LIKE ?", "%#{params[:q]}%",
				"%#{params[:q]}%").page(params[:page] || DEFAULT_PAGE).per(params[:page_size] || PAGE_SIZE)
		else
			@mobile_apps = MobileApp.all.page(params[:page] || DEFAULT_PAGE).per(params[:page_size] || PAGE_SIZE)
		end
		respond_to do |format|
			format.json { render "index" }
		end		
	end

	swagger_api :show do
		summary "Fetches a single mobile app item"
		notes "This returns an mobile app based on an ID."
		param :path, :id, :integer, :required, "ID of the mobile app"
		response :ok, "Success" 
		response :not_acceptable, "The request you made is not available"
		response :requested_range_not_satisfiable
		response :not_found
	end
	def show
		@mobile_app =  MobileApp.find(params[:id])
		respond_to do |format|
			format.json { render "show" }
		end		
	end
end

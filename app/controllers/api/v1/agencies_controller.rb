class Api::V1::AgenciesController < Api::ApiController

	swagger_controller :agencies, "Government Agencies"

	swagger_api :index do
		summary "Fetches all agencies"
    notes "This lists all active agencies in the system. These agencies can be used to query for social media accounts, mobile products, and galleries."
    param :query, :q, :string, :optional, "String to compare to the name & acronym of the agencies."
    param :query, :page_size, :integer, :optional, "Number of results per page"
    param :query, :page, :integer, :optional, "Page number"
	end

	swagger_api :show do
		summary "Fetches a single agency and its metadata."
		notes "This returns an agency based on an ID."
		param :path, :id, :integer, :required, "ID of the agency"
	end

	PAGE_SIZE=25
	DEFAULT_PAGE=1

	def index
		params[:page_size] = params[:page_size] || PAGE_SIZE
		if params[:q]
			@agencies = Agency.where("name LIKE ? or shortname LIKE ?", 
				"%#{params[:q]}%", "%#{params[:q]}%")
		else
			@agencies = Agency.all
		end
    @agencies = @agencies.page(params[:page] || DEFAULT_PAGE).per(params[:page_size] || PAGE_SIZE)
		respond_to do |format|
			format.json { render "index"}
		end
	end

	def show
		params[:page_size] = params[:page_size] || PAGE_SIZE
		@agencies = Agency.where(id: params[:id]).page(params[:page] || DEFAULT_PAGE).per(params[:page_size] || PAGE_SIZE)
		respond_to do |format|
			format.json { render "show"}
		end
	end
end
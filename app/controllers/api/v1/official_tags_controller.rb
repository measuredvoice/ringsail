class Api::V1::OfficialTagsController < Api::ApiController

	swagger_controller :official_tags, "Official Tags"

	swagger_api :index do
		summary "Fetches all official tags"
    notes "This lists all active agencies.  It accepts parameters to perform basic search."
    param :query, :q, :string, :optional, "String to compare to the short name of tags."
    param :query, :page_size, :integer, :optional, "Number of results per page"
    param :query, :page, :integer, :optional, "Page number"
    response :unauthorized
    response :not_acceptable, "The request you made is not acceptable"
    response :requested_range_not_satisfiable
	end

	swagger_api :show do
		summary "Fetches all official tags"
    notes "This returns an agency based on an ID."
    param :path, :id, :integer, :optional, "ID of the tag."
    response :ok, "Success"
    response :unauthorized
    response :not_acceptable, "The request you made is not acceptable"
    response :requested_range_not_satisfiable		
	end

	PAGE_SIZE=25
	DEFAULT_PAGE=1

	def index
		if params[:q]
			@official_tags = OfficialTag.where("tag_text LIKE ?","%#{params[:q]}%").page(params[:page] || DEFAULT_PAGE).per(params[:page_size] || PAGE_SIZE )
		else
			@official_tags = OfficialTag.all.page(params[:page] || DEFAULT_PAGE).per(params[:page_size] || PAGE_SIZE)
		end
		respond_to do |format|
			format.json { render "index" }
		end
	end

	def show
		@official_tag = OfficialTag.find(params[:id])
		respond_to do |format|
			format.json { render "show" }
		end
	end
end
class Api::V1::GalleriesController < Api::ApiController

	swagger_controller :galleries, "Mobile App Galleries"

	swagger_api :index do
		summary "Fetches all galleries"
    notes "This lists all active galleries.  It accepts parameters to perform basic search."
    param :query, :q, :string, :optional, "String to compare to the name of the galleries."
    param :query, :tags, :ids, :optional, "Comma seperated list of tag ids"
    param :query, :page_size, :integer, :optional, "Number of results per page"
    param :query, :page, :integer, :optional, "Page number"
    response :ok, "Success"
    response :not_acceptable, "The request you made is not acceptable"
    response :requested_range_not_satisfiable		
	end

	swagger_api :show do
		summary "Fetches a single gallery item"
		notes "This returns an gallery based on an ID."
		param :path, :id, :integer, :required, "ID of the gallery"
		response :ok, "Success" 
		response :not_acceptable, "The request you made is not available"
		response :requested_range_not_satisfiable
		response :not_found
	end

	PAGE_SIZE = 25
	DEFAULT_PAGE = 1

	def	index	
    @galleries = Gallery.joins(:official_tags)
		if params[:q]
			@galleries = @galleries.where("name LIKE ? or description LIKE ?", 
				"%#{params[:q]}%", "%#{params[:q]}%")
		end
		if params[:tags]
      @galleries = @galleries.where("official_tags.id" => params[:tags].split(","))
    end
		@galleries = @galleries.page(params[:page] || DEFAULT_PAGE).per(params[:page_size] || PAGE_SIZE)
		respond_to do |format|
			format.json { render "index" }
		end
	end

	def show
		@gallery = Gallery.includes(:gallery_items).find(params[:id])
		respond_to do |format|
			format.json { render "show" }
		end
	end
end
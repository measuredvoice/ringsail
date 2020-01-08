class DigitalRegistry::V1::GalleriesController < DigitalRegistry::ApiController

	# swagger_controller :galleries, "Mobile App Galleries"

	# swagger_api :index do
	# 	summary "Fetches all galleries"
 #    notes "This lists all active galleries.  It accepts parameters to perform basic search, as well as parameters to find galleries based on tags."
 #    param :query, :q, :string, :optional, "String to compare to the name of the galleries."
 #    param :query, :tags, :ids, :optional, "Comma separated list of tag ids"
 #    param :query, :page_size, :integer, :optional, "Number of results per page, defaults to 25"
 #    param :query, :page, :integer, :optional, "Page number"
 #    response :ok, "Success"
 #    response :not_acceptable, "The request you made is not acceptable"
 #    response :requested_range_not_satisfiable			
	# 	response :not_found
	# end

	# swagger_api :show do
	# 	summary "Fetches a single gallery item"
	# 	notes "This returns an gallery based on an ID."
	# 	param :path, :id, :integer, :required, "ID of the gallery"
	# 	response :ok, "Success" 
	# 	response :not_acceptable, "The request you made is not available"
	# 	response :requested_range_not_satisfiable
	# 	response :not_found
	# end

	PAGE_SIZE = 25
	DEFAULT_PAGE = 1

	def	index	
    params[:page_size] = params[:page_size] || PAGE_SIZE
    @galleries = Gallery.api.includes(:agencies, :official_tags)
		if params[:q] && params[:q] != ""
			@galleries = @galleries.where("name LIKE ? or short_description LIKE ? or long_description LIKE ?", 
				"%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%")
		end
		if params[:tags] && params[:tags] != ""
      @galleries = @galleries.where("official_tags.id" => params[:tags].split(","))
    end
		@galleries = @galleries.uniq.page(params[:page] || DEFAULT_PAGE).per(params[:page_size] || PAGE_SIZE)
		respond_to do |format|
			format.json { render "index" }
		end
	end

	def show
    params[:page_size] = params[:page_size] || PAGE_SIZE
		@galleries = Gallery.where(id: params[:id]).includes(
      :mobile_apps, :outlets).references(
      :mobile_apps,:outlets).page(params[:page] || DEFAULT_PAGE).per(params[:page_size] || PAGE_SIZE)
		respond_to do |format|
			format.json { render "show" }
		end
	end
end
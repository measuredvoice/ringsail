class Api::V1::TagsController < Api::ApiController

	swagger_controller :tags, "Tags"

	swagger_api :index do
    	summary "Fetches all official tags, with queryable fields such as a basic text search and."
        notes "This lists all tags.  It accepts parameters to perform basic search."
        param :query, :q, :string, :optional, "String to compare to the short name of tags."
        param :type, :type, :string, :optional, "Comma Seperated List of Tag Types"
        param :query, :page_size, :integer, :optional, "Number of results per page"
        param :query, :page, :integer, :optional, "Page number"
        response :ok, "Success"
        response :not_acceptable, "The request you made is not acceptable"
        response :requested_range_not_satisfiable   
        response :not_found
	end

    swagger_api :types do
        summary "Fetches all types for the tags, to help power other queries."
        notes "This returns a tag based on an ID."
        response :ok, "Success"
        response :not_acceptable, "The request you made is not acceptable"
        response :requested_range_not_satisfiable   
        response :not_found 
    end

	swagger_api :show do
		summary "Fetches tag based on ID"
        notes "This returns a tag based on an ID."
        param :path, :id, :integer, :optional, "ID of the tag."
        response :ok, "Success"
        response :not_acceptable, "The request you made is not acceptable"
        response :requested_range_not_satisfiable   
        response :not_found	
	end

	PAGE_SIZE=25
	DEFAULT_PAGE=1

	def index
        params[:page_size] = params[:page_size] || PAGE_SIZE
        @official_tags = OfficialTag.all
    	if params[:q] && !params[:q].blank?
    		@official_tags = @official_tags.where("tag_text LIKE ?","%#{params[:q]}%")
    	end
        if params[:type] && !params[:type].blank?
          @official_tags = @official_tags.in(tag_type: params[:type].split(","))
        end
        @official_tags = @official_tags.page(params[:page] || DEFAULT_PAGE).per(params[:page_size] || PAGE_SIZE )
		respond_to do |format|
			format.json { render "index" }
		end
	end

    def types
        @tag_type_counts = OfficialTag.group(:tag_type).count.to_a
        respond_to do |format|
          format.json { render "tag_type" }
        end
    end

    def show
        params[:page_size] = params[:page_size] || PAGE_SIZE
    	@official_tags = OfficialTag.where(id: params[:id]).page(params[:page] || DEFAULT_PAGE).per(params[:page_size] || PAGE_SIZE )
    	respond_to do |format|
    		format.json { render "show" }
    	end
    end
end
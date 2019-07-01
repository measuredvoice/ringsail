class DigitalRegistry::V1::MobileAppsController < DigitalRegistry::ApiController
	swagger_controller :mobile_apps, "Government Mobile Apps"

	swagger_api :index do
		summary "Fetches all mobile apps"
    notes "This lists all active mobile apps.  It accepts parameters to perform basic search as well as searching by tag and agency."
    param :query, :q, :string, :optional, "String to compare to the name & short description of the mobile apps."
    param :query, :agencies, :ids, :optional, "Comma separated list of agency ids"
    param :query, :tags, :ids, :optional, "Comma separated list of tag ids"
    param :query, :language, :string, :optional, "Language of the social media accounts to return"
    param :query, :page_size, :integer, :optional, "Number of results per page, defaults to 25"
    param :query, :page, :integer, :optional, "Page number"
	end

	PAGE_SIZE=25
	DEFAULT_PAGE=1

	def index
    params[:page_size] = params[:page_size] || PAGE_SIZE
		@mobile_apps = MobileApp.api.includes(:agencies, :official_tags)
    if params[:q] && params[:q] != ""
      @mobile_apps = @mobile_apps.where("mobile_apps.name LIKE ? or mobile_apps.short_description LIKE ? or mobile_apps.long_description LIKE ?", 
      	"%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%")
    end
    if params[:agencies] && params[:agencies] != ""
      @mobile_apps = @mobile_apps.where("agencies.id" =>params[:agencies].split(","))
    end
    if params[:language] && params[:language] != ""
      @mobile_apps = @mobile_apps.where("language LIKE ? ", "%#{params[:language]}%")
    end
    if params[:tags] && params[:tags] != ""
      @mobile_apps = @mobile_apps.where("official_tags.id" => params[:tags].split(","))
    end
		@mobile_apps = @mobile_apps.uniq.order(updated_at: :desc).page(params[:page] || DEFAULT_PAGE).per(params[:page_size] || PAGE_SIZE)
		respond_to do |format|
			format.json { render "index" }
		end		
	end

	swagger_api :show do
		summary "Fetches a single mobile app item"
		notes "This returns an mobile app based on an ID."
		param :path, :id, :integer, :required, "ID of the mobile app"
	end
	def show
    params[:page_size] = params[:page_size] || PAGE_SIZE
		@mobile_apps =  MobileApp.where(id: params[:id]).page(params[:page] || DEFAULT_PAGE).per(params[:page_size] || PAGE_SIZE)
		respond_to do |format|
			format.json { render "show" }
		end		
	end


  swagger_api :tokeninput do
    summary "Returns a list of tokens to help with search interfaces"
    notes "This returns tokens representing agencies, tags, and a basic text search token for the purpose of building search dialogs"
    param :query, :q, :string, :optional, "String to compare to the various values"
  end


  def tokeninput
    @query = params[:q]
    if @query
      @agencies = Agency.where("name LIKE ?","%#{@query}%")
      @tags = OfficialTag.where("tag_text LIKE ?", "%#{@query}%")
      @service_breakdown = Outlet.group(:service).count
      @items = [@query,@agencies,@tags].flatten
      render 'tokeninput'
    else
      render json: {metadata: {query: "", error:"No query provided"}}
    end

  end
end

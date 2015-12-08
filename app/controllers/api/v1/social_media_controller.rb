class Api::V1::SocialMediaController < Api::ApiController

  swagger_controller :outlets, "Social Media Accounts"

  swagger_api :index do
    summary "Fetches all accounts"
    notes "This lists all active accounts. It accepts parameters to perform basic search as well as search by service, agency, or tags."
    param :query, :q, :string, :optional, "String to compare to the name of accounts"
    param :query, :services, :service_keys, :optional, "Comma seperated list of service keys (available via services call)"
    param :query, :agencies, :ids, :optional, "Comma seperated list of agency ids"
    param :query, :language, :string, :optional, "Language of the social media accounts to return"
    param :query, :tags, :ids, :optional, "Comma seperated list of tag ids"
    param :query, :page_size, :integer, :optional, "Number of results per page"
    param :query, :page, :integer, :optional, "Page number"
    response :unauthorized
    response :not_acceptable, "The request you made is not acceptable"
    response :requested_range_not_satisfiable   
    response :not_found
  end

  PAGE_SIZE=25
  DEFAULT_PAGE=1

  def index
    params[:page_size] = params[:page_size] || PAGE_SIZE
    @outlets = Outlet.api
    if params[:q] && params[:q] != ""
      @outlets = @outlets.where("account LIKE ? OR organization LIKE ? OR short_description LIKE ? OR long_description LIKE ?", 
        "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%")
    end
    if params[:agencies] && params[:agencies] != ""
      @outlets = @outlets.where("agencies.id" =>params[:agencies].split(","))
    end
    if params[:tags] && params[:tags] != ""
      @outlets = @outlets.where("official_tags.id" => params[:tags].split(","))
    end
    if params[:language] && params[:language] != ""
      @outlets = @outlets.where("language LIKE ? ", "%#{params[:language]}%")
    end
    if params[:services] && params[:services] != ""
      @outlets = @outlets.where(service: params[:services].split(","))
    end
    @outlets = @outlets.uniq.page(params[:page] || DEFAULT_PAGE).per(params[:page_size] || PAGE_SIZE)
    respond_to do |format|
      format.json { render "index" }
    end
  end

  swagger_api :show do
    summary "Fetches a single social media account by ID"
    notes "This returns an agency based on an ID."
    param :path, :id, :integer, :required, "ID of the account"
    response :ok, "Success"
    response :not_acceptable, "The request you made is not acceptable"
    response :requested_range_not_satisfiable   
    response :not_found
  end

  def show
    params[:page_size] = params[:page_size] || PAGE_SIZE
    @outlets = Outlet.where(draft_id: params[:id]).page(params[:page] || DEFAULT_PAGE).per(params[:page_size] || PAGE_SIZE)
    respond_to do |format|
      format.json { render "show" }
    end
  end

  swagger_api :verify do
    summary "Checks against the registry for a given account by URL to verify it is a federal account"
    notes "This returns an agency based on an URL. If not found, it will return a 404"
    param :query, :url, :string, :required, "URL of social media account"
    response :ok, "Success"
    response :not_acceptable, "The request you made is not acceptable"
    response :requested_range_not_satisfiable   
    response :not_found
  end

  def verify
    @outlet = Outlet.resolves(params[:url])
    if @outlet
      respond_to do |format|
        format.json { render "verify" }
      end
    else
      respond_to do |format|
        format.json { render json: { error: "No social media account found for: #{params[:q]}"} }
      end
    end
  end

  swagger_api :services do
    summary "Get a list of all services represented in the social media account listing"
    notes "This returns a list of services along with the number of accounts registered with them"
    response :ok, "Success"
    response :not_acceptable, "The request you made is not acceptable"
    response :requested_range_not_satisfiable   
    response :not_found
  end

  def services
    ## specific breakdowns
    @services = Outlet.where("status = 1 AND draft_id IS NOT NULL").group(:service).count

    respond_to do |format|
      format.json { render "services" }
    end
  end

  swagger_api :tokeninput do
    summary "Returns a list of tokens to help with search interfaces"
    notes "This returns tokens representing services, agencies, tags, and a basic text search token for the purpose of building search dialogs"
    param :query, :q, :string, :optional, "String to compare to the various values"
    response :ok, "Success"
    response :not_acceptable, "The request you made is not acceptable"
    response :requested_range_not_satisfiable   
    response :not_found
  end

  def tokeninput
    @query = params[:q]
    if @query
      @agencies = Agency.where("name LIKE ?","%#{@query}%")
      @services = Service.search_by_name(@query)
      @tags = OfficialTag.where("tag_text LIKE ?", "%#{@query}%")
      @service_breakdown = Outlet.where("draft_id IS NULL").group(:service).count
      @items = [@query,@agencies,@services,@tags].flatten
      render 'tokeninput'
    else
      render json: {metadata: {query: "", error:"No query provided"}}
    end

  end
end

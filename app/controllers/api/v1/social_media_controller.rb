class Api::V1::SocialMediaController < Api::ApiController

  swagger_controller :outlets, "Social Media Accounts"

  swagger_api :index do
    summary "Fetches all accounts"
    notes "This lists all active accounts. It accepts parameters to perform basic search."
    param :query, :q, :string, :optional, "String to compare to the name of accounts"
    param :query, :services, :service_keys, :optional, "Comma seperated list of service keys (available via services call)"
    param :query, :agencies, :ids, :optional, "Comma seperated list of agency ids"
    param :query, :tags, :ids, :optional, "Comma seperated list of tag ids"
    param :query, :page_size, :integer, :optional, "Number of results per page"
    param :query, :page, :integer, :optional, "Page number"
    response :unauthorized
    response :not_acceptable, "The request you made is not acceptable"
    response :requested_range_not_satisfiable 
  end

  PAGE_SIZE=25
  DEFAULT_PAGE=1

  def index
    @outlets = Outlet.joins(:agencies, :official_tags)
    if params[:q]
      @outlets = @outlets.where("account LIKE ? OR organization LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%")
    end
    if params[:agencies]
      @outlets = @outlets.where("agencies.id" =>params[:agencies].split(","))
    end
    if params[:tags]
      @outlets = @outlets.where("official_tags.id" => params[:tags].split(","))
    end
    if params[:services]
      @outlets = @outlets.where(service: params[:services].split(","))
    end
    @outlets = @outlets.page(params[:page] || DEFAULT_PAGE).per(params[:page_size] || PAGE_SIZE)
    respond_to do |format|
      format.json { render "index" }
    end
  end

  swagger_api :show do
    summary "Fetches a single account item"
    notes "This returns an agency based on an ID."
    param :path, :id, :integer, :required, "ID of the account"
    response :ok, "Success"
    response :not_acceptable, "The request you made is not acceptable"
    response :requested_range_not_satisfiable   
    response :not_found
  end

  def show
    @outlet = Outlet.find(params[:id])
    respond_to do |format|
      format.json { render "show" }
    end
  end

  swagger_api :verify do
    summary "Checks against the registry for a given account by URL"
    notes "This returns an agency based on an URL. If not found, it will return a 404"
    param :query, :url, :string, :required, "URL of social media account"
    response :ok, "Success"
    response :not_acceptable, "The request you made is not acceptable"
    response :requested_range_not_satisfiable   
    response :not_found
  end

  def verify
    @outlet = Outlet.resolve(params[:url])
    respond_to do |format|
      format.json { render "show" }
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
    @services = Outlet.where("status <> 2").group(:service).count

    respond_to do |format|
      format.json { render "services" }
    end
  end
end

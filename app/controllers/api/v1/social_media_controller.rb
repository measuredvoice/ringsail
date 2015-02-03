class Api::V1::SocialMediaController < Api::ApiController

  swagger_controller :outlets, "Social Media Accounts"

  swagger_api :index do
    summary "Fetches all accounts"
    notes "This lists all active accounts. It accepts parameters to perform basic search."
    param :query, :q, :string, :optional, "String to compare to the name of accounts"
    param :query, :agencies, :Ids, :optional, "Comma seperated list of agency ids"
    param :query, :tags, :Ids, :optional, "Comma seperated list of tag ids"
    param :query, :page_size, :integer, :optional, "Number of results per page"
    param :query, :page, :integer, :optional, "Page number"
    response :unauthorized
    response :not_acceptable, "The request you made is not acceptable"
    response :requested_range_not_satisfiable 
  end

  PAGE_SIZE=25
  DEFAULT_PAGE=1

  def index
    @outlets = Outlet.all
    if params[:q]
      @outlets = Outlet.where("account LIKE ? OR organization LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%")
    end
    if params[:agencies]
      @outlets.where(agencies: params[:agencies].split(","))
    end
    if params[:tags]
      @outlets.where(official_tags: params[:tags].split(","))
    end
    @outlets.page(params[:page] || DEFAULT_PAGE).per(params[:page_size] || PAGE_SIZE)
    respond_to do |format|
      format.json { render "index" }
    end
  end

  swagger_api :show do
    summary "Fetches a single account item"
    notes "This returns an agency based on an ID."
    param :path, :id, :integer, :required, "ID of the account"
    response :ok, "Success" 
    response :unauthorized
    response :not_acceptable, "The request you made is not acceptable"
    response :requested_range_not_satisfiable 
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
    response :unauthorized
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
end

class Api::V1::OutletsController < Api::ApiController

  swagger_controller :outlets, "Accounts"

  swagger_api :index do
    summary "Fetches all accounts"
    notes "This lists all active accounts. It accepts parameters to perform basic search."
    param :query, :q, :string, :optional, "String to compare to the name of accounts"
    param :query, :page_size, :integer, :optional, "Number of results per page"
    param :query, :page, :integer, :optional, "Page number"
    response :unauthorized
    response :not_acceptable, "The request you made is not acceptable"
    response :requested_range_not_satisfiable 
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

  PAGE_SIZE=25
  DEFAULT_PAGE=1

  def index
    if params[:id]
      @outlets = Outlet.where("account like ?", "%#{params[:q]}%", "%#{params[:q]}%").page(params[:page] || DEFAULT_PAGE).per(params[:page_size] || PAGE_SIZE)
    else
      @outlets = Outlet.all.page(params[:page] || DEFAULT_PAGE).per(params[:page_size] || PAGE_SIZE)
    end
      respond_to do |format|
        format.json { render "index" }
      end
  end

  def show
    @outlet = Outlet.find(params[:id])
     respond_to do |format|
      format.json { render "show" }
    end
  end
end

class Admin::ReviewSocialMediaController < Admin::AdminController
  helper_method :sort_column, :sort_direction, :current_page
  respond_to :html, :xml, :json, :csv, :xls

  before_action :set_outlet, only: [:show, :edit, :update, :destroy,
    :publish, :archive, :request_publish, :request_archive]

  # before_filter :require_admin, only: [:publish]
  # GET /outlets
  # GET /outlets.json
  def index
    if params[:status] == "archived"
      @outlets = Outlet.joins(:users).where("users.email" =>current_user.email, "outlets.draft_id" => nil, "outlets.status" => 2).order("updated_at ASC").page(current_page).per(10)
    elsif params[:status] == "recently_published"
      @outlets = Outlet.joins(:users).where("users.email" =>current_user.email, "outlets.draft_id" => nil, "outlets.status" => 1).where("outlets.updated_at > ?",90.days.ago).order("updated_at ASC").page(current_page).per(10)
    else
      @outlets = Outlet.joins(:users).where("users.email" =>current_user.email, "outlets.draft_id" => nil, "outlets.status" => 1).where("outlets.updated_at <= ?",90.days.ago).order("updated_at ASC").page(current_page).per(10)
    end
    
  end

  

  private
    

  def current_page
    if params[:page]
      return params[:page].to_i
    else
      return 1
    end
  end
end
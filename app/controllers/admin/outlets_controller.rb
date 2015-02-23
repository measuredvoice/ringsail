class Admin::OutletsController < Admin::AdminController
  helper_method :sort_column, :sort_direction
  respond_to :html, :xml, :json, :csv, :xls

  before_action :set_outlet, only: [:show, :edit, :update, :destroy, :history, :restore, :publish, :archive]

  before_filter :require_admin, only: [:publish]
  # GET /outlets
  # GET /outlets.json
  def index
    if current_user.admin?
      @outlets = Outlet.includes(:official_tags, :agencies).where("draft_id IS NULL").uniq
      @services = Outlet.all.group(:service).count
    else
      @outlets = Outlet.joins(:official_tags, :agencies).where("agencies.id = ? AND draft_id IS NULL", current_user.agency.id).uniq
      @services = @outlets.group(:service).count
    end

    @total_outlets = @outlets.count
    if(params[:service])
      @outlets = @outlets.where(service: params[:service]).order(sort_column + " " + sort_direction)
    else
      @outlets = @outlets.all.order(sort_column + " " + sort_direction)
    end
    respond_to do |format|
      format.html { @outlets = @outlets.page(params[:page]).per(20) }
      format.json { render json: @outlets }
      format.xml { render xml: @outlets }
      format.csv { send_data @outlets.to_csv }
      format.xls { send_data @outlets.to_csv(col_sep: "\t")}
    end
  end


  def datatables
    @outlets = Outlet.where("draft_id IS NULL").uniq
    respond_to do |format|
      format.json {
        render json: {
          data: @outlets
        }
      }
    end
  end

  def account_for_url
    service = Service.find_by_url(params[:url])
    account = { account: "", service: ""}
    if service
      account = { account: service.account,
        service: service.shortname }
    end
    render json: account
  end
  # GET /outlets/1
  # GET /outlets/1.json

  # GET /outlets/new
  def new
    @outlet = Outlet.new
    @outlet.agencies << current_user.agency
    @outlet.users << current_user
  end

  # GET /outlets/1/edit
  def edit
  end

  def show
  end
  

  # POST /outlets
  # POST /outlets.json
  def create
    @outlet = Outlet.new(outlet_params)
    @outlet.status = Outlet.statuses[:under_review]
    respond_to do |format|
      if @outlet.save
        format.html { redirect_to admin_outlet_path(@outlet), notice: 'Outlet was successfully created.' }
        format.json { render :show, status: :created, location: @outlet }
      else
        format.html { render :new }
        format.json { render json: @outlet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /outlets/1
  # PATCH/PUT /outlets/1.json
  def update
    @outlet.status = Outlet.statuses[:under_review]
    respond_to do |format|
      if @outlet.update(outlet_params)
        format.html { redirect_to admin_outlet_path(@outlet), notice: 'Outlet was successfully updated.' }
        format.json { render :show, status: :ok, location: admin_outlet_path(@outlet) }
      else
        format.html { render :edit }
        format.json { render json: @outlet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /outlets/1
  # DELETE /outlets/1.json
  def destroy
    @outlet.destroy!
    respond_to do |format|
      format.html { redirect_to admin_outlets_url, notice: 'Outlet was successfully destroyed.' }
      format.json { head :no_content }
    end
    redirect_to action: :index
  end

  def activities
    @activities = PublicActivity::Activity.where(trackable_type: "Outlet").order("created_at desc").page(params[:page]).per(25)
  end
  
  def history
    @versions = @outlet.versions
  end

  def restore
    @outlet.versions.find(params[:version_id]).reify(:has_many => true).save!  
    redirect_to admin_outlet_path(@outlet), :notice => "Changes were reverted."
  end

  def publish
    @outlet.published!
    redirect_to admin_outlet_path(@outlet), :notice => "Social Media Account: #{@outlet.organization}, is now public."
  end

  def archive
    @outlet.archived!
    redirect_to admin_outlet_path(@outlet), :notice => "Social Media Account: #{@outlet.organization}, is now archived"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_outlet
      @outlet = Outlet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def outlet_params
      params.require(:outlet).permit(:organization, :service_url, :location, :location_id, :status, :account, :service, :language, :agency_tokens, :user_tokens,:tag_tokens)
    end

    def sort_column
      Outlet.column_names.include?(params[:sort]) ? params[:sort] : "account"
    end
  
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end

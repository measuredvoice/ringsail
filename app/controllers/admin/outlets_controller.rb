class Admin::OutletsController < Admin::AdminController
  respond_to :html, :xml, :json, :csv, :xls

  before_action :set_outlet, only: [:show, :edit, :update, :destroy, :history, :restore, :publish, :archive]
  # GET /outlets
  # GET /outlets.json
  def index
    @services = Outlet.all.group(:service).count
    if(params[:service])
      @outlets = Outlet.where(service: params[:service]).includes(:tags, :agencies).page(params[:page]).per(20)
    else
      @outlets = Outlet.all.includes(:tags, :agencies).page(params[:page]).per(20)
    end
    @allOutlets = Outlet.all
    respond_to do |format|
      format.html
      format.json { render json: @allOutlets }
      format.xml { render xml: @allOutlets }
      format.csv { send_data @allOutlets.to_csv }
      format.xls { send_data @allOutlets.to_csv(col_sep: "\t")}
    end
  end

  # GET /outlets/1
  # GET /outlets/1.json

  # GET /outlets/new
  def new
    @outlet = Outlet.new
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
    @outlet.archived!
    @outlet.save!
    respond_to do |format|
      format.html { redirect_to outlets_url, notice: 'Outlet was successfully destroyed.' }
      format.json { head :no_content }
    end
    redirect_to action: :index
  end

  def activities
    @activities = PublicActivity::Activity.where(trackable_type: "Outlet").order("created_at desc").page(params[:page]).per(25)
  end
  
  def history
    @versions = @outlet.versions.order("created_at desc")
  end

  def restore
    @outlet.versions.find(params[:version_id]).reify(:has_one=> true, :has_many => true).save!  
    redirect_to admin_outlet_path(@outlet), :notice => "Changes were reverted."
  end

  def publish
    Outlet.public_activity_off
    @outlet.status = Outlet.statuses[:published]
    @outlet.save
    Outlet.public_activity_on
    @outlet.create_activity :published
    redirect_to admin_outlet_path(@outlet), :notice => "Social Media Account is now public"
  end

  def archive
    Outlet.public_activity_off
    @outlet.status = Outlet.statuses[:archived]
    @outlet.save
    Outlet.public_activity_on
    @outlet.create_activity :archived
    redirect_to admin_outlet_path(@outlet), :notice => "Social Media Account is now archived"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_outlet
      @outlet = Outlet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def outlet_params
      params.require(:outlet).permit(:organization, :service_url, :location, :location_id, :status, :account, :service, :tag_tokens, :language, :info_url, :agency_tokens, :user_tokens)
    end


end

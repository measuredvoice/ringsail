class Admin::MobileAppsController < Admin::AdminController
  respond_to :html, :xml, :json, :csv, :xls

  before_action :set_mobile_app, only: [:show, :edit, :update, :destroy, :history,:restore]
  # GET /mobile_apps
  # GET /mobile_apps.json
  def index
    @mobile_apps = MobileApp.page(params[:page]).per(15)
    @apps = MobileApp.all
    respond_to do |format|
      format.html
      format.json {render json: @apps }
      format.xml {render xml: @apps}
      format.csv {send_data @apps.to_csv}
      format.xls { send_data @apps.csv(col_sep: "\t")}
    end
  end

  # GET /mobile_apps/1
  # GET /mobile_apps/1.json
 # def show
  #end

  # GET /mobile_apps/new
  def new
    @mobile_app = MobileApp.new
    @mobile_app.mobile_app_versions.build
  end

  # GET /mobile_apps/1/edit
  def edit
    if @mobile_app.mobile_app_versions.count == 0
      @mobile_app.mobile_app_versions.build
    end
  end

  def show
    
  end

  # POST /mobile_apps
  # POST /mobile_apps.json
  def create
    @mobile_app = MobileApp.new(mobile_app_params)

    respond_to do |format|
      if @mobile_app.save
        format.html { redirect_to admin_mobile_app_path(@mobile_app), notice: 'MobileApp was successfully created.' }
        format.json { render :show, status: :created, location: @mobile_app }
      else
        format.html { render :new }
        format.json { render json: @mobile_app.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mobile_apps/1
  # PATCH/PUT /mobile_apps/1.json
  def update
    respond_to do |format|
      if @mobile_app.update(mobile_app_params)
        format.html { redirect_to admin_mobile_app_path(@mobile_app), notice: 'MobileApp was successfully updated.' }
        format.json { render :show, status: :ok, location: admin_mobile_app_path(@mobile_app) }
      else
        format.html { render :edit }
        format.json { render json: @mobile_app.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mobile_apps/1
  # DELETE /mobile_apps/1.json
  def destroy
    @mobile_app.archived!
    @mobile_app.save!
    respond_to do |format|
      format.html { redirect_to admin_mobile_apps_url, notice: 'MobileApp was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def activities
    @activities = PublicActivity::Activity.where(trackable_type: "MobileApp").order("created_at desc").page(params[:page]).per(25)
  end
  def history
    @versions = @mobile_app.versions.order("created_at desc")
  end

  def restore
    @mobile_app.versions.find(params[:version_id]).reify.save!
    redirect_to admin_mobile_app_path(@mobile_app), :notice => "Undid changes to mobile app."
  end

  

   private
    # Use callbacks to share common setup or constraints between actions.
    def set_mobile_app
      @mobile_app = MobileApp.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mobile_app_params
      params.require(:mobile_app).permit(:name, :short_description, :long_description, :icon_url, 
        :language, agency_ids: [], user_ids: [], mobile_app_versions_attributes: [:id, :store_url,:platform,
        :version_number,:publish_date,:description,:whats_new,:screenshot,:device,
        :language,:average_rating,:number_of_ratings, :_destroy])
    end


end

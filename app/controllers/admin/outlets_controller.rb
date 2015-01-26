class Admin::OutletsController < Admin::AdminController
  respond_to :html, :xml, :json, :csv, :xls

  before_action :set_outlet, only: [:show, :edit, :update, :destroy, :history,:restore]
  # GET /outlets
  # GET /outlets.json
  def index
    @services = Service.all
    if(params[:service])
      @outlets = Outlet.where(service: params[:service]).includes(:tags).page(params[:page]).per(15)
    else
      @outlets = Outlet.all.includes(:tags).page(params[:page]).per(15)
    end
    @outs = Outlet.all
    respond_to do |format|
      format.html
      format.json { render json: @outlets }
      format.xml { render xml: @outlets }
      format.csv { send_data @outlets.to_csv }
      format.xls { send_data @outlets.to_csv(col_sep: "\t")}
    end
  end

  # GET /outlets/1
  # GET /outlets/1.json
 # def show
  #end

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
    @outlet.destroy
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
    @outlet.versions.find(params[:version_id]).reify.save!
    redirect_to admin_outlet_path(@outlet), :notice => "Undid changes to outlet."
  end

  

   private
    # Use callbacks to share common setup or constraints between actions.
    def set_outlet
      @outlet = Outlet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def outlet_params
      params.require(:outlet).permit(:organization, :service_url, :location, :location_id, :status, :account, :tag_list, :language, :info_url)
    end


end

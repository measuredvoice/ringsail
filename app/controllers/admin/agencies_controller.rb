class Admin::AgenciesController < Admin::AdminController
  respond_to :html, :xml, :json, :csv, :xls
  before_action :set_agency, only: [:show, :edit, :update, :destroy, :history, :restore]

  def index 
    @agencies = Agency.all.order(name: :asc).page(params[:page]).per(15)
    @allagencies = Agency.all.order(name: :asc)
    respond_to do |format|
      format.html
      format.json { render json: @allagencies }
      format.xml { render xml: @allagencies }
      format.csv { send_data @allagencies.to_csv }
      format.xls { send_data @allagencies.to_csv(col_sep: "\t")}
    end
  end

  def new
  	@agency = Agency.new
  end

  def show
  end

  def edit

  end

  def create
  	@agency = Agency.new(agency_params)
  	respond_to do |format|
      if @agency.save
        format.html { redirect_to admin_agency_path(@agency), notice: 'Agency was successfully created.' }
        format.json { render :show, status: :created, location: @agency }
      else
        format.html { render :new }
        format.json { render json: @agency.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @agency.update(agency_params)
        format.html {redirect_to admin_agency_path(@agency), notice: 'Agency was successfully updated.'}
        format.json  {render :show, status: :ok, location: admin_agency_path(@agency)}
      else
        format.html {render :edit }
        format.json {render json: @agency.errors, status: :unprocessable_entity }
      end
    end
  end

  def activities
    @activities = PublicActivity::Activity.where(trackable_type: "Agency").order("created_at desc").page(params[:page]).per(25)
  end

  def history
    @versions = @agency.versions.order("created_at desc")
  end

  def restore

    @agency.versions.find(params[:version_id]).reify.save!
    redirect_to admin_agency_path(@agency), :notice => "Changes were reverted."
  end

  private
    def set_agency
      @agency = Agency.find(params[:id])
    end
    def agency_params
      params.require(:agency).permit(:name, :shortname, :info_url, :agency_contact_ids)
    end
end

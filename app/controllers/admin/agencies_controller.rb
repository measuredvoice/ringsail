class Admin::AgenciesController < Admin::AdminController
  respond_to :html, :xml, :json
  before_action :set_agency, only: [:show, :edit, :history,]

  def index 
    @agencies = Agency.all.order(name: :asc).page(params[:page]).per(15)
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

  def activities
    @activities = PublicActivity::Activity.where(trackable_type: "Agency").order("created_at desc").page(params[:page]).per(25)
  end
  def history
    @versions = @agency.versions.order("created_at desc")
  end

  private
    def set_agency
      @agency = Agency.find(params[:id])
    end
    def agency_params
      params.require(:agency).permit(:name, :shortname, :info_url, :agency_contact_ids)
    end
end

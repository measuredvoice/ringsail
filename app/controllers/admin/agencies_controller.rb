class Admin::AgenciesController < Admin::AdminController
  helper_method :sort_column, :sort_direction
  respond_to :html, :xml, :json, :csv, :xls
  before_action :set_agency, only: [:show, :edit, :update, :destroy, :history, :restore]
  protect_from_forgery except: :tokeninput
 
  before_filter :require_admin, except: [:tokeninput]

  def index 
    @agencies = Agency.all.order(sort_column + " " + sort_direction) 
    respond_to do |format|
      format.html { @agencies }
      format.json { render json: @agencies }
      format.xml { render xml: @agencies }
      format.csv { send_data @agencies.to_csv }
      format.xls { send_data @agencies.to_csv(col_sep: "\t")}
    end
  end

  def new
  	@agency = Agency.new
  end

  def show
    if @agency
      @agency = Agency.where(:id=> @agency.id).includes(:outlets,:mobile_apps,:galleries).first
    end
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

  def destroy
    @agency.destroy!
    respond_to do |format|
      format.html { redirect_to admin_agencies_url, notice: "Agency was successfully destroyed."}
      format.json { head :no_content }
    end
  end

  def tokeninput
    @agencies = Agency.where("name LIKE ? OR shortname LIKE ?", "%#{params[:q]}%","%#{params[:q]}%").select([:id,:name])
    respond_to do |format|
      format.json { render 'tokeninput'}
    end
  end

  private
    def set_agency
      @agency = Agency.find(params[:id])
    end
    def agency_params
      params.require(:agency).permit(:name, :shortname, :info_url, :agency_tokens, :parent_id)
    end

    def sort_column
      Agency.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end
  
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end 
end

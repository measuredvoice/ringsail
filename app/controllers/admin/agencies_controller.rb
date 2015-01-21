class Admin::AgenciesController < Admin::AdminController
  def index
  	@agencies = Agency.all
  end

  def new
  	@agency = Agency.new
  end

  def create
  	@oagency = Agency.new(agency_params)
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
end

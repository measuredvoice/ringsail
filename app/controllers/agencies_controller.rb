class AgenciesController < ApplicationController
  respond_to :html, :xml, :json
  #before_action :set_agency, except: [:list]
  before_action :set_agency, only: [:show, :edit, :update, :destroy]
  def index
    @agencies = Agency.all 
      respond_to do |format| 
        format.html 
        format.json { render json: @agencies } 
      end
  end

  def list
    @agencies = Agency.order('name').page(params[:page_number])
    respond_with(XBoxer.new(:result, Boxer.ship(:agencies, @agencies) ))   
  end

  def autocomplete
  
    @agency_list = Agency.where("name LIKE ?","%#{params[:term]}%").pluck(:name)
    respond_to do |format|
      format.json { respond_with @agency_list }
    end
  end

  # def show
  # end

  private
  	def set_agency
    	@agency = Agency.find(params[:id])
    end
    
  	def agency_params
   		params.require(:agency).permit(:name, :shortname, :info_url, :agency_contact_ids)
    end



end

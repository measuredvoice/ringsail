class OutletsController < ApplicationController
  respond_to :html, :xml, :json
  
  def add
    @outlet = Outlet.resolve(params[:service_url]) if params[:service_url]
    @agencies = Agency.all
    if @outlet
      @selected_agencies = @outlet.agencies.map {|agency| agency.shortname}
    else
      @selected_agencies = []
    end
  end
  
  def update
    @outlet = Outlet.resolve(params[:service_url])
    
    unless @outlet
      render 'add' and return
    end
    
    # Update the object with any non-empty values provided
    # new_params = params.reject do |key, value| 
    #   value.nil? || 
    #   value.empty? || 
    #   key == :service_url
    # end
    
    # FIXME: Doing this the stupid, straightforward way to start
    @outlet.organization = params[:organization] unless params[:organization].empty?
    @outlet.info_url = params[:info_url] unless params[:info_url].empty?
    @outlet.language = params[:language] unless params[:language].empty?
    
    # If any agencies are specified, update the list of agencies to match
    if params[:agency_id]
      @outlet.agencies = params[:agency_id].map {|s| Agency.find_by_shortname(s)}
    end
    
    if @outlet.save
      flash[:success] = "Outlet updated."
      redirect_to "/outlets/#{@outlet.service.shortname}/#{@outlet.account}"
    else
      @agencies = Agency.all
      @selected_agencies = [];
      render 'add'
    end
  end
  
  def verify
    @outlet = Outlet.resolve(params[:service_url])
    
    unless request.format == :html
      # FIXME: Needs a better way to specify XML settings
      respond_with(XBoxer.new(:outlet, Boxer.ship(:outlet, @outlet)))
    end
  end

  def show
    service = Service.find_by_shortname(params[:service])
    @outlet = Outlet.find_by_service_id_and_account(service.id, params[:account])
    
    if request.format == :html
      render 'verify'
    else
      respond_with(XBoxer.new(:outlet, Boxer.ship(:outlet, @outlet)))
    end
  end

  def destroy
    service = Service.find_by_shortname(params[:service])
    Outlet.find_by_service_id_and_account(service.id, params[:account]).destroy
    
    if request.format == :html
      redirect_to add_path
    else
      respond_with(XBoxer.new(:result, {:status => "success"}))
    end
  end

  def remove
    Outlet.resolve(params[:service_url]).destroy
    
    if request.format == :html
      redirect_to add_path
    else
      respond_with(XBoxer.new(:result, {:status => "success"}))
    end
  end
end

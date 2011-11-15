class OutletsController < ApplicationController
  respond_to :html, :xml, :json
  
  def add
    @outlet = Outlet.resolve(params[:service_url])
    
    if @outlet
      @agencies = Agency.all
      @selected_agencies = @outlet.agencies.map {|agency| agency.shortname}
      
      respond_with(XBoxer.new(:outlet, Boxer.ship(:outlet, @outlet, 
        :view => @outlet.verified? ? :verified : :base )))
    else
      respond_with(XBoxer.new(:result, {
        :status => "incomplete",
        :needs  => "service_url",
      }))
    end
  end
  
  def update
    @outlet = Outlet.resolve(params[:service_url])
    
    unless @outlet
      respond_to do |format|
        format.html {render 'add'}
        format.any(:xml, :json) do
          render request.format.to_sym => XBoxer.new(:result, {
            :status => "incomplete",
            :needs  => "service_url",
          })
        end
      end
      return
    end
    
    # Update the object with any non-empty values provided
    # new_params = params.reject do |key, value| 
    #   value.nil? || 
    #   value.empty? || 
    #   key == :service_url
    # end
    
    # FIXME: Doing this the stupid, straightforward way to start
    @outlet.organization = params[:organization] unless params[:organization].nil? or params[:organization].empty?
    @outlet.info_url = params[:info_url] unless params[:info_url].nil? or params[:info_url].empty?
    @outlet.language = params[:language] unless params[:language].nil? or params[:language].empty?
    
    # If any agencies are specified, update the list of agencies to match
    if params[:agency_id]
      @outlet.agencies = params[:agency_id].map {|s| Agency.find_by_shortname(s)}
    end
    
    if @outlet.save
      if request.format == :html
        flash[:success] = "Outlet updated."
        redirect_to "/outlets/#{@outlet.service.shortname}/#{@outlet.account}"
      else
        respond_with(XBoxer.new(:result, {:status => "success"}))
      end
    else
      if request.format == :html
        @agencies = Agency.all
        @selected_agencies = [];
        render 'add'
      else
        respond_with(XBoxer.new(:result, {:status => "error"}))
      end
    end
  end
  
  def verify
    @outlet = Outlet.resolve(params[:service_url])
    
    if @outlet
      @agencies = Agency.all
      @selected_agencies = @outlet.agencies.map {|agency| agency.shortname}
      
      respond_with(XBoxer.new(:outlet, Boxer.ship(:outlet, @outlet, 
        :view => @outlet.verified? ? :verified : :base )))
    else
      respond_with(XBoxer.new(:result, {
        :status => "incomplete",
        :needs  => "service_url",
      }))
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

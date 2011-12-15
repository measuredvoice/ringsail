class OutletsController < ApplicationController
  respond_to :html, :xml, :json
  before_filter :check_auth, :except => [:verify, :show]
  
  def add
    @outlet = Outlet.resolve(params[:service_url])
    
    if @outlet
      @page_title = "Add Information for " + @outlet.service_info.display_name
      @agencies = agencies_for_form
      @selected_agencies = @outlet.agencies.map {|agency| agency.shortname}
      
      respond_with(XBoxer.new(:outlet, Boxer.ship(:outlet, @outlet, :view => :full )))
    else
      @page_title = "Add an outlet"
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
    if !params[:language].nil?
      @outlet.language = params[:language].gsub(/,/, '')
    end
    @outlet.tag_list = params[:tags]
    @outlet.location_id = params[:location_id] unless params[:location_id].nil? or params[:location_id].empty?
    @outlet.auth_token = @current_token.token
    
    # If any agencies are specified, update the list of agencies to match
    if params[:agency_id]
      @outlet.agencies = params[:agency_id].map {|s| Agency.find_by_shortname(s)}
    elsif @outlet.agencies.empty?
      @outlet.errors.add(:agencies, "must include an agency to be verified")
      @agencies = agencies_for_form
      @selected_agencies = [];
      @page_title = "Add Information for " + @outlet.service_info.display_name
      render 'add' and return
    end
    
    if @outlet.save
      if request.format == :html
        flash[:success] = "Outlet updated."
        redirect_to "/outlets/#{@outlet.service}/#{@outlet.account}"
      else
        respond_with(XBoxer.new(:result, {:status => "success"}))
      end
    else
      if request.format == :html
        @agencies = agencies_for_form
        @selected_agencies = [];
        @page_title = "Add Information for " + @outlet.service_info.display_name
        render 'add'
      else
        respond_with(XBoxer.new(:result, {:status => "error"}))
      end
    end
  end
  
  def verify
    @outlet = Outlet.resolve(params[:service_url])
    
    if @outlet
      @page_title = "Verify " + @outlet.service_info.display_name
      @agencies = agencies_for_form
      @selected_agencies = @outlet.agencies.map {|agency| agency.shortname}
      
      respond_with(XBoxer.new(:outlet, Boxer.ship(:outlet, @outlet, :view => :full )))
    else
      @page_title = "Verify an outlet"
      respond_with(XBoxer.new(:result, {
        :status => "incomplete",
        :needs  => "service_url",
      }))
    end
  end

  def show
    @outlet = Outlet.find_by_service_and_account(params[:service], params[:account])
    
    if @outlet
      @page_title = @outlet.service_info.display_name
    else
      @page_title = "Verify an outlet"
    end
    
    if request.format == :html
      render 'verify'
    else
      respond_with(XBoxer.new(:outlet, Boxer.ship(:outlet, @outlet, :view => :full)))
    end
  end

  def destroy
    Outlet.find_by_service_and_account(params[:service], params[:account]).destroy
    
    if request.format == :html
      redirect_to add_path
    else
      respond_with(XBoxer.new(:result, {:status => "success"}))
    end
  end

  def remove
    Outlet.resolve(params[:service_url]).destroy
    
    if request.format == :html
      redirect_to verify_path(:service_url => params[:service_url])
    else
      respond_with(XBoxer.new(:result, {:status => "success"}))
    end
  end
  
  private
  
  def agencies_for_form
    Agency.all(:order => "name")
  end
end

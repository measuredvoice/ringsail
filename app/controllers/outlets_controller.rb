class OutletsController < ApplicationController
  respond_to :html, :xml, :json
  before_filter :check_auth, :except => [:verify, :show, :list]
  
  def add
    @outlet = Outlet.resolve(params[:service_url])
    
    if @outlet and @outlet.account
      @page_title = "Add Information for " + @outlet.service_info.display_name
      @agencies = agencies_for_form
      @selected_agencies = @outlet.agencies.map {|agency| agency.shortname}
      
      respond_with(XBoxer.new(:account, Boxer.ship(:outlet, @outlet, :view => :full )))
    else
      @page_title = "Register an account"
      
      # Add a message about proper URLs for this service if 
      if @outlet and @outlet.service_info
        proper_url = @outlet.service_info.service_url_example
        help_msg = proper_url ? " Accounts on that service usually look like #{proper_url} instead." : ""
        flash.now[:alert] = params[:service_url] + " doesn't seem to be a social media account." + help_msg
        @outlet = nil
      elsif params[:service_url]
        flash.now[:alert] = "The registry doesn't recognize that URL as a supported social media service."
      end
      
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
        flash[:shortnotice] = "Thank you!"
        flash[:notice] = "The entry for #{ @outlet.service_info.display_name} has been updated."
        redirect_to :action => "verify", :service_url => @outlet.service_url, :auth_token => @current_token.token
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
    if params[:service] and params[:account]
      @outlet = Outlet.find_by_service_and_account(params[:service], params[:account])
    else
      @outlet = Outlet.resolve(params[:service_url])
    end
    
    if @outlet and @outlet.account
      @page_title ||= "Verify " + @outlet.service_info.display_name
      @agencies = agencies_for_form
      @selected_agencies = @outlet.agencies.map {|agency| agency.shortname}
      
      respond_with(XBoxer.new(:outlet, Boxer.ship(:outlet, @outlet, :view => :full )))
    else
      # Add a message about proper URLs for this service if 
      if @outlet and @outlet.service_info
        proper_url = @outlet.service_info.service_url_example
        help_msg = proper_url ? " Perhaps try something like #{proper_url} instead." : ""
        flash.now[:alert] = params[:service_url] + " doesn't seem to be a social media account." + help_msg
        @outlet = nil
      elsif params[:service_url]
        flash.now[:alert] = "The registry doesn't recognize that URL as a supported social media service."
      end
      
      @services = Service.all;

      @page_title ||= "Verify an account"
      respond_with(XBoxer.new(:result, {
        :status => "incomplete",
        :needs  => "service_url",
      }))
    end
  end

  def remove
    if params[:service] and params[:account]
      @outlet = Outlet.find_by_service_and_account(params[:service], params[:account])
    else
      @outlet = Outlet.resolve(params[:service_url])
    end

    outlet_name = @outlet.service_info.display_name
    service_url = @outlet.service_url
    @outlet.destroy
    
    if request.format == :html
      flash[:shortnotice] = "Thank you!"
      flash[:notice] = "The entry for #{outlet_name} has been removed from the registry."
      redirect_to :action => "verify", :service_url => service_url, :auth_token => @current_token.token
    else
      respond_with(XBoxer.new(:result, {:status => "success"}))
    end
  end
  
  def list
    @page_title = "Accounts"
    # @keywords = params[:q] || params[:keywords]
    
    @outlets = Outlet.includes(:agencies).order('account, service')

    if params[:service_id] and !params[:service_id].empty?
      @outlets = @outlets.where(:service => params[:service_id])
    end
    if params[:agency_id] and !params[:agency_id].empty?
      @outlets = @outlets.joins(:agencies).where(:agencies => {:shortname => params[:agency_id]})
    end
    if params[:tag] and !params[:tag].empty?
      @outlets = @outlets.tagged_with(params[:tag])
    end
    
    @outlets = @outlets.page(params[:page_number])
    
    respond_with(XBoxer.new(:result, Boxer.ship(:outlets, @outlets) ))
  end

  private
  
  def agencies_for_form
    Agency.all(:order => "name")
  end
end

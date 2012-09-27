class OutletsController < ApplicationController
  respond_to :html, :xml, :json
  respond_to :atom, :only => :list
  before_filter :check_auth, :except => [:verify, :show, :list]
  
  def default_url_options
    {:host => ENV['RINGSAIL_API_HOST']}
  end
  
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
        help_msg = proper_url ? " Accounts URLs on that service usually look like #{proper_url}." : ""
        flash.now[:alert] = params[:service_url] + " appears to be an incomplete URL." + help_msg
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
    
    # If the account was already verified, it will be updated
    action_performed = @outlet.verified? ? 'updated' : 'added to the social media registry';
    
    @outlet.organization = params[:organization] if params[:organization]
    @outlet.info_url = params[:info_url] if params[:info_url]
    if params[:language]
      @outlet.language = params[:language].gsub(/,/, '')
    end
    @outlet.tag_list = params[:tags]
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
      somebody_was_notified = ''
      if action_performed != 'updated' && !@outlet.contact_emails.empty?
        somebody_was_notified = "We have notified the following " + 
        (@outlet.contact_emails.count == 1 ? "point" : "points") + 
        " of contact at the " +
        (@outlet.agencies.count == 1 ? "agency" : "agencies") +
        " affiliated with the account: " + 
        @outlet.contact_emails.join(", ")
        AgencyNotificationMailer.new_outlet_email(@outlet).deliver
      end
      
      if request.format == :html
        flash[:shortnotice] = "Thank you!"
        flash[:notice] = "The entry for #{ @outlet.service_info.display_name} has been #{action_performed}. #{somebody_was_notified}" 
        redirect_to :action => "verify", :service_url => @outlet.service_url, :auth_token => @current_token.token, :only_path => true
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
    @errors ||= {};
    @current_token = AuthToken.find_valid_token(params[:auth_token])
    
    if params[:service] and params[:account]
      @outlet = Outlet.find_by_service_and_account(params[:service], params[:account])
    else
      @outlet = Outlet.resolve(params[:service_url])
    end
    
    if @outlet and @outlet.account
      if @outlet.verified?
        @page_title ||= @outlet.service_info.display_name + " is verified"
      else
        @page_title ||= @outlet.service_info.display_name + " is not verified"
      end
        
      @agencies = agencies_for_form
      @selected_agencies = @outlet.agencies.map {|agency| agency.shortname}
      
      respond_with(XBoxer.new(:outlet, Boxer.ship(:outlet, @outlet, :view => :full )))
    else
      # Add a message about proper URLs for this service if 
      if @outlet and @outlet.service_info
        proper_url = @outlet.service_info.service_url_example
        help_msg = proper_url ? @errors[:help_msg] || " Accounts URLs on that service usually look like #{proper_url}." : ""
        bad_account = @errors[:bad_account] || " appears to be an incomplete URL."
        flash.now[:alert] = params[:service_url] + bad_account + help_msg
        @outlet = nil
      elsif params[:service_url] and !params[:service_url].empty?
        flash.now[:alert] = @errors[:bad_service_url] || "Sorry, we cannot look up the URL you entered because it is not from the social media services that we can verify."
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
    @return_to = params[:return_to] || 'verify'
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
      redirect_to(
        :action => @return_to, 
        :agency_id => params[:agency_id], 
        :service_url => service_url, 
        :auth_token => @current_token.token, 
        :only_path => true
      )
    else
      respond_with(XBoxer.new(:result, {:status => "success"}))
    end
  end
  
  def list
    @page_title = "Accounts"
    # @keywords = params[:q] || params[:keywords]
    
    @outlets = Outlet.includes(:agencies)
    
    if request.format == :atom
      @outlets = @outlets.order('outlets.updated_at DESC')
      @per_page = 20
    else
      @outlets = @outlets.order('account, service')
    end

    if params[:service_id] and !params[:service_id].empty?
      @outlets = @outlets.where(:service => params[:service_id])
    end
    if params[:agency_id] and !params[:agency_id].empty?
      @outlets = @outlets.joins(:agencies).where(:agencies => {:shortname => params[:agency_id]})
    end
    if params[:tag] and !params[:tag].empty?
      @outlets = @outlets.tagged_with(params[:tag])
    end
    
    @outlets = @outlets.page(params[:page_number]).per(@per_page)
    
    respond_with(XBoxer.new(:result, Boxer.ship(:outlets, @outlets) ))
  end

  private
  
  def agencies_for_form
    Agency.all(:order => "name")
  end
end

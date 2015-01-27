class Public::HowtoController < OutletsController
  layout "howto"
  before_filter :check_auth, :except => [:verify, :show, :list, :review, :browse]
  before_filter :check_review_auth, :only => [:review]
  #before_filter :look_up_auth, :only => [:browse]
  
  def verify
    @page_title = "Register an Account"
    super
  end
  
  def review
    @page_title = "Review Registered Social Media Accounts"
    
    @outlets = Outlet.to_review.includes(:agencies)

    if !params[:agency_id].blank?
      # Show all accounts for this agency
      @outlets = @outlets.joins(:agencies).where(:agencies => {:shortname => params[:agency_id]})
    elsif params[:admin]
      # Show the accounts added by admin
      @outlets = @outlets.updated_by('admin')
    else
      # Only show the accounts this user has submitted
      @outlets = @outlets.updated_by(@current_token.email)
    end
    if params[:tag] and !params[:tag].empty?
      @outlets = @outlets.tagged_with(params[:tag])
    end
    
    @outlets = @outlets.page(params[:page_number]).per(@per_page)
    
    respond_with(XBoxer.new(:result, Boxer.ship(:outlets, @outlets) ))
  end
  
  def confirm
    @outlet = Outlet.resolve(params[:service_url])
    
    unless @outlet && @outlet.verified?
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
    
    @outlet.auth_token = @current_token.token
        
    if @outlet.save
      if request.format == :html
        flash[:shortnotice] = "Thank you!"
        flash[:notice] = "The entry for #{ @outlet.service_info.display_name} has been confirmed."
        redirect_to(:action => 'review', 
          :agency_id => params[:agency_id],
          :auth_token => @current_token.token, 
          :only_path => true
        )
      else
        respond_with(XBoxer.new(:result, {:status => "success"}))
      end
    else
      if request.format == :html
        redirect_to(:action => 'review', 
          :agency_id => params[:agency_id],
          :auth_token => @current_token.token, 
          :only_path => true
        )
      else
        respond_with(XBoxer.new(:result, {:status => "error"}))
      end
    end
  end
  
  def browse
    @page_title = "Browse Social Media Accounts Managed by the U.S. Federal Government"
    
    @agencies = Agency.order('name')
    
    if !params[:agency_id].blank?
      # Show all accounts for this agency
      @agency = Agency.find_by_shortname(params[:agency_id])
    end
    
    if @agency
      @outlets = @agency.outlets.order('service_url').page(params[:page_number])
    end
  end
  
end

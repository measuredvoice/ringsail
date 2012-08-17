class HowtoController < OutletsController
  layout "howto"
  before_filter :check_auth, :except => [:verify, :show, :list]
  
  def verify
    @page_title = "Register an account"
    super
  end
  
  def review
    @page_title = "Review accounts"
    
    @outlets = Outlet.to_review.includes(:agencies)

    if params[:agency_id] and !params[:agency_id].empty?
      @outlets = @outlets.joins(:agencies).where(:agencies => {:shortname => params[:agency_id]})
    end
    if params[:tag] and !params[:tag].empty?
      @outlets = @outlets.tagged_with(params[:tag])
    end
    
    @outlets = @outlets.page(params[:page_number]).per(@per_page)
    
    respond_with(XBoxer.new(:result, Boxer.ship(:outlets, @outlets) ))
  end
  
  def confirm
    @outlet = Outlet.resolve(params[:service_url])
    @return_to = params[:return_to] || 'review'
    
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
        redirect_to :action => @return_to, :service_url => @outlet.service_url, :auth_token => @current_token.token, :only_path => true
      else
        respond_with(XBoxer.new(:result, {:status => "success"}))
      end
    else
      if request.format == :html
        redirect_to :action => @return_to, :service_url => @outlet.service_url, :auth_token => @current_token.token, :only_path => true
      else
        respond_with(XBoxer.new(:result, {:status => "error"}))
      end
    end
  end
end

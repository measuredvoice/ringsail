class Public::OutletsController < Public::PublicController


  def index

  end

  def verify
    if params[:service] and params[:account]
      @outlet = Outlet.where(service: params[:service], account: params[:account]).where("draft_id IS NOT NULL").first
    else
      @outlet = Outlet.where(service_url: params[:service_url]).where("draft_id IS NOT NULL").first
    end
    if @outlet
      respond_to do |format|
        format.json { render "api/v1/social_media/show" }
      end
    else
      errors = []
      if params[:service] && params[:account]
        errors << "Couldn't find item for url"
      elsif params[:serive_url]
        errors << "No social media account found for service / account id combination"
      else
        errors << "No parameters provide, specify service & account identifier, or service_url"
      end
      respond_to do |format|
        format.json { render json: { errors: errors } }
      end
    end
  end
end
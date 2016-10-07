class Public::BrowserController < Public::PublicController


  def export_social_media
    @outlets = Outlet.api.includes(:agencies,:official_tags)    
    if params[:hidden_agencies] && params[:hidden_agencies] != ""
      @outlets = @outlets.where("agencies.id" =>params[:hidden_agencies].split(","))
    end
    if params[:hidden_tags] && params[:hidden_tags] != ""
      @outlets = @outlets.where("official_tags.id" => params[:hidden_tags].split(","))
    end
    if params[:hidden_language] && params[:hidden_language] != ""
      @outlets = @outlets.where("language LIKE ? ", "%#{params[:hidden_language]}%")
    end
    if params[:hidden_services] && params[:hidden_services] != ""
      @outlets = @outlets.where(service: params[:hidden_services].split(","))
    end
    @outlets = @outlets.uniq.order(updated_at: :desc)
    respond_to do |format|
      format.csv { send_data @outlets.export_csv }
    end
  end

  def export_mobile_app
    @mobile_apps = MobileApp.api.includes(:agencies, :official_tags).where("draft_id IS NOT NULL")
    if params[:hidden_mobile_agencies] && params[:hidden_mobile_agencies] != ""
      @mobile_apps = @mobile_apps.where("agencies.id" =>params[:hidden_mobile_agencies].split(","))
    end
    if params[:hidden_mobile_language] && params[:hidden_mobile_language] != ""
      @mobile_apps = @mobile_apps.where("language LIKE ? ", "%#{params[:hidden_mobile_language]}%")
    end
    if params[:hidden_mobile_tags] && params[:hidden_mobile_tags] != ""
      @mobile_apps = @mobile_apps.where("official_tags.id" => params[:hidden_mobile_tags].split(","))
    end
    @mobile_apps = @mobile_apps.uniq.order(updated_at: :desc)
    respond_to do |format|
      format.csv { send_data @mobile_apps.export_csv }
    end   
  end
  
end
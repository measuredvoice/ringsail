class Public::BrowserController < Public::PublicController


  def export_social_media
    @outlets = Outlet.api.includes(:agencies,:official_tags)    
    if params[:q] && params[:q] != ""
      @outlets = @outlets.where("account LIKE ? OR organization LIKE ? OR short_description LIKE ? OR long_description LIKE ?", 
        "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%")
    end
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

  def social_media

  end

  def social_media_test_one

  end

  def social_media_bubbles
    @agencies = Agency.all

    @data = { name: "Social Media Accounts", children: []}

    @agencies.each do |agency|
      @services = Outlet.includes(:agencies).where("agencies.id" =>agency.id).group(:service).count
      @service_data = []
      @services.each do |key, value|
        @service_data << { name: "#{agency.name}, #{key.humanize}", size: value}
      end
      @agency_data = {
        name: agency.name,
        children: @service_data
      }
      @data[:children] << @agency_data
    end
    respond_to do |format|
      format.json { render json: @data.to_json }
    end
  end

  def mobile_apps

  end
end
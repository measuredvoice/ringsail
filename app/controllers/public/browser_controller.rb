class Public::BrowserController < Public::PublicController


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
        @service_data << { name: "#{agency.name}: #{key}", size: value}
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
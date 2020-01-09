class Admin::DashboardsController < Admin::AdminController
  respond_to :html, :xml, :json

  def index

    ## Counts for top panel
  	@agency_count = Agency.count
  	@outlet_count = Outlet.count
    @app_count = MobileApp.count
  	@user_count = User.count
    @gallery_count = Gallery.count
  	@tag_count = OfficialTag.count
  	@max_count = [@agency_count,@outlet_count,@app_count, @gallery_count,@user_count,@tag_count].sort.last

    ## specific breakdowns
    social_media_breakdowns = Outlet.group(:service).count
    @social_chart = []
    social_media_breakdowns.each do |k,v|
      @social_chart << {label: Admin::Service.find_by_shortname(k).longname, value: v}
    end
    
    mobile_breakdowns = MobileApp.joins(:mobile_app_versions).group("mobile_app_versions.platform").count
    @mobile_chart = []
    mobile_breakdowns.each do |k,v|
      @mobile_chart << {label: k, value: v}
    end
    
    matches = {
      "Outlet" => "Social Media Accounts",
      "User" => "User",
      "MobileApp" => "Mobile Application",
      "Gallery" => "Gallery"
    }  
    
  end

end

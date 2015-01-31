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
    social_media_breakdowns = Outlet.all.group(:service).count
    @social_chart = []
    social_media_breakdowns.each do |k,v|
      @social_chart << {label: Service.find_by_shortname(k).longname, value: v}
    end
    
    mobile_breakdowns = MobileAppVersion.all.group(:platform).count
    @mobile_chart = []
    mobile_breakdowns.each do |k,v|
      @mobile_chart << {label: k, value: v}
    end
    ## Activities stuff
  	@activities = PublicActivity::Activity.order("created_at desc").first(5)

    activities_graph = PublicActivity::Activity.find_by_sql("
      SELECT month(created_at) as month, year(created_at) as year, count(*) as count
      FROM activities
      GROUP BY month(created_at) ORDER BY created_at desc;")
    @activites_graph_json = []
    activities_graph.each do |item|
      @activites_graph_json << {
        period: "#{item['month']}-#{item['year']}",
        activities: item.count
      }
    end
    matches = {
      "Outlet" => "Social Media Accounts",
      "User" => "User",
      "MobileApp" => "Mobile Application",
      "Gallery" => "Gallery"
    }  
    activities_pie = PublicActivity::Activity.find_by_sql("
        SELECT COUNT(id) as count, trackable_type as type FROM activities GROUP BY trackable_type;")
    @activities_pie_json = []
    activities_pie.each do |item|
      @activities_pie_json << { label: matches[item.type], value: item.count}
    end

   
  end

  def social_media_breakdown
  	
  end

  def activities
    @activities = PublicActivity::Activity.order("created_at desc").page(params[:page]).per(25)
  end

end

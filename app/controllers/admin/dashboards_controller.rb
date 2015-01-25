class Admin::DashboardsController < Admin::AdminController
  respond_to :html, :xml, :json

  def index
  	@agency_count = Agency.count
  	@outlet_count = Outlet.count
    @app_count = MobileApp.count
  	@user_count = User.count
  	@tag_count = OfficialTag.count

  	@max_count = [@agency_count,@outlet_count,@user_count,@tag_count].sort.last


  	@activities = PublicActivity::Activity.order("created_at desc").first(10)

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
      "User" => "User"
    }  
    activities_pie = PublicActivity::Activity.find_by_sql("
        SELECT COUNT(id) as count, trackable_type as type FROM activities GROUP BY trackable_type;")
    @activities_pie_json = []
    activities_pie.each do |item|
      @activities_pie_json << { label: matches[item.type], value: item.count}
    end

   
  end

  def social_media_breakdown
  	@social_media_breakdowns = Outlet.all.group(:service).count
    @social_media_breakdowns = Hash[@social_media_breakdowns.sort_by{|k, v| v}.reverse]
  end

  def activities
    @activities = PublicActivity::Activity.order("created_at desc").page(params[:page]).per(25)
  end

end

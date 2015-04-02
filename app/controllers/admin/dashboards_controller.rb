class Admin::DashboardsController < Admin::AdminController
  respond_to :html, :xml, :json

  def index

    ## Counts for top panel
  	@agency_count = Agency.count
  	@outlet_count = Outlet.where("draft_id IS NULL").count
    @app_count = MobileApp.where("draft_id IS NULL").count
  	@user_count = User.count
    @gallery_count = Gallery.where("draft_id IS NULL").count
  	@tag_count = OfficialTag.count
  	@max_count = [@agency_count,@outlet_count,@app_count, @gallery_count,@user_count,@tag_count].sort.last

    ## specific breakdowns
    social_media_breakdowns = Outlet.where("draft_id IS NULL").group(:service).count
    @social_chart = []
    social_media_breakdowns.each do |k,v|
      @social_chart << {label: Service.find_by_shortname(k).longname, value: v}
    end
    
    mobile_breakdowns = MobileApp.joins(:mobile_app_versions).where("draft_id IS NULL").uniq.group("mobile_app_versions.platform").count
    @mobile_chart = []
    mobile_breakdowns.each do |k,v|
      @mobile_chart << {label: k, value: v}
    end
    ## Activities stuff
    activities_graph = PublicActivity::Activity.find_by_sql("
      SELECT month(created_at) as month, year(created_at) as year, count(*) as count
      FROM activities
      GROUP BY month(created_at) ORDER BY created_at desc;")
    @activites_graph_json = []
    activities_graph.each do |item|
      @activites_graph_json << {
        period: "#{item['year']}-#{item['month'].to_s.rjust(2, '0')}",
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

    # TAG CLOUD
    @tag_cloud = OfficialTag.find_by_sql("SELECT tag_text as text, 
      (draft_gallery_count + draft_outlet_count + draft_mobile_app_count) as weight 
      FROM official_tags 
      ORDER BY (draft_gallery_count + draft_outlet_count + draft_mobile_app_count) DESC
      LIMIT 50")
  end

end

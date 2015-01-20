class Admin::DashboardsController < Admin::AdminController
  respond_to :html, :xml, :json

  def index
  	@agency_count = Agency.count
  	@outlet_count = Outlet.count
  	@user_count = User.count
  	@tag_count = OfficialTag.count

  	@max_count = [@agency_count,@outlet_count,@user_count,@tag_count].sort.last


  	@activities = PublicActivity::Activity.order("created_at desc")
  end

  def social_media_breakdown
  	@social_media_breakdowns = Outlet.all.group(:service).count
    @social_media_breakdowns = Hash[@social_media_breakdowns.sort_by{|k, v| v}.reverse]
  end

end

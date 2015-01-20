class Admin::AdminController < ApplicationController
  include PublicActivity::StoreController
  respond_to :html, :xml, :json
  before_filter :require_user
  helper_method :current_user  
  hide_action :current_user  
  layout "admin"

  def require_user
  	puts "not actually requiring a user yet, TODO: replacing authentication with max."
  end

  def current_user
  	@current_user ||= User.first #until we wire users in, everyone is the first user!
  	@current_user
  end
end

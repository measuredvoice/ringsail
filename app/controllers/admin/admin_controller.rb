class Admin::AdminController < ApplicationController
  include PublicActivity::StoreController
  layout "admin"

  before_filter :authenticate_user! unless Rails.env.development?
  before_filter :banned_user?, except: [:about, :impersonate]
  helper_method :current_user  
  
  def about
    @admins = User.where("role = ?", User.roles[:admin])
  end

  def impersonate
    session[:user_id] = params[:user_id]
    redirect_to admin_dashboards_path, notice: "Now impersonating: #{current_user.email} with role: #{current_user.role.humanize}"
  end

  def current_user
    if Rails.env.development?
      if session[:user_id]
        if User.where(id: session[:user_id]).count > 0
          @current_user ||= User.find(session[:user_id])
        else
          @current_user ||= User.first
        end
      else
        @current_user ||= User.first
      end
    else
      @current_user ||= warden.authenticate(scope: :user) 
    end
  end

  def banned_user?
    if current_user.banned?
      redirect_to admin_about_path, status: 302, notice: "You have been banned from the system you may want to email an admin directly if you believe this to be in error."
    end
  end

  def require_admin
    if !current_user.admin?
      redirect_to admin_dashboards_path, notice: "You shouldn't be going there... here is the dashboard instead."
    end
  end

end

class Admin::AdminController < ApplicationController
  include PublicActivity::StoreController
  layout "admin"

  before_filter :authenticate_user! unless Rails.env == "development"
  helper_method :current_user  
  
  def about

  end
  def current_user
    if Rails.env == "development"
      @current_user ||= User.first
    else
      @current_user ||= warden.authenticate(scope: :user) 
    end
  end
end

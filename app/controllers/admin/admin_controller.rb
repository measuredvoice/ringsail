class Admin::AdminController < ApplicationController
  include PublicActivity::StoreController
  respond_to :html, :xml, :json

  before_filter :authenticate_user! unless Rails.env == "development"
  helper_method :current_user  
  layout "admin"

  def current_user
    if Rails.env == "development"
      @current_user ||= User.first
    else
      @current_user ||= warden.authenticate(scope: :user) 
    end
  end
end

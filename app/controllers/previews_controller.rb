class PreviewsController < ApplicationController
  layout "native_admin"
  respond_to :html
  before_filter :authenticate_user!
  
  def review_email
    @page_title = "Preview 6-Month Review Emails"
    @admin = current_user
    
    @emails = Outlet.emails_for_review
  end

  def send_review_email
    @admin = current_user
    
    @email = params[:updater_email]
    
    redirect_to preview_review_email_path
  end
end

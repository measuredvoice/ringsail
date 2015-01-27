class Public::PreviewsController < ApplicationController
  layout "native_admin"
  respond_to :html
 # before_filter :authenticate_user!
  
  def review_email
    @page_title = "Preview 6-Month Review Emails"
    @admin = current_user
    
    @emails = Outlet.emails_for_review
  end

  def send_review_email
    @admin = current_user
    
    # Prepare the list of accounts for the provided email,
    # but send the email to the admin requesting it.
    email = params[:updater_email]    
    admin_email = current_user.email
    
    AdminMailer.six_month_review_notice(email, admin_email).deliver
    
    flash[:notice] = "Email preview sent to your address for #{@email}."
    redirect_to preview_review_email_path
  end
end

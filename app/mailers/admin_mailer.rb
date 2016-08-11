class AdminMailer < ActionMailer::Base
  default from: "US Digital Registry <socialmediaregistry@usa.gov>"

  def six_month_review_notice(email, preview_email=nil)
    @outlets_count = Outlet.to_review_for(email).count
    
    # Figure out the default email for admin-added accounts
    if email == 'admin'
      email = 'socialmediaregistry@gsa.gov'
      show_admin = true
    end
    
    # Generate a long-duration auth token for the review process
    auth_token = AuthToken.new(:email => email)
    auth_token.duration = 'long'
    auth_token.save
    
    @link_url = url_for(
      :controller  => 'howto', 
      :action      => 'review',
      :only_path   => false, 
      :auth_token  => auth_token.token,
      :admin       => show_admin,
    )
    @email = email
    
    if preview_email
      to_email = preview_email
    elsif !Rails.env.production?
      to_email = ENV['EMAIL_BYPASS_USER']
    else
      to_email = email
    end
    
    mail(:to => to_email, :subject => "your Social Media Registry accounts need review")
  end
end

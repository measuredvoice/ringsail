class AgencyNotificationMailer < ActionMailer::Base
  default from: "socialmediaregistry@gsa.gov"

  def new_outlet_email(outlet)
    @outlet = outlet
    
    @link_url = url_for(
      :controller  => 'howto', 
      :action      => 'verify',
      :only_path   => false, 
      :service_url => @outlet.service_url,
    )
    
    if Rails.env.production?
      to_emails = @outlet.contact_emails
    else
      to_emails = ENV['EMAIL_BYPASS_USER']
    end
    
    mail(:to => to_emails, :subject => "New Social Media Registry account")
  end
end

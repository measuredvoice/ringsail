class AuthTokenMailer < ActionMailer::Base
  default from: "chris@measuredvoice.com"

  def token_link_email(auth_token, service_url=nil)
    @auth_token = auth_token
    @service_url = service_url
    @link_url = url_for(
      :controller  => 'outlets', 
      :action      => 'add',
      :host        => 'localhost:3000',
      :only_path   => false, 
      :service_url => service_url,
      :auth_token  => @auth_token.token
    )
        
    # to_email = auth_token.email
    to_email = 'chris@measuredvoice.com'
    
    mail(:to => to_email, :subject => "Your Social Media Registry request")
  end
end

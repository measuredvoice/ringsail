module AuthHelper

  def current_token=(token)
    @current_token = token
  end

  def current_token
    @current_token
  end
  
  def look_up_auth
    self.current_token = AuthToken.find_valid_token(params[:auth_token])
  end
  
  def check_auth
    look_up_auth
    deny_access if self.current_token.nil?
  end

  def check_review_auth
    look_up_auth
    deny_access(:goto => 'review') if self.current_token.nil?
  end

  def deny_access(path_options={})
    flash[:notice] = "Please request authorization before proceeding."
    redirect_to howto_request_token_path(path_options)
  end
end

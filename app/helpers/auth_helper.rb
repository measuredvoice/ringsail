module AuthHelper

  def current_token=(token)
    @current_token = token
  end

  def current_token
    @current_token
  end
  
  def check_auth
    self.current_token = AuthToken.find_valid_token(params[:auth_token])
    deny_access if self.current_token.nil?
  end

  def deny_access
    redirect_to new_path, :notice => "Please request authorization before proceeding."
  end
end

module AuthHelper

  def current_token=(token)
    @current_token = token
  end

  def current_token
    @current_token
  end
  
  def token_is_ok?
    self.current_token = AuthToken.find_by_token(params[:auth_token])
    !self.current_token.nil?
  end
  
  def check_auth
    deny_access unless token_is_ok?
  end

  def deny_access
    redirect_to new_path, :notice => "Please request authorization before proceeding."
  end
end

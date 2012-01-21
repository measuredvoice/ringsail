class HowtoController < OutletsController
  layout "howto"
  
  def verify
    @page_title = "Register an account"
    super
  end
end

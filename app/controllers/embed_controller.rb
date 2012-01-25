class EmbedController < OutletsController
  layout "embed"

  def verify
    @page_title = "Register an account"
    super
  end
end

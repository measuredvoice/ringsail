class HomeController < ApplicationController
  def index
    @page_title = "Social Media Registry API"
    redirect_to ENV['REGISTRY_DOCS_URL'] || 'http://usa.gov/'
  end
end

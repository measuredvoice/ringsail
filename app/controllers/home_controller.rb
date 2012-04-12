class HomeController < ApplicationController
  def index
    @page_title = "Social Media Registry API"
    redirect_to rails_admin_path
  end
end

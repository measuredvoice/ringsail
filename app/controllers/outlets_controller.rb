class OutletsController < ApplicationController
  def add
    @outlet = Outlet.resolve(params[:service_url])
  end

end

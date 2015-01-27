class Public::ServicesController < ApplicationController
  respond_to :html, :xml, :json

  def list
    @services = Service.all
    respond_with(XBoxer.new(:result, Boxer.ship(:services, @services) ))
  end
end

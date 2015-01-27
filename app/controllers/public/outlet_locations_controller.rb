class Public::OutletLocationsController < ApplicationController
  respond_to :html, :xml, :json

  def resolve
    @page_title = "Resolve a location"
    @last_input = params[:location]
    @locations = OutletLocation.find_by_text(params[:location])
    respond_with(XBoxer.new(:result, Boxer.ship(:locations, @locations) ))
  end
end

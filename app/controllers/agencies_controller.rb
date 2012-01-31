class AgenciesController < ApplicationController
  respond_to :html, :xml, :json

  def list
    @agencies = Agency.order('name').page(params[:page_number])
    respond_with(XBoxer.new(:result, Boxer.ship(:agencies, @agencies) ))
  end
end

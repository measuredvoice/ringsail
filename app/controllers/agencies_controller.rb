class AgenciesController < ApplicationController
  respond_to :html, :xml, :json

  def list
    @agencies = Agency.all
    respond_with(XBoxer.new(:result, Boxer.ship(:agencies, @agencies) ))
  end
end

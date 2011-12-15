class AgenciesController < ApplicationController
  respond_to :html, :xml, :json

  def list
    @agencies = Agency.all(:order => "name")
    respond_with(XBoxer.new(:result, Boxer.ship(:agencies, @agencies) ))
  end
end

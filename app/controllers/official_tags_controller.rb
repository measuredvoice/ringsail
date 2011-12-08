class OfficialTagsController < ApplicationController
  respond_to :html, :xml, :json

  def list
    @tags = OfficialTag.all
    respond_with(XBoxer.new(:result, Boxer.ship(:official_tags, @tags) ))
  end
end

class OfficialTagsController < ApplicationController
  respond_to :html, :xml, :json

  def list
    @page_title = "List Official Tag Suggestions"
    @last_input = params[:q] || params[:keywords]
    @tags = OfficialTag.autocomplete(@last_input)
    
    respond_with(XBoxer.new(:result, Boxer.ship(:official_tags, @tags) ))
  end
end

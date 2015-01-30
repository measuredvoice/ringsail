class Public::OfficialTagsController < ApplicationController
  respond_to :html, :xml, :json
  before_action :set_official_tags, except: [:index]

  def list
    @page_title = "List Official Tag Suggestions"
    @last_input = params[:q] || params[:keywords]
    @tags = OfficialTag.autocomplete(@last_input)
    
    respond_with(@tags.map { |tag| Boxer.ship(:official_tag, tag) })
  end
  private
  	def set_official_tags
   		#@official_tag = OfficialTag.find(params[:id])
 	  end
  	def official_tags_params
   		params.require(:official_tag).permit(:id, :shortname, :tag_text)
 	  end
end

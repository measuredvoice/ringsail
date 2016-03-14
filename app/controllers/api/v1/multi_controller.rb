class Api::V1::MultiController < Api::ApiController

  def index
    ### Come up with some way to semi-inteligently get multiple records, need a search index most likely
  end

  def show
    
  end

  def autocomplete 
    query = params[:q]

    @agencies = Agency.where("name LIKE ?","%#{query}%")
    @services = Admin::Service.search_by_name(query)
    @tags = OfficialTag.where("tag_text LIKE ?", "%#{query}%")
    if query
      render 'autocomplete'
    else
      render json: {metadata: {query: "", error:"No query provided"}}
    end
  end

  def tokeninput
    query = params[:q]
    @agencies = Agency.where("name LIKE ?","%#{query}%")
    @services = Admin::Service.search_by_name(query)
    @tags = OfficialTag.where("tag_text LIKE ?", "%#{query}%")
    if query
      render 'autocomplete'
    else
      render json: {metadata: {query: "", error:"No query provided"}}
    end
  end
end

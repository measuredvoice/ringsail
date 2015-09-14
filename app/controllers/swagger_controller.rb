class SwaggerController < ApplicationController

  layout 'application', :except => :doc
  def index

  end


  def doc
    @data = JSON.parse(File.read("app/views/swagger/swagger_docs/#{params[:file]}.json"))
    render json: @data
  end
end
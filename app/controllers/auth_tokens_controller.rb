class AuthTokensController < ApplicationController
  respond_to :html, :xml, :json

  def new
    @page_title = "Request authorization"
    @auth_token = AuthToken.new
  end

  def create
    @auth_token = AuthToken.new(params)
    
    if @auth_token.save
      @page_title = "Authorization requested"
      
      AuthTokenMailer.token_link_email(@auth_token, params[:service_url]).deliver
      
      respond_with(XBoxer.new(:result, {
        :status => "success",
      }))
    else
      @page_title = "Request authorization"
      
      respond_to do |format|
        format.html {render 'new'}
        format.any(:xml, :json) do
          render request.format.to_sym => XBoxer.new(:result, {
            :status => "incomplete",
            :needs  => "email, phone",
          })
        end
      end
    end
  end
end

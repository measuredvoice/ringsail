class AuthTokensController < ApplicationController
  respond_to :html, :xml, :json

  def new
    @page_title = "Request authorization"
    @auth_token = AuthToken.new
    @goto = params[:goto] || 'add'
  end

  def create
    @auth_token = AuthToken.new(params.except(:goto))   
    @goto = params[:goto] || 'add'
    
    if AuthToken.find_recent_by_email(params[:email]) || @auth_token.save
      @page_title = "Authorization requested"
      
      if @auth_token.token
        AuthTokenMailer.token_link_email(@auth_token, params[:service_url], @goto).deliver
      end
      
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

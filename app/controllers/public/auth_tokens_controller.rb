class Public::AuthTokensController < ApplicationController
  respond_to :html, :xml, :json
  before_action :set_authtoken, except: [:index, :new, :create]
  def new
    @page_title = "Request authorization"
    @auth_token = AuthToken.new
    @goto = params[:goto] || 'add'
  end

  def create
    token_fields = [:email, :phone]
    token_params = params.select {|k,v| token_fields.find_index(k.to_sym)}
    @auth_token = AuthToken.new(token_params)   
    
    if AuthToken.find_recent_by_email(params[:email]) || @auth_token.save
      @page_title = "Authorization Requested"
      
      if @auth_token.token
        email_fields = [:service_url, :goto, :agency_id]
        email_params = params.select {|k,v| email_fields.find_index(k.to_sym)}
        AuthTokenMailer.token_link_email(@auth_token, email_params).deliver
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
  private 
    def set_authtoken
      @auth_token = AuthToken.find(params[:id])
    end
    def authtoken_params
      params.require(:authtoken).permit(:email, :phone)
    end

end

class ApplicationController < ActionController::Base
  protect_from_forgery
  include AuthHelper

  before_filter :check_cors_preflight
  after_filter :set_cors_headers
  
  # Return CORS access control headers for all responses.
  #
  def set_cors_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Max-Age'] = "1728000"
  end
  
  # If this is a CORS preflight OPTIONS request,
  # return only the necessary headers and an empty text result.
  #
  def check_cors_preflight
    if request.method == :options
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version'
      headers['Access-Control-Max-Age'] = '1728000'
      render :text => '', :content_type => 'text/plain'
    end
  end
end

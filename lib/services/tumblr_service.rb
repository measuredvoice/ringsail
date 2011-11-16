class TumblrService < Service
  def self.handles?(uri)
    uri.host =~ /tumblr.com$/
  end
  
  def shortname
    :tumblr
  end
  
  def account
    @details ||= fetch_details
    @details[:account]
  end
  
  private
  
  def fetch_details
    /^(?<account>\w+)\.tumblr.com/ =~ @uri.host
    {
      :account => account,
    }
  end
end

Service.register(:tumblr, TumblrService)

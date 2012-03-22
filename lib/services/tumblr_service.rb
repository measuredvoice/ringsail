class TumblrService < Service
  def self.handles?(uri)
    uri.host =~ /tumblr.com$/
  end
  
  def self.shortname
    :tumblr
  end
  
  def display_name
    "#{account} on Tumblr"
  end
  
  def account
    /^(?<account>[\w-]+)\.tumblr.com/ =~ @uri.host
    account
  end

  def service_url_example
    "http://example.tumblr.com/"
  end
  
  def service_url_canonical
    "http://#{account}.tumblr.com/"
  end

  private
  
  def fetch_details
    {
      :account => account,
    }
  end
end

Service.register(:tumblr, TumblrService)

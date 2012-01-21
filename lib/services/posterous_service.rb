class PosterousService < Service
  def self.handles?(uri)
    uri.host =~ /posterous.com$/
  end
  
  def self.shortname
    :posterous
  end
  
  def display_name
    "#{account} on Posterous"
  end
  
  def account
    /^(?<account>[\w-]+)\.posterous.com/ =~ @uri.host
    account
  end

  def service_url_example
    "http://USAgov.posterous.com/"
  end
  
  def service_url_canonical
    "http://#{account}.posterous.com/"
  end

  private
  
  def fetch_details
    {
      :account => account,
    }
  end
end

Service.register(:posterous, PosterousService)

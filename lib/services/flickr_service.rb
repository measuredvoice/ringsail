class FlickrService < Service
  def self.handles?(uri)
    uri.host =~ /flickr.com$/
  end
  
  def shortname
    :flickr
  end
  
  def display_name
    "#{account} on Flickr"
  end
  
  def account
      /(photos|people)\/(?<account>[\w-]+)$/ =~ @uri.path
    account
  end
  
  def service_url_example
    "http://flickr.com/photos/USAgov"
  end
  
  def service_url_canonical
    "http://flickr.com/photos/#{account}"
  end
  
  private
  
  def fetch_details
    {
      :account => account,
    }
  end
  
end

Service.register(:flickr, FlickrService)

class FlickrService < Service
  def self.handles?(uri)
    uri.host =~ /flickr.com$/
  end
  
  def shortname
    :flickr
  end
  
  def display_name
    "#{account} photos on Flickr"
  end
  
  def account
    /photos\/(?<account>\w+)\/?$/ =~ @uri.path
    account
  end
  
  private
  
  def fetch_details
    {
      :account => account,
    }
  end
end

Service.register(:flickr, FlickrService)

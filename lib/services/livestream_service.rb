class LivestreamService < Service
  def self.handles?(uri)
    uri.host =~ /livestream.com$/
  end
  
  def self.shortname
    :livestream
  end
  
  def display_name
    "#{account} on Livestream"
  end

  def account
      /\/(?<account>[\w-]+)$/ =~ @uri.path
    account
  end
  
  def service_url_example
    "http://www.livestream.com/username"
  end
  
  def service_url_canonical
    "http://livestream.com/#{account}"
  end

  private
  
  def fetch_details
    {
      :account => account,
    }
  end
end

Service.register(:livestream, LivestreamService)

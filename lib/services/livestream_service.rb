class LivestreamService < Service
  def self.handles?(uri)
    uri.host =~ /livestream.com/
  end
  
  def self.shortname
    :livestream
  end

  def self.longname
  	"Livestream"
  end
  
  def display_name
    "#{account} on Livestream"
  end

  def account
      /\/(?<account>[\w-]+)$/ =~ @uri.path
    account
  end
  
  def self.service_url_example
     "http://new.livestream.com/username"
  end
  
  def self.service_url_canonical
    "http://new.livestream.com/#{account}"
  end

  private
  
  def fetch_details
    {
      :account => account
    }
  end
end

Service.register(:livestream, LivestreamService)

class BlipService < Service
  def self.handles?(uri)
    uri.host =~ /blip.tv$/
  end
  
  def shortname
    :blip
  end
  
  def display_name
    "#{account} on Blip"
  end

  def account
      /\/(?<account>[\w-]+)$/ =~ @uri.path
    account
  end
  
  def service_url_example
    "http://www.blip.tv/USAgov"
  end
  
  def service_url_canonical
    "http://blip.tv/#{account}"
  end

  private
  
  def fetch_details
    {
      :account => account,
    }
  end
end

Service.register(:blip, BlipService)

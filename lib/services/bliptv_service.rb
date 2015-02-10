class BlipService < Service
  def self.handles?(uri)
    uri.host =~ /blip.tv$/
  end
  
  def self.shortname
    :blip
  end
  
  def self.longname
    "Blip"
  end
  
  def display_name
    "#{account} on Blip"
  end

  def account
      /\/(?<account>[\w-]+)$/ =~ @uri.path
    account
  end
  
  def self.service_url_example
    "http://www.blip.tv/username"
  end
  
  def self.service_url_canonical
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

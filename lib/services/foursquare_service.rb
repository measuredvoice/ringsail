class FoursquareService < Service
  def self.handles?(uri)
    uri.host =~ /foursquare.com$/
  end
  
  def self.shortname
    :foursquare
  end
  
  def display_name
    "#{account} on Foursquare"
  end

  def account
      /\/(?<account>[\w-]+)$/ =~ @uri.path
    account
  end
  
  def self.service_url_example
    "http://www.foursquare.com/username"
  end
  
  def self.service_url_canonical
    "http://foursquare.com/#{account}"
  end

  private
  
  def fetch_details
    {
      :account => account,
    }
  end
end

Service.register(:foursquare, FoursquareService)

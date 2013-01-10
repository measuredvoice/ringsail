class PinterestService < Service
  def self.handles?(uri)
    uri.host =~ /pinterest.com$/
  end
  
  def self.shortname
    pinterest
  end
  
  def display_name
    "#{account} on Pinterest"
  end

  def account
      /\/(?<account>[\w-]+)$/ =~ @uri.path
    account
  end
  
  def service_url_example
    "http://www.pinterest.com/username"
  end
  
  def service_url_canonical
    "http://pinterest.com/#{account}"
  end

  private
  
  def fetch_details
    {
      :account => account,
    }
  end
end

Service.register(:pinterest, PinterestService)

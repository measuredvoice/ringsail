class UstreamService < Service
  def self.handles?(uri)
    uri.host =~ /ustream.tv$/
  end
  
  def shortname
    :ustream
  end
  
  def display_name
    "#{account} on Ustream"
  end

  def account
      /\/(?<account>[\w-]+)$/ =~ @uri.path
    account
  end
  
  def service_url_example
    "http://www.ustream.tv/NASAJPL"
  end
  
  def service_url_canonical
    "http://ustream.tv/#{account}"
  end

  private
  
  def fetch_details
    {
      :account => account,
    }
  end
end

Service.register(:ustream, UstreamService)

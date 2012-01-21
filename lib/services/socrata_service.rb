class SocrataService < Service
  def self.handles?(uri)
    uri.host =~ /socrata.com$/
  end
  
  def self.shortname
    :socrata
  end
  
  def display_name
    "#{account} on Socrata"
  end
  
  def account
    /^(?<account>[\w-]+)\.socrata.com/ =~ @uri.host
    account
  end

  def service_url_example
    "http://census.socrata.com/"
  end
  
  def service_url_canonical
    "http://#{account}.socrata.com/"
  end

  private
  
  def fetch_details
    {
      :account => account,
    }
  end
end

Service.register(:socrata, SocrataService)

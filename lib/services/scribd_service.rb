class ScribdService < Service
  def self.handles?(uri)
    uri.host =~ /scribd.com$/
  end
  
  def self.shortname
    :scribd
  end
  
  def display_name
    "#{account} on Scribd"
  end

  def account
      /\/(?<account>[\w-]+)$/ =~ @uri.path
    account
  end
  
  def self.service_url_example
    "http://www.scribd.com/username"
  end
  
  def self.service_url_canonical
    "http://scribd.com/#{account}"
  end

  private
  
  def fetch_details
    {
      :account => account,
    }
  end
end

Service.register(:scribd, ScribdService)

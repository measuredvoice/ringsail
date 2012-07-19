class StorifyService < Service
  def self.handles?(uri)
    uri.host =~ /storify.com$/
  end
  
  def self.shortname
    :storify
  end
  
  def display_name
    "#{account} on Storify"
  end

  def account
      /^\/(?<account>[\w-]+)/ =~ @uri.path
    account
  end
  
  def service_url_example
    "http://storify.com/username"
  end
  
  def service_url_canonical
    "http://storify.com/#{account}"
  end

  private
  
  def fetch_details
    {
      :account => account,
    }
  end
end

Service.register(:storify, StorifyService)

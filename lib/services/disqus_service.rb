class DisqusService < Service
  def self.handles?(uri)
    uri.host =~ /disqus.com$/
  end
  
  def shortname
    :disqus
  end
  
  def display_name
    "#{account} on Disqus"
  end

  def account
      /\/(?<account>[\w-]+)$/ =~ @uri.path
    account
  end
  
  def service_url_example
    "http://www.disqus.com/USAgov"
  end
  
  def service_url_canonical
    "http://disqus.com/#{account}"
  end

  private
  
  def fetch_details
    {
      :account => account,
    }
  end
end

Service.register(:disqus, DisqusService)

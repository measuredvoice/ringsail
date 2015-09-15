class MyspaceService < Service
  def self.handles?(uri)
    uri.host =~ /myspace.com$/
  end
  
  def self.shortname
    :myspace
  end
  
  def self.archived? 
    true
  end

  def display_name
    "#{account} on Myspace"
  end

  def account
      /\/(?<account>[\w-]+)$/ =~ @uri.path
    account
  end
  
  def self.service_url_example
    "http://www.myspace.com/username"
  end
  
  def self.service_url_canonical
    "http://myspace.com/#{account}"
  end

  private
  
  def fetch_details
    {
      :account => account,
    }
  end
end

Service.register(:myspace, MyspaceService)

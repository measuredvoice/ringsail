class FacebookService < Service
  def self.handles?(uri)
    uri.host =~ /facebook.com$/
  end
  
  def self.shortname
    :facebook
  end
  
  def display_name
    if account =~ /[^\d]/
      "#{account} on Facebook"
    else
      "Facebook account ID: #{account}"
    end
  end
  
  def account
    if /pages/ =~ @uri.path
      /\/(?<account>\d+)$/ =~ @uri.path
    else
      /\/(?<account>[\w\.-]+)$/ =~ @uri.path
    end
    account
  end

  def self.service_url_example
    "https://www.facebook.com/username"
  end
  
  def self.service_url_canonical
    "http://facebook.com/#{account}"
  end

  private
  
  def fetch_details
    {
      :account => account,
    }
  end
end

Service.register(:facebook, FacebookService)

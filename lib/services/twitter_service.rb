class TwitterService < Service
  def self.handles?(uri)
    uri.host =~ /twitter.com$/
  end
  
  def self.shortname
    :twitter
  end
  
  def display_name
    "@#{account} on Twitter"
  end
  
  def account
    # Twitter's hashbang syntax might put the account name in the fragment
    /\/(?<account>[\w-]+)$/ =~ (@uri.fragment || @uri.path)
    account
  end

  def account_id
    @details ||= fetch_details
    @details[:account_id]
  end

  def self.service_url_example
    "http://twitter.com/username"
  end
  
  def self.service_url_canonical
    "http://twitter.com/#{account}"
  end

  private
  
  def fetch_details
    {
      :account => account,
    }
  end
end

Service.register(:twitter, TwitterService)

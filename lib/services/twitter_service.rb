class TwitterService < Service
  def self.handles?(uri)
    uri.host =~ /twitter.com$/
  end
  
  def shortname
    :twitter
  end
  
  def pretty_name
    "@#{account} on Twitter"
  end
  
  def account
    # Twitter's hashbang syntax might put the account name in the fragment
    /\/(?<account>\w+)$/ =~ (@uri.fragment || @uri.path)
    account
  end
  
  private
  
  def fetch_details
    
    begin
      user = Twitter.user(account)
    rescue
      return {:account => account}
    end
    
    {
      :account       => account,
      :profile_name  => user.name,
      :profile_image => user.profile_image_url,
      :info_url      => user.url,
      :location      => user.location,
      :verified      => user.verified,
      :followers     => user.followers_count,
    }
  end
end

Service.register(:twitter, TwitterService)

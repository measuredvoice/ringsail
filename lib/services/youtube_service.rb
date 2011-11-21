class YoutubeService < Service
  def self.handles?(uri)
    uri.host =~ /youtube.com$/
  end
  
  def shortname
    :youtube
  end
  
  def display_name
    "#{account}'s Channel on YouTube"
  end
  
  def account
    /\/(?<account>\w+)$/ =~ @uri.path
    account
  end
  
  private
  
  def fetch_details
    {
      :account => account,
    }
  end
end

Service.register(:youtube, YoutubeService)

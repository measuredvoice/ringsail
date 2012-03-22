class YoutubeService < Service
  def self.handles?(uri)
    uri.host =~ /youtube.com$/
  end
  
  def self.shortname
    :youtube
  end
  
  def display_name
    "#{account} on YouTube"
  end

  def account
    if /user/ =~ @uri.path
      /\/(?<account>[\w-]+)$/ =~ @uri.path
    else
      /\/(?<account>[\w-]+)$/ =~ @uri.path
    end
    account
  end
  
  def service_url_example
    "http://www.youtube.com/username"
  end
  
  def service_url_canonical
    "http://youtube.com/#{account}"
  end

  private
  
  def fetch_details
    {
      :account => account,
    }
  end
end

Service.register(:youtube, YoutubeService)

class YoutubeService < Service
  def self.handles?(uri)
    uri.host =~ /youtube.com$/
  end
  
  def self.shortname
    :youtube
  end

  def self.longname
    "YouTube"
  end
  
  def display_name
    "#{account} on YouTube"
  end

  def account
    /^(\/user)?\/(?<account>[\w-]+)/ =~ @uri.path
    
    @exclude = ['watch', 'movies', 'channel', 'music', 'shows', 
      'live', 'sports', 'education', 'news']
    if @exclude.any? {|stopword| account == stopword}
      account = nil
    end
    
    account
  end
  
  def self.service_url_example
    "http://www.youtube.com/username"
  end
  
  def self.service_url_canonical
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

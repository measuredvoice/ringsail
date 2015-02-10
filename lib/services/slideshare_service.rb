class SlideshareService < Service
  def self.handles?(uri)
    uri.host =~ /slideshare.net$/
  end
  
  def self.shortname
    :slideshare
  end
  
  def display_name
    "#{account} on SlideShare"
  end

  def account
    /\/(?<account>[\w-]+)$/ =~ @uri.path
    
   
    @exclude = ['newsfeed', 'popular', 'most-downloaded', 'most-favorited',
      'pro_accounts', 'popular', 'featured', 'features']
    if @exclude.any? {|stopword| account == stopword}
      account = nil
    end
    
    account
  end
  
  def self.service_url_example
    "http://www.slideshare.net/username"
  end
  
  def self.service_url_canonical
    "http://slideshare.net/#{account}"
  end

  private
  
  def fetch_details
    {
      :account => account,
    }
  end
end

Service.register(:slideshare, SlideshareService)

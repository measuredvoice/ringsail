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
    account
  end
  
  def service_url_example
    "http://www.slideshare.net/whitehouse"
  end
  
  def service_url_canonical
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

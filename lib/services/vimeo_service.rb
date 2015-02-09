class VimeoService < Service
  def self.handles?(uri)
    uri.host =~ /vimeo.com$/
  end
  
  def self.shortname
    :vimeo
  end
  
  def display_name
    "#{account} on Vimeo"
  end

  def account
    # This is probably an individual video
    return nil if /^\/\d+$/ =~ @uri.path

    if /channels/ =~ @uri.path
      /\/(?<account>[\w-]+)$/ =~ @uri.path
    else
      /^\/(?<account>[\w-]+)/ =~ @uri.path
    end
    account
  end
  
  def self.service_url_example
    "http://vimeo.com/username"
  end
  
  def self.service_url_canonical
    "http://vimeo.com/#{account}"
  end
  
  private
  
  def fetch_details
    {
      :account => account,
    }
  end
end

Service.register(:vimeo, VimeoService)

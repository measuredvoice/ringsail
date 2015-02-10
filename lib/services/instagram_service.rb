class InstagramService < Service
  def self.handles?(uri)
    # Exclude help.instagram.com, blog.instagram.com, etc.
    uri.host =~ /^instagram.com$/
  end
  
  def self.shortname
    :instagram
  end
  
  def display_name
    "#{account} on Instagram"
  end

  def account
    /^\/(?<account>[\w-]+)/ =~ @uri.path
    
   
    @exclude = ['p', 'popular', 'developer', 'press', 'about']
    if @exclude.any? {|stopword| account == stopword}
      account = nil
    end
    
    account
  end
  
  def self.service_url_example
    "http://instagram.com/username"
  end
  
  def self.service_url_canonical
    "http://instagram.com/#{account}"
  end

  private
  
  def fetch_details
    {
      :account => account,
    }
  end
end

Service.register(:instagram, InstagramService)

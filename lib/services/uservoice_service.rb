class UservoiceService < Service
  def self.handles?(uri)
    uri.host =~ /uservoice.com$/
  end
  
  def self.shortname
    :uservoice
  end
  
  def display_name
    "#{account} on UserVoice"
  end
  
  def account
    /^(?<account>[\w-]+)\.uservoice.com/ =~ @uri.host
    account
  end

  def self.service_url_example
    "http://username.uservoice.com/"
  end
  
  def self.service_url_canonical
    "http://#{account}.uservoice.com/"
  end

  private
  
  def fetch_details
    {
      :account => account,
    }
  end
end

Service.register(:uservoice, UservoiceService)

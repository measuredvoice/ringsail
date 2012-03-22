class IdeascaleService < Service
  def self.handles?(uri)
    uri.host =~ /ideascale.com$/
  end
  
  def self.shortname
    :ideascale
  end
  
  def self.longname
    "IdeaScale"
  end
  
  def account
    /^(?<account>[\w-]+)\.ideascale.com/ =~ @uri.host
    account
  end

  def service_url_example
    "http://example.ideascale.com/"
  end
  
  def service_url_canonical
    "http://#{account}.ideascale.com/"
  end

  private
  
  def fetch_details
    {
      :account => account,
    }
  end
end

Service.register(:ideascale, IdeascaleService)

class LinkedinService < Service
  def self.handles?(uri)
    uri.host =~ /linkedin.com$/
  end
  
  def self.shortname
    :linkedin
  end
  
  def self.longname
    "LinkedIn"
  end
  
  def display_name
    "#{account} on LinkedIn"
  end

  def account
    /\/company\/(?<account>[\w.-]+)$/ =~ @uri.path
    account
  end
  
  def self.service_url_example
    "http://www.linkedin.com/company/example"
  end
  
  def self.service_url_canonical
    "http://linkedin.com/company/#{account}"
  end

  private
  
  def fetch_details
    {
      :account => account,
    }
  end
end

Service.register(:linkedin, LinkedinService)

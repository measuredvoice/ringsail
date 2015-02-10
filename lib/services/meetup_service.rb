class MeetupService < Service
  def self.handles?(uri)
    uri.host =~ /meetup.com$/
  end
  
  def self.shortname
    :meetup
  end
  
  def display_name
    "#{account} on Meetup"
  end

  def account
      /\/(?<account>[\w-]+)$/ =~ @uri.path
    account
  end
  
  def self.service_url_example
    "http://www.meetup.com/example"
  end
  
  def self.service_url_canonical
    "http://meetup.com/#{account}"
  end

  private
  
  def fetch_details
    {
      :account => account,
    }
  end
end

Service.register(:meetup, MeetupService)

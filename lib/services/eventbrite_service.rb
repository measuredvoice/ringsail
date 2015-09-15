class EventbriteService < Service

  def self.handles?(uri)
    uri.host =~ /eventbrite.com/
  end

  def self.shortname
    :eventbrite
  end

  def self.longname
    "Eventbrite"
  end

  def account
     /o\/(?<account>[\w-]+)\/?/ =~ @uri.path
    account
  end

  def self.service_url_example
    "http://www.eventbrite.com/o/username"
  end

  def service_url_canonical
    "http://www.eventbrite.com/o/#{username}"
  end

  private

  def fetch_details
    {
      :account => account
    }
  end
end


Service.register(:eventbrite,EventbriteService)

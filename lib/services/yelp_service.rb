class YelpService < Service

  def self.handles?(uri)
    uri.host =~ /yelp.com/
  end

  def self.shortname
    :yelp
  end

  def self.longname
    "Yelp"
  end

  def account
    /biz\/(?<account>[\w-]+)\/?/ =~ @uri.path
    account
  end

  def self.service_url_example
    "http://www.yelp.com/biz/username"
  end

  def service_url_canonical
    "http://www.yelp.com/biz/#{username}"
  end

  private

  def fetch_details
    {
      :account => account
    }
  end
end


Service.register(:yelp,YelpService)

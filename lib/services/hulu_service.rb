class HuluService < Service

  def self.handles?(uri)
    uri.host =~ /hulu.com/
  end

  def self.shortname
    :hulu
  end

  def self.longname
    "Hulu"
  end

  def account
     /^\/(?<account>[\w-]+)\/?/ =~ @uri.path
    account
  end

  def self.service_url_example
    "http://hulu.com/username"
  end

  def service_url_canonical
    "http://Hulu.com/#{username}"
  end

  private

  def fetch_details
    {
      :account => account
    }
  end
end


Service.register(:hulu,HuluService)

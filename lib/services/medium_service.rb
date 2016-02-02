class MediumService < Service

  def self.handles?(uri)
    uri.host =~ /medium.com/
  end

  def self.shortname
    :medium
  end

  def self.longname
    "Medium"
  end

  def account
     /^\/@(?<account>[\w-]+)\/?/ =~ @uri.path
    account
  end

  def self.service_url_example
    "http://medium.com/@username"
  end

  def service_url_canonical
    "http://medium.com/@#{username}"
  end

  private

  def fetch_details
    {
      :account => account
    }
  end
end


Service.register(:medium,MediumService)

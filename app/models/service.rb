class Service
  def initialize(service_url)
    @service_url = service_url
    @uri = URI.parse(service_url)
  end

  ## class methods

  def self.register(name, subclass)
    (@services ||= {})[name] = subclass
  end
  
  def self.find_by_url(url)
    begin
      uri = URI.parse(url.downcase)
    rescue
      return nil
    end
    
    @services.each do |shortname, service|
      if service.handles?(uri)
        return service.new(url)
      end
    end
    
    return nil
  end
  
  def self.all
    sorted = @services.sort_by { |shortname, service| shortname }
    sorted.map do |shortname, service|
      service
    end
  end
  
  def self.handles?(url)
    # Each service subclass needs to identify which URLs it can handle
    false
  end

  def self.shortname
    fail "self.shortname is not defined for this service (#{self.name})"
  end
  
  def self.longname
    self.shortname.to_s.humanize
  end
  
  ## instance methods
  
  def fetch_details
    fail "fetch_details is not defined for this service"
  end
  
  def shortname
    self.class.shortname
  end
  
  def longname
    self.class.longname
  end
  
  def display_name
    "#{account} on #{longname}"
  end
  
  # If possible, override #account to return an account ID
  # without accessing any remote services.
  def account
    @details ||= fetch_details
    @details[:account]
  end
  
  def profile_name
    @details ||= fetch_details
    @details[:profile_name]
  end
  
  def profile_image
    @details ||= fetch_details
    @details[:profile_image]
  end
  
  def info_url
    @details ||= fetch_details
    @details[:info_url]
  end
  
  def location
    @details ||= fetch_details
    @details[:location]
  end
  
  def uri=(uri)
    @service_uri = uri
  end
  
  def service_url_example
    nil
  end
  
  def service_url_canonical
    # By default, return whatever the user specified.
    @service_url
  end
  
end

# Load all service definitions from lib/services/*.rb
Dir[File.join(Rails.root, 'lib', 'services', '**', '*.rb')].each do |f|
  require_dependency f
end

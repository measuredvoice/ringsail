class <%= file_name.capitalize  %>Service < Service

  def self.handles?(uri)
    uri.host =~ /<%= file_name.to_sym %>.com/
  end

  def self.shortname
    :<%= file_name.downcase %>
  end

  def self.longname
    "<%= file_name.humanize %>"
  end

  def account
     /^\/(?<account>[\w-]+)\/?/ =~ @uri.path
    account
  end

  def self.service_url_example
    "http://<%= file_name.downcase  %>.com/username"
  end

  def service_url_canonical
    "http://<%= file_name.humanize  %>.com/#{username}"
  end

  private

  def fetch_details
    {
      :account => account
    }
  end
end


Service.register(:<%= file_name.downcase %>,<%= file_name.capitalize %>Service)

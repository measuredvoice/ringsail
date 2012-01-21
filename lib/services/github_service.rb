class GithubService < Service
  def self.handles?(uri)
    uri.host =~ /github.com$/
  end
  
  def self.shortname
    :github
  end
  
  def display_name
    "#{account} on GitHub"
  end

  def account
      /\/(?<account>[\w-]+)$/ =~ @uri.path
    account
  end
  
  def service_url_example
    "http://www.github.com/USAgov"
  end
  
  def service_url_canonical
    "http://github.com/#{account}"
  end

  private
  
  def fetch_details
    {
      :account => account,
    }
  end
end

Service.register(:github, GithubService)

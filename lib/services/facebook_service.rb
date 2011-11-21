require 'hyper_graph'

class FacebookService < Service
  def self.handles?(uri)
    uri.host =~ /facebook.com$/
  end
  
  def shortname
    :facebook
  end
  
  def display_name
    if account =~ /[^\d]/
      "#{account} on Facebook"
    else
      "Facebook account ID:#{account}"
    end
  end
  
  def account
    if /pages/ =~ @uri.path
      /\/(?<account>\d+)$/ =~ @uri.path
    else
      /\/(?<account>\w+)$/ =~ @uri.path
    end
    account
  end
  
  private
  
  def fetch_details
    begin
      user = HyperGraph.get(account)
    rescue
      return {:account => account}
    end
        
    {
      :account       => account,
      :profile_name  => user[:name],
      :profile_image => user[:picture],
      :info_url      => user[:website] ? user[:website].split[0] : nil,
      :location      => pretty_location(user[:location]),
      :followers     => user[:likes],
    }
  end
  
  def pretty_location(parts={})
    return nil if parts.nil?
    
    if parts[:city]
      "#{parts[:city]}, #{parts[:state]}, #{parts[:country]}"
    elsif parts[:state]
      "#{parts[:state]}, #{parts[:country]}"
    elsif parts[:country]
      parts[:country]
    else
      nil
    end
  end
end

Service.register(:facebook, FacebookService)

# == Schema Information
#
# Table name: outlets
#
#  id           :integer(4)      not null, primary key
#  service_url  :string(255)
#  organization :string(255)
#  info_url     :string(255)
#  account      :string(255)
#  language     :string(255)
#  updated_by   :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  service_id   :integer(4)
#

class Outlet < ActiveRecord::Base
  attr_accessible :service_url, :organization, :info_url, :language, :account, :service

  has_many :sponsorships
  has_many :agencies, :through => :sponsorships
  belongs_to :service

  validates :service_url, 
    :presence   => true, 
    :format     => { :with => URI::regexp(%w(http https)) }, 
    :uniqueness => { :case_sensitive => false }
  validates :info_url,
    :format     => { :with => URI::regexp(%w(http https)), 
                     :allow_blank => true}
  
  def verified?
    # TODO:
    #  Add a more formal definition of a verified outlet
    agencies.size > 0
  end
  
  def self.resolve(url)
    # TODO: 
    #   Resolve the URL down to a service and account ID
    #   Look up existing settings for this outlet, or
    #   set up sensible defaults for the object.
    /twitter\.com\/(?<account>\w+)/ =~ url
    service_shortname = "twitter"
    service = Service.find_by_shortname(service_shortname)
    
    return nil unless service
    
    existing = self.find_by_account_and_service_id(account, service.id)
    if existing
      return existing
    else
      self.new(:service_url => url, :service => service, :account => account)
    end
  end    
end

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
#  service      :string(255)
#

class Outlet < ActiveRecord::Base
  attr_accessible :service_url, :organization, :info_url, :language, :account, :service

  has_many :sponsorships
  has_many :agencies, :through => :sponsorships

  validates :service_url, 
    :presence   => true, 
    :format     => { :with => URI::regexp(%w(http https)) }, 
    :uniqueness => { :case_sensitive => false }
  validates :info_url,
    :format     => { :with => URI::regexp(%w(http https)), 
                     :allow_blank => true}
  validates :service, 
    :presence   => true 
  validates :account, 
    :presence   => true 
  
  def verified?
    # TODO:
    #  Add a more formal definition of a verified outlet
    agencies.size > 0
  end
  
  def service_info
    @service_info ||= Service.find_by_url(service_url)
  end
  
  def self.resolve(url)
    return nil if url.nil?
    s = Service.find_by_url(url)
    
    return nil unless s
    
    existing = self.find_by_account_and_service(s.account, s.shortname)
    if existing
      return existing
    else
      self.new(:service_url => url, :service => s.shortname, :account => s.account)
    end
  end    
end

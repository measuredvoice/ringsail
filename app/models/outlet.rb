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
#

class Outlet < ActiveRecord::Base
  attr_accessor :updated_by
  attr_accessible :service_url, :organization, :info_url, :account, :language

  validates :service_url, 
    :presence   => true, 
    :format     => { :with => URI::regexp(%w(http https)) }, 
    :uniqueness => { :case_sensitive => false }

  def self.resolve(url)
    # TODO: 
    #   Resolve the URL down to a service and account ID
    #   Look up existing settings for this outlet, or
    #   set up sensible defaults for the object.
    self.new(:service_url => url)
  end
  
end

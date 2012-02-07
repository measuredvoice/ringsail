# == Schema Information
#
# Table name: agencies
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  shortname  :string(255)
#  info_url   :string(255)
#

class Agency < ActiveRecord::Base
  attr_accessible :name, :shortname, :info_url
  
  has_many :sponsorships
  has_many :outlets, :through => :sponsorships
  
  validates :name, :presence => true
  validates :shortname, :presence => true
  
  paginates_per 200

  def to_s
    self.name
  end
end

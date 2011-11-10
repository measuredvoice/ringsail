# == Schema Information
#
# Table name: agencies
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  shortname  :string(255)
#

class Agency < ActiveRecord::Base
  attr_accessible :name, :shortname
  
  has_many :sponsorships
  has_many :agencies, :through => :sponsorships
end

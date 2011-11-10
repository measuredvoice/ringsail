# == Schema Information
#
# Table name: services
#
#  id         :integer(4)      not null, primary key
#  shortname  :string(255)
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Service < ActiveRecord::Base
  attr_accessible :shortname, :name
  
  has_many :outlets

  validates :shortname, :presence => true, :uniqueness => true
  validates :name, :presence => true
end

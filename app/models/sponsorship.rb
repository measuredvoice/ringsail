# == Schema Information
#
# Table name: sponsorships
#
#  id         :integer(4)      not null, primary key
#  outlet_id  :integer(4)
#  agency_id  :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class Sponsorship < ActiveRecord::Base
  attr_accessible :agency_id, :outlet_id

  belongs_to :outlet
  belongs_to :agency

  validates :outlet_id, :presence => true
  validates :agency_id, :presence => true
end

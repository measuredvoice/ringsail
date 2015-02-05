# == Schema Information
#
# Table name: sponsorships
#
#  id         :integer          not null, primary key
#  outlet_id  :integer
#  agency_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Sponsorship < ActiveRecord::Base
  #attr_accessible :agency_id, :outlet_id

  belongs_to :outlet
  belongs_to :agency, :counter_cache => :outlets_count

  has_paper_trail 
  validates :outlet_id, :presence => true
  validates :agency_id, :presence => true
end

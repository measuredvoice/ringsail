# == Schema Information
#
# Table name: agency_contacts
#
#  id         :integer          not null, primary key
#  email      :string(255)
#  agency_id  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class AgencyContact < ActiveRecord::Base
  #attr_accessible :agency_id, :email
  
  belongs_to :agency
 
  validates :agency_id, :presence => true
  validates :email, :presence   => true, 
                    :gov_email  => true
                    
  def name
    email
  end
end

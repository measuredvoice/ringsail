class OutletRelatedPolicy < ActiveRecord::Base

  belongs_to :outlet
  belongs_to :related_policy
  
end
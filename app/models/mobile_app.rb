class MobileApp < ActiveRecord::Base
  #handles logging of activity
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  enum status: { pending: 0, active: 1, under_review: 2, archived: 3  }
  #handles versioning
  has_paper_trail
  #attr_accessible :name, :shortname, :info_url, :agency_contact_ids
  acts_as_taggable

  belongs_to :agency
  
  has_many :mobile_app_users
  has_many :users, :through => :mobile_app_users

  has_many :mobile_app_versions, :dependent => :destroy
end

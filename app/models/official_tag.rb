# == Schema Information
#
# Table name: official_tags
#
#  id         :integer          not null, primary key
#  shortname  :string(255)
#  tag_text   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class OfficialTag < ActiveRecord::Base
  # Since this is admin only, probably do not want to track
  #handles logging of activity
  # include PublicActivity::Model
  # tracked owner: Proc.new{ |controller, model| controller.current_user }

  #handles versioning
  # has_paper_trail
  #attr_accessible :shortname, :tag_text
  
  validates :tag_text, :presence => true, :uniqueness => true
 

end

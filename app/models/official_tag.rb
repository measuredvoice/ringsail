# == Schema Information
#
# Table name: official_tags
#
#  id               :integer          not null, primary key
#  tag_text         :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  gallery_count    :integer          default("0")
#  mobile_app_count :integer          default("0")
#  outlet_count     :integer          default("0")
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

  has_many :outlet_official_tags, :dependent => :destroy
  has_many :outlets, through: :outlet_official_tags
  has_paper_trail
  def tag_text=(text)
    write_attribute(:tag_text, text.downcase)
  end

end

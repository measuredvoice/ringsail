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
  #attr_accessible :shortname, :tag_text
  
  validates :tag_text, :presence => true, :uniqueness => true

  has_many :outlet_official_tags, :dependent => :destroy
  has_many :outlets, through: :outlet_official_tags

  has_many :mobile_app_official_tags, :dependent => :destroy
  has_many :mobile_apps, through: :mobile_app_official_tags

  has_many :gallery_official_tags, :dependent => :destroy
  has_many :galleries, through: :gallery_official_tags
  
  has_paper_trail
  def tag_text=(text)
    self[:tag_text] = text.downcase
  end

end

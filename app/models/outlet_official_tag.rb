# == Schema Information
#
# Table name: outlet_official_tags
#
#  id              :integer          not null, primary key
#  outlet_id       :integer
#  official_tag_id :integer
#

class OutletOfficialTag < ActiveRecord::Base
  belongs_to :outlet
  belongs_to :official_tag, counter_cache: :outlet_count
  has_paper_trail 

  after_save :update_counter_cache
  after_destroy :update_counter_cache
  
  def update_counter_cache
    self.official_tag.gallery_count = Outlet.includes(:official_tags).where(
      "official_tags.id = ? AND outlets.draft_id IS NOT NULL", self.official_tag_id)
    self.official_tag.save
  end
end

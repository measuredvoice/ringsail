# == Schema Information
#
# Table name: gallery_official_tags
#
#  id              :integer          not null, primary key
#  gallery_id      :integer
#  official_tag_id :integer
#

class GalleryOfficialTag < ActiveRecord::Base
  belongs_to :gallery
  belongs_to :official_tag

  after_save :update_counter_cache
  after_destroy :update_counter_cache

  def update_counter_cache
    self.official_tag.draft_gallery_count = self.official_tag.galleries.where(status: 1).count
    self.official_tag.published_gallery_count = self.official_tag.galleries.where(status: 1).count
    self.official_tag.save
  end
end

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
  belongs_to :official_tag, counter_cache: :gallery_count
end

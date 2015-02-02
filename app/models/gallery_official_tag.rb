class GalleryOfficialTag < ActiveRecord::Base
  belongs_to :gallery
  belongs_to :official_tag, counter_cache: :gallery_count
end

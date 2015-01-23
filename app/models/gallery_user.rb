class GalleryUser < ActiveRecord::Base
  belongs_to :gallery
  belongs_to :user
end

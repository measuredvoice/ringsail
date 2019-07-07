# == Schema Information
#
# Table name: gallery_items
#
#  id         :integer          not null, primary key
#  gallery_id :integer
#  item_id    :integer
#  item_type  :string(255)
#  item_order :integer          default(0)
#

class GalleryItem < ActiveRecord::Base
  belongs_to :gallery
  belongs_to :item, polymorphic: true

  
end

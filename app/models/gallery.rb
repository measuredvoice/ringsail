# == Schema Information
#
# Table name: galleries
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text(65535)
#

class Gallery < ActiveRecord::Base
	 #handles logging of activity
	include PublicActivity::Model
	tracked owner: Proc.new{ |controller, model| controller.current_user }

	#handles versioning
	has_paper_trail
	
	has_many :gallery_users
	has_many :users, through: :gallery_users

	has_many :gallery_official_tags
  has_many :official_tags, :through => :gallery_official_tags, counter_cache: "gallery_count"

  has_many :gallery_items, -> { order "item_order ASC"}, dependent: :destroy
  has_many :mobile_apps, :through => :gallery_items, :source => :item, :source_type => "MobileApp"
  has_many :outlets, :through => :gallery_items, :source => :item, :source_type => "Outlet"


  def gallery_items_ol=(list)
  	gallery_list = JSON.parse(list)[0]
  	ids = []
  	gallery_list.each_with_index do |item,index|
  		if ["MobileApp","Outlet"].include? item["class"]
  			if item["class"].constantize.find(item["id"])
		  		new_item =  GalleryItem.find_or_create_by({
		  			gallery_id: self.id,
		  			item_id: item["id"],
		  			item_type: item["class"]
		  		})
		  		new_item.item_order = index
		  		new_item.save!
		  		ids << item["id"]
		  	else
		  		self.errors.add(:base, "Couldn't find item to add to gallery")
		  	end
	  	else
	  		self.errors.add(:base, "A Gallery Item was of the wrong class")
	  	end
  	end
  	self.gallery_items.where('item_id NOT IN (?)', ids).destroy_all
  end
end

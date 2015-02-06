# == Schema Information
#
# Table name: galleries
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  description       :text(65535)
#  draft_id          :integer
#  short_description :text(65535)
#  long_description  :text(65535)
#  status            :integer
#

class Gallery < ActiveRecord::Base
	 #handles logging of activity
	include PublicActivity::Model
	tracked owner: Proc.new{ |controller, model| controller.current_user }

  enum status: { under_review: 0, published: 1, archived: 2 }

	#handles versioning
	has_paper_trail
	
	has_many :gallery_users, dependent: :destroy
	has_many :users, through: :gallery_users

	has_many :gallery_official_tags, dependent: :destroy
  has_many :official_tags, :through => :gallery_official_tags

  has_many :gallery_items, -> { order "item_order ASC"}, dependent: :destroy
  has_many :mobile_apps, :through => :gallery_items, :source => :item, :source_type => "MobileApp"
  has_many :outlets, :through => :gallery_items, :source => :item, :source_type => "Outlet"


  # This handles a json serialized format from the administrative end.
  # It is to allowed ordering of lists in the forms
  # Please be careful if messing with this, its senssitive
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
          # This error occurs if an invalid id is provided, generally should only be found by devs
		  		self.errors.add(:base, "Couldn't find item to add to gallery")
		  	end
	  	else
        # This error would require either a developer or something trying to do wrong to reach
	  		self.errors.add(:base, "A gallery item was of the wrong class")
	  	end
  	end
    # cleanup all records not found in the list this time. required due to way we are handling
    # data serialization
  	self.gallery_items.where('item_id NOT IN (?)', ids).destroy_all
  end

  def tag_tokens=(ids)
    self.official_tag_ids = ids.split(',')
  end
end

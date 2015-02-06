class AddPolymorphicGalleryItems < ActiveRecord::Migration
  def change
    create_table :gallery_items do |t|
      t.integer :gallery_id
      t.integer :item_id
      t.string  :item_type
      t.integer :item_order, default: 0
    end
  end
end

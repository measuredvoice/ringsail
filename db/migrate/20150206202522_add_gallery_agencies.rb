class AddGalleryAgencies < ActiveRecord::Migration
  def change

    create_table :gallery_agencies do |t|
      t.integer :gallery_id
      t.integer :agency_id
    end

    add_column :agencies, :draft_gallery_count, :integer, default: 0
    add_column :agencies, :published_gallery_count, :integer, default: 0
  end

end

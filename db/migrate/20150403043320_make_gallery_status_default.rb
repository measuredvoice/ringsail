class MakeGalleryStatusDefault < ActiveRecord::Migration
  def change
    change_column :galleries, :status, :integer, default: 0
  end
end

class AddStatusToSocialMedia < ActiveRecord::Migration
  def change
  		add_column :outlets, :status, :integer, default: 0
      add_column :tags, :taggings_count, :integer
  end
end

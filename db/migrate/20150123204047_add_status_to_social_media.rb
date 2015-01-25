class AddStatusToSocialMedia < ActiveRecord::Migration
  def change
  		add_column :outlets, :status, :integer, default: 0
  end
end

class AddAgencyFields < ActiveRecord::Migration
  def change
    add_column :agencies, :api_id, :integer
  end
end

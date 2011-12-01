class AddInfoUrlToAgencies < ActiveRecord::Migration
  def change
    add_column :agencies, :info_url, :string
  end
end

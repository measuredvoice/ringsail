class AddPublishedVersionToDataSets < ActiveRecord::Migration
  def change
    add_column :outlets, :draft_id, :integer
    add_column :outlets, :short_description, :text
    add_column :outlets, :long_description, :text
    remove_column :outlets, :updated_by, :string
  end
end

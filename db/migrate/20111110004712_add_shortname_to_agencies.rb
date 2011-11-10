class AddShortnameToAgencies < ActiveRecord::Migration
  def change
    add_column :agencies, :shortname, :string
    add_index :agencies, :shortname, :unique => true
  end
end

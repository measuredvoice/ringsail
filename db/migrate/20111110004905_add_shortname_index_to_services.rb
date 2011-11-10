class AddShortnameIndexToServices < ActiveRecord::Migration
  def change
    add_index :services, :shortname, :unique => true
  end
end

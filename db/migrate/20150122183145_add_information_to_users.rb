class AddInformationToUsers < ActiveRecord::Migration
  def self.up
    remove_index :users, :email
  	add_column :users, :agency_id, :integer
  	add_column :users, :phone, :string
  	add_column :users, :first_name, :string
  	add_column :users, :last_name, :string
  	add_column :users, :groups, :text
    add_column :users, :role, :integer, default: 0
  end

  def self.down
    remove_column :users, :role, :integer
  	remove_column :users, :agency_id, :integer
  	remove_column :users, :phone, :string
  	remove_column :users, :first_name, :string
  	remove_column :users, :last_name, :string
  	remove_column :users, :phone, :string
  	remove_column :users, :groups, :text
  end
end

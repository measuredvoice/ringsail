class AddInformationToUsers < ActiveRecord::Migration
  def self.up
    remove_index :users, :email
  	add_column :users, :agency_id, :integer
  	add_column :users, :phone, :string
  	add_column :users, :first_name, :string
  	add_column :users, :last_name, :string
  	add_column :users, :groups, :text
    add_column :users, :role, :integer, default: 0
    add_column :users, :agency_notifications, :boolean, default: false
    add_column :users, :agency_notifications_emails, :boolean, default: false
    add_column :users, :contact_notifications, :boolean, default: true
    add_column :users, :contact_notifications_emails, :boolean, default: true
    add_column :users, :email_notification_type, :integer, default: 0

    create_table :notifications do |t|
      t.integer :user_id
      t.integer :item_id
      t.string :item_type
      t.string :message
      t.string :message_type
      t.string :notification_type
      t.boolean :has_read, default: false
      t.timestamps
    end
  end

  def self.down
    remove_column :users, :role, :integer
  	remove_column :users, :agency_id, :integer
  	remove_column :users, :phone, :string
  	remove_column :users, :first_name, :string
  	remove_column :users, :last_name, :string
  	remove_column :users, :phone, :string
  	remove_column :users, :groups, :text
    remove_column :users, :agency_notifications, :boolean
    remove_column :users, :contact_notifications, :boolean
    drop_table :notifications
  end
end

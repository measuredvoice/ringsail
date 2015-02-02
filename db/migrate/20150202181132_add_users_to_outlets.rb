class AddUsersToOutlets < ActiveRecord::Migration
  def change
    create_table :outlet_users do |t|
      t.integer :outlet_id
      t.integer :user_id
    end
  end
end

class CreateAuthTokens < ActiveRecord::Migration
  def change
    create_table :auth_tokens do |t|
      t.string :token
      t.string :email
      t.string :phone
      t.boolean :admin
      t.integer :access_count

      t.timestamps
    end
    add_index :auth_tokens, :token, :unique => true
    add_index :auth_tokens, :email
  end
end

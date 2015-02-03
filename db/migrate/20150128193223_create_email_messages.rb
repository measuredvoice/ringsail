class CreateEmailMessages < ActiveRecord::Migration
  def change
    create_table :email_messages do |t|
      t.integer :user_id
      t.string :to
      t.string :subject
      t.text :body

      t.timestamps
    end
  end
end

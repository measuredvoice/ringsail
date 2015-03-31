class ChangeToTypeInEmailMessages < ActiveRecord::Migration
  def change
  	change_column :email_messages, :to,  :text
  end
end

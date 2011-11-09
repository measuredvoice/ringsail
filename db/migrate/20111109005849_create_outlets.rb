class CreateOutlets < ActiveRecord::Migration
  def change
    create_table :outlets do |t|
      t.string :service_url
      t.string :organization
      t.string :info_url
      t.string :account
      t.string :language
      t.string :updated_by

      t.timestamps
    end
    
    add_index :outlets, :account
  end
end

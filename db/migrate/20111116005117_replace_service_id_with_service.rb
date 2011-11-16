class ReplaceServiceIdWithService < ActiveRecord::Migration
  def up
    change_table :outlets do |t|
      t.remove :service_id
      t.string :service
      t.index [:service, :account]
    end
  end

  def down
    change_table :outlets do |t|
      t.integer :service_id
      t.remove  :service
      t.index [:service_id, :account]
    end
  end
end

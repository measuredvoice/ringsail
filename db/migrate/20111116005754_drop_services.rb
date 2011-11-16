class DropServices < ActiveRecord::Migration
  def up
    drop_table :services
  end

  def down
    create_table :services do |t|
      t.string :shortname
      t.string :name

      t.timestamps
    end
  end
end

class CreateOfficialTags < ActiveRecord::Migration
  def change
    create_table :official_tags do |t|
      t.string :shortname
      t.string :tag_text

      t.timestamps
    end
    add_index :official_tags, :shortname, :unique => true
  end
end

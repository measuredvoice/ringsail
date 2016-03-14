class CreateAdminServices < ActiveRecord::Migration
  def change
    create_table :admin_services do |t|
      t.string :handles_regex_eval
      t.string :shortname
      t.string :longname
      t.string :display_name_eval
      t.text :account_matchers_eval
      t.string :service_url_example
      t.string :service_url_canonical_eval
      t.boolean :archived, default: false

      t.timestamps null: false
    end
  end
end

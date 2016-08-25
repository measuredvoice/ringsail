class AddRelatedPolicies < ActiveRecord::Migration
  def change
    create_table :outlet_related_policies do |t|
      t.integer :outlet_id
      t.integer :related_policy_id
      t.timestamps null: false
    end

    create_table :related_policies do|t|
      t.boolean :service_wide
      t.string :service
      t.string :title
      t.string :url
      t.string :description
      t.timestamps null: false
    end
  end
end

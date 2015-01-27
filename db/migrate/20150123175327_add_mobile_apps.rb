class AddMobileApps < ActiveRecord::Migration
  def change

  	create_table :mobile_apps do |t|
      	t.string :name
      	t.string :short_description
      	t.text :long_description
      	t.string :icon_url
      	t.string :language

      	t.integer :agency_id
      	t.integer :status, default: 0  #will use an enum, as its supported as of rails 4 enum status: { pending: 0, active: 0, archived: 1 }
  	
      	t.string :mongo_id
  	end

  	create_table :mobile_app_users do |t|
  		t.integer :mobile_app_id
  		t.integer :user_id
  	end

  	create_table :mobile_app_versions do |t|
  		t.integer :mobile_app_id
  		t.string :store_url
  		t.string :platform
  		t.string :version_number
  		t.datetime :publish_date
  		t.text :description
  		t.text :whats_new
  		t.text :screenshot #url list in text
  		t.string :device
  		t.string :language
  		t.string :average_rating #could be somethign like stars or whatever is applicable
  		t.integer :number_of_ratings
      t.string :mongo_id
  	end

  	create_table :galleries do |t|
  		t.string :name
  		t.text :description
  	end

  	create_table :mobile_app_galleries do |t|
  		t.integer :gallery_id
  		t.integer :mobile_app_id
  	end

  	create_table :gallery_users do |t|
  		t.integer :gallery_id
  		t.integer :user_id
  	end
  end
end

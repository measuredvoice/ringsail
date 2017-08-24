class TwitterStats < ActiveRecord::Migration
  def change

    add_column :outlets, :twitter_followers, :integer
    add_column :outlets, :twitter_posts, :integer
    add_column :outlets, :twitter_interactions, :integer
    
    add_column :outlets, :facebook_followers, :integer
    add_column :outlets, :facebook_likes, :integer
    add_column :outlets, :facebook_posts, :integer
    add_column :outlets, :facebook_interactions, :integer
  end
end

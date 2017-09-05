class YoutubeInstagram < ActiveRecord::Migration
  def change
    add_column :outlets, :youtube_subscribers, :integer
    add_column :outlets, :youtube_view_count, :integer
    add_column :outlets, :youtube_comment_count, :integer
    add_column :outlets, :youtube_video_count, :integer
    
    add_column :outlets, :instagram_followers, :integer
    add_column :outlets, :instagram_posts, :integer
  end
end

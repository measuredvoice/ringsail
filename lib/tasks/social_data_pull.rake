namespace :social_data_pull do

  desc 'Update Twitter Account Followers'
  task :get_twitter_data => :environment do
    PublicActivity.enabled = false
    Outlet.where(service: "twitter").where("draft_id IS NOT NULL").each do |outlet|
      account_data = TWITTER_CLIENT.user(outlet.account)
      outlet.twitter_followers = account_data.followers_count
      outlet.twitter_posts = account_data.statuses_count
      outlet.save(validate:false)
      sleep 70
    end
  end 
end
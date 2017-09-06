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


  desc 'update all on triggers' 
  task :update_all => :environment do
    PublicActivity.enabled = false
    Outlet.where("draft_id IS NOT NULL").find_in_batches(batch_size: 10) do | group|
      group.each{|out|
        out.save(validate:false)
        sleep 1
      }
    puts "Finished a Batch"
    end
  end
end
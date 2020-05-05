# == Schema Information
#
# Table name: outlets
#
#  id                    :integer          not null, primary key
#  service_url           :string(255)
#  organization          :string(255)
#  account               :string(255)
#  language              :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#  service               :string(255)
#  status                :integer          default("under_review")
#  short_description     :text(16777215)
#  long_description      :text(16777215)
#  twitter_followers     :integer
#  twitter_posts         :integer
#  twitter_interactions  :integer
#  facebook_followers    :integer
#  facebook_likes        :integer
#  facebook_posts        :integer
#  facebook_interactions :integer
#  youtube_subscribers   :integer
#  youtube_view_count    :integer
#  youtube_comment_count :integer
#  youtube_video_count   :integer
#  instagram_followers   :integer
#  instagram_posts       :integer
#  access_token          :string(255)
#  validated_at          :datetime
#  primary_contact_id    :integer
#  secondary_contact_id  :integer
#  primary_agency_id     :integer
#  secondary_agency_id   :integer
#  notes                 :text(65535)
#

FactoryGirl.define do
  factory :outlet do
    account Faker::Internet.user_name
    organization Faker::Company.name
    language Faker::Lorem.word #May want to pull language out to a table, but also probably unnecessary
    short_description Faker::Lorem.sentence
    long_description Faker::Lorem.paragraph
    # these all represent attributes that can be picked

    # these get overidden if a better one is set
    service "twitter"
    service_url "http://twitter.com/username"
    transient do 
      agencies_count 3
      contacts_count 3
      tags_count 3
      status 0
    end

    agencies { create_list(:agency, 1) }
    users { create_list(:user,1 ) }

    after(:create) do |outlet, evaluator|
      agencies_count = evaluator.agencies_count.to_i - 1
      contacts_count = evaluator.contacts_count.to_i - 1
      outlet.agencies << create_list(:agency, agencies_count)
      outlet.users << create_list(:user, contacts_count )
      outlet.official_tags << create_list(:official_tag, evaluator.tags_count)
      outlet.status = evaluator.status
    end
  end


end

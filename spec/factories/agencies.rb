# == Schema Information
#
# Table name: agencies
#
#  id                         :integer          not null, primary key
#  name                       :string(255)
#  created_at                 :datetime
#  updated_at                 :datetime
#  shortname                  :string(255)
#  info_url                   :string(255)
#  mongo_id                   :string(255)
#  parent_mongo_id            :string(255)
#  parent_id                  :integer
#  draft_outlet_count         :integer          default(0)
#  draft_mobile_app_count     :integer          default(0)
#  published_outlet_count     :integer          default(0)
#  published_mobile_app_count :integer          default(0)
#  draft_gallery_count        :integer          default(0)
#  published_gallery_count    :integer          default(0)
#  api_id                     :integer
#  omb_name                   :string(255)
#  stats_enabled              :boolean
#

FactoryGirl.define do
  factory :agency do 
    name Faker::Company.name
    shortname Faker::Company.suffix
    info_url Faker::Internet.url
  end
end

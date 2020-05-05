# == Schema Information
#
# Table name: mobile_app_versions
#
#  id                :integer          not null, primary key
#  mobile_app_id     :integer
#  store_url         :text(16777215)
#  platform          :string(255)
#  version_number    :string(255)
#  publish_date      :datetime
#  description       :text(16777215)
#  whats_new         :text(16777215)
#  screenshot        :text(16777215)
#  device            :string(255)
#  language          :string(255)
#  average_rating    :string(255)
#  number_of_ratings :integer
#  mongo_id          :string(255)
#

FactoryGirl.define do
  factory :mobile_app_version do 
    store_url Faker::Internet.url
    platform ["iOS", "Android", "Blackberry", "Web App"].sample
    version_number Faker::App.version 
    publish_date Faker::Date.between(2.days.ago, Date.today)
    description Faker::Lorem.paragraph
    whats_new Faker::Lorem.paragraph
    screenshot Faker::Internet.url
    device Faker::Hacker.abbreviation
    language ["English", "Spanish"]
    average_rating 5
    number_of_ratings 50
  end
end

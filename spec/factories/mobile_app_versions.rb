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

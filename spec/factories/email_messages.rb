FactoryGirl.define do
  factory :email_message do |e|
    e.sequence(:to) { |n| "send_to_#{n}@gsa.gov" }
    e.sequence(:from) { |n| "send_from_#{n}@gsa.gov" }
    e.body "This is an email body"
  end
end
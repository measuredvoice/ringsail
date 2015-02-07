# == Schema Information
#
# Table name: email_messages
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  to         :string(255)
#  subject    :string(255)
#  body       :text(65535)
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :email_message do |e|
    e.sequence(:to) { |n| "send_to_#{n}@gsa.gov" }
    e.sequence(:from) { |n| "send_from_#{n}@gsa.gov" }
    e.body "This is an email body"
  end
end

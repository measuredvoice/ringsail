# == Schema Information
#
# Table name: email_messages
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  to         :text(65535)
#  subject    :string(255)
#  body       :text(65535)
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :email_message do 
    sequence(:to) { |n| "send_to_#{n}@gsa.gov" }
    sequence(:subject) {|n| "Subject #{n}:"}
    body "This is an email body"
  end
end

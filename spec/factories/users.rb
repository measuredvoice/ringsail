# == Schema Information
#
# Table name: users
#
#  id                           :integer          not null, primary key
#  email                        :string(255)
#  remember_created_at          :datetime
#  sign_in_count                :integer
#  current_sign_in_at           :datetime
#  last_sign_in_at              :datetime
#  current_sign_in_ip           :string(255)
#  last_sign_in_ip              :string(255)
#  created_at                   :datetime
#  updated_at                   :datetime
#  user                         :string(255)      not null
#  agency_id                    :integer
#  phone                        :string(255)
#  first_name                   :string(255)
#  last_name                    :string(255)
#  groups                       :text(65535)
#  role                         :integer          default("0")
#  agency_notifications         :boolean          default("0")
#  agency_notifications_emails  :boolean          default("0")
#  contact_notifications        :boolean          default("1")
#  contact_notifications_emails :boolean          default("1")
#  email_notification_type      :integer          default("0")
#

FactoryGirl.define do
  factory :user, aliases: [:limited_user] do 
    email Faker::Internet.email
    user Faker::Internet.user_name
    phone Faker::PhoneNumber.phone_number
    first_name Faker::Name.first_name
    last_name Faker::Name.first_name
    groups "#{Faker::Company.name},#{Faker::Company.name},#{Faker::Company.name}"
    role User.roles[:limited_user]
    association :agency, factory: :agency
  end

  factory :full_user, parent: :user do
    role User.roles[:full_user]
  end

  factory :admin_user, parent: :user do
    role User.roles[:admin]
  end

  factory :banned_user, parent: :user do
    role User.roles[:banned]
  end
end

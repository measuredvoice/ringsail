# == Schema Information
#
# Table name: users
#
#  id                           :integer          not null, primary key
#  email                        :string(255)      default(""), not null
#  remember_created_at          :datetime
#  sign_in_count                :integer          default(0)
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
#  groups                       :text(16777215)
#  role                         :integer          default("user")
#  agency_notifications         :boolean          default(FALSE)
#  agency_notifications_emails  :boolean          default(FALSE)
#  contact_notifications        :boolean          default(TRUE)
#  contact_notifications_emails :boolean          default(TRUE)
#  email_notification_type      :integer          default("full_html_email")
#

FactoryGirl.define do
  factory :user do 
    email Faker::Internet.email
    user Faker::Internet.user_name
    phone Faker::PhoneNumber.phone_number
    first_name Faker::Name.first_name
    last_name Faker::Name.first_name
    groups "#{Faker::Company.name},#{Faker::Company.name},#{Faker::Company.name}"
    role User.roles[:user]
    association :agency, factory: :agency
  end

  factory :super_user, parent: :user do
    role User.roles[:super_user]
  end

  factory :admin_user, parent: :user do
    role User.roles[:admin]
  end

  factory :banned_user, parent: :user do
    role User.roles[:banned]
  end
end

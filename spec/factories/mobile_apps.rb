# == Schema Information
#
# Table name: mobile_apps
#
#  id                   :integer          not null, primary key
#  name                 :text(16777215)
#  short_description    :text(16777215)
#  long_description     :text(16777215)
#  icon_url             :text(16777215)
#  language             :string(255)
#  agency_id            :integer
#  status               :integer          default("under_review")
#  mongo_id             :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  validated_at         :datetime
#  primary_contact_id   :integer
#  secondary_contact_id :integer
#  primary_agency_id    :integer
#  secondary_agency_id  :integer
#  notes                :text(65535)
#

FactoryGirl.define do
  factory :mobile_app do 
    name Faker::Lorem.word
    language Faker::Lorem.word
    short_description Faker::Lorem.sentence
    long_description Faker::Lorem.paragraph

    transient do
    	agencies_count 3
    	contacts_count 3
    	status 0
    end

    agencies {create_list(:agency, 1)}
    users {create_list(:user, 1)}
    mobile_app_versions { create_list(:mobile_app_version,1)}

	after(:create) do |mobile_app, evaluator|
		agencies_count = evaluator.agencies_count.to_i - 1 
		contacts_count = evaluator.contacts_count.to_i - 1
    	mobile_app.agencies << create_list(:agency, agencies_count)
		mobile_app.users << create_list(:user, contacts_count)
		mobile_app.status = evaluator.status
	end
  end
end

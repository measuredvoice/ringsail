# == Schema Information
#
# Table name: mobile_apps
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  short_description :text(65535)
#  long_description  :text(65535)
#  icon_url          :string(255)
#  language          :string(255)
#  agency_id         :integer
#  status            :integer          default("0")
#  mongo_id          :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  draft_id          :integer
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

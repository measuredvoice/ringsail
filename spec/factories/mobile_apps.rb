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

	after(:create) do |mobile_app, evaluator|
		agencies_count = evaluator.agencies_count.to_i - 1 
		contacts_count = evaluator.contacts_count.to_i - 1
    	mobile_app.agencies << create_list(:agency, agencies_count)
		mobile_app.users << create_list(:user, contacts_count)
		mobile_app.status = evaluator.status
	end
  end
end

FactoryGirl.define do
  factory :gallery do
    name Faker::Lorem.word
	short_description Faker::Lorem.sentence
	long_description Faker::Lorem.paragraph

	transient do
		agencies_count 3
		contacts_count 3
	end

	agencies {create_list(:agency, 1)}
	users {create_list(:user, 1)}

	after(:create) do |gallery, evaluator|
		agencies_count = evaluator.agencies.count.to_i - 1
		contacts_count = evaluator.contacts_count.to_i - 1
		gallery.agencies << create_list(:agency, agencies_count)
		gallery.users << create_list(:user, contacts_count)
	end
  end
end

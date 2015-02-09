PublicActivity.enabled = false
DatabaseCleaner.clean

AGENCIES_NUM = 5
USERS_NUM = 5 #users will always make a minimum of 4 (one for each role)
TAGS_NUM = 5
OUTLETS_NUM = 5
APPS_NUM = 5

puts "Adding agencies with count of #{AGENCIES_NUM}"
(1..AGENCIES_NUM).each do |agency_number|
	Agency.create!({
		name: Faker::Company.name,
		shortname: "#{Faker::Company.suffix} #{agency_number}"
	})
end
puts "Finished addingagencies with count of #{AGENCIES_NUM}"

puts "Create users with each role"
User.roles.each do |role|
	User.create!({
		email: Faker::Internet.email,
		sign_in_count: rand(1..100),
		user: Faker::Internet.user_name,
		agency_id: rand(1..AGENCIES_NUM),
		phone: Faker::PhoneNumber.phone_number,
		first_name: Faker::Name.first_name,
		last_name: Faker::Name.last_name,
		role: role[1]
	})
end
puts "Finished with users for roles"
user_count = User.all.count
if user_count < USERS_NUM
	puts "Adding additional users to reach count of #{USERS_NUM}"
	(user_count..USERS_NUM).each do |user_number|
		role = User.roles.values.sample
		User.create!({
			email: Faker::Internet.email,
			sign_in_count: rand(1..100),
			user: Faker::Internet.user_name,
			agency_id: rand(1..AGENCIES_NUM),
			phone: Faker::PhoneNumber.phone_number,
			first_name: Faker::Name.first_name,
			last_name: Faker::Name.last_name,
			role: role
		})
	end
	puts "Finished adding additional users to reach count of #{USERS_NUM}"
end

(1..TAGS_NUM).each do |tag_number|
	OfficialTag.create!({
		tag_text: "#{Faker::Lorem.word} #{tag_number}"
	})
end

(1..OUTLETS_NUM).each do |outlet_number|
	random_service = Service.all.sample
	language = ["English","Spanish"].sample
	status = Outlet.statuses.values.sample
	Outlet.create!({
		service: random_service.shortname,
		service_url: random_service.service_url_example,
		info_url: Faker::Internet.url,
		account: Faker::Internet.user_name,
		short_description: Faker::Lorem.sentence,
		long_description: Faker::Lorem.paragraph,
		language: language,
		status: status,
		agency_ids: [Agency.offset(rand(Agency.count)).first],
		official_tags: [OfficialTag.offset(rand(OfficialTag.count)).first],
		users: [User.offset(rand(User.count)).first]
	})
end


(1..APPS_NUM).each do |app_number|
	language = ["English","Spanish"].sample
	status = MobileApp.statuses.values.sample
	MobileApp.create!({
		name: Faker::App.name,
		short_description: Faker::Lorem.sentence,
		long_description: Faker::Lorem.paragraph,
		icon_url: Faker::Company.logo,
		language: language,
		status: status,
		agencies: [Agency.offset(rand(Agency.count)).first],
		official_tags: [OfficialTag.offset(rand(OfficialTag.count)).first],
		users: [User.offset(rand(User.count)).first]
	})
end




PublicActivity.enabled = false
DatabaseCleaner.clean_with :truncation

AGENCIES_NUM = 3
USERS_NUM = 5 #users will always make a minimum of 4 (one for each role)
TAGS_NUM = 6
OUTLETS_NUM = 40
APPS_NUM = 40

puts "Adding agencies with count of #{AGENCIES_NUM}"
agencie_names = ["Department of Mysteries", 
	"Department of Magical Accidents and Catastrophes",
	"Department of Magical Transportation"]
(1..AGENCIES_NUM).each do |agency_number|
	name = "Department of #{Faker::Commerce.department(2, true)}"
	Agency.create!({
		name: agencie_names[agency_number-1] ,
		shortname: agencie_names[agency_number-1].split(" ").map{|w| w[0,1].capitalize }.join.gsub!(/\W+/, ''),
		info_url: Faker::Internet.url
	})
end
puts "Finished adding agencies with count of #{AGENCIES_NUM}"

puts "Create users with each role"
User.roles.each do |role|
	User.create!({
		email: Faker::Internet.email,
		sign_in_count: rand(1..100),
		user: Faker::Internet.user_name,
		agency: Agency.offset(rand(Agency.count)).first,
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
			agency: Agency.offset(rand(Agency.count)).first,
			phone: Faker::PhoneNumber.phone_number,
			first_name: Faker::Name.first_name,
			last_name: Faker::Name.last_name,
			role: role
		})
	end
	puts "Finished adding additional users to reach count of #{USERS_NUM}"
end

puts "Adding tags to get to #{TAGS_NUM}"
tag_names = [
 "Health & Fitness", "Education", "Travel", "Reference", "Recreation","Scientific"
 ]
(1..TAGS_NUM).each do |tag_number|
	OfficialTag.create!({
		tag_text: tag_names[tag_number-1]
	})
end
puts "Finished tags to get to #{TAGS_NUM}"

puts "Adding outlets to get to #{OUTLETS_NUM}"
(1..OUTLETS_NUM).each do |outlet_number|
	random_service = Service.all.sample
	language = ["English","Spanish"].sample
	status = Outlet.statuses.values.sample
	out = Outlet.create!({
		service: random_service.shortname,
		service_url: random_service.service_url_example,
		account: Faker::Internet.user_name,
		organization: Faker::Internet.user_name,
		short_description: Faker::Lorem.sentence,
		long_description: Faker::Lorem.paragraph,
		language: language,
		status: status,
		agencies: [Agency.offset(rand(Agency.count)).first],
		official_tags: [OfficialTag.offset(rand(OfficialTag.count)).first],
		users: [User.offset(rand(User.count)).first]
	})
	if out.published?
		out.published!
	end
end
puts "Finished Adding Outlets to get to #{OUTLETS_NUM}"


puts "Adding mobile apps to get to #{APPS_NUM}"
(1..APPS_NUM).each do |app_number|
	language = ["English","Spanish"].sample
	status = MobileApp.statuses.values.sample
	ma = MobileApp.create({
		name: Faker::App.name,
		short_description: Faker::Lorem.sentence,
		long_description: Faker::Lorem.paragraph,
		icon_url: Faker::Company.logo,
		language: language,
		status: status,
		agencies: [Agency.offset(rand(Agency.count)).first],
		official_tags: [OfficialTag.offset(rand(OfficialTag.count)).first],
		users: [User.offset(rand(User.count)).first],
	})
	ma.mobile_app_versions << MobileAppVersion.create({
		store_url: Faker::Internet.url,
		platform: ["iOS","Android","Web App", "Blackberry"].sample,
		version_number: "v1",
		publish_date: DateTime.current,
		description: Faker::Lorem.paragraph,
		whats_new: Faker::Lorem.paragraph,
		screenshot: Faker::Company.logo,
		device: Faker::Hacker.abbreviation,
		language: language,
		average_rating: "5",
		number_of_ratings: 50
	})
	if ma.published?
		ma.published!
	end
	ma.save
end
puts "Finished adding mobile apps to get to #{APPS_NUM}"



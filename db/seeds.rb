PublicActivity.enabled = false
Agency.destroy_all
User.destroy_all
Outlet.destroy_all
OfficialTag.destroy_all
Gallery.destroy_all
MobileApp.destroy_all

Agency.create!([
	{
	name: "Agency of Oops We Did It Again",
	shortname: "AOWDIA"
	},
	{
	name: "Administration of It Happens",
	shortname: "AOIH"
	},
	{
	name: "National Zombie Population Control",
	shortname: "NZPC"	
	}
	])

User.create!([
	{
	email: "tonymontana@email.com",
	sign_in_count: "100",
	user: "scarface",
	agency_id: Agency.second.id,
	phone: "1111111111",
	first_name: "Tony",
	last_name: "Montana"
	},
	{
	email: "brucewayne@email.com",
	sign_in_count: "10",
	user: "Batman",
	agency_id: Agency.first.id,
	phone: "2222222222",
	first_name: "Bruce",
	last_name: "Wayne"
	},
	{
	email: "harveyspector@email.com",
	sign_in_count: "20",
	user: "Harvey",
	agency_id: Agency.third.id,
	phone: "3333333333",
	first_name: "Harvey",
	last_name: "Spector"
	},
	{
	email: "mikeross@email.com",
	sign_in_count: "2",
	user: "Mike",
	agency_id: Agency.second.id,
	phone: "5555555555",
	first_name: "Bruce",
	last_name: "Wayne"
	},
	{
	email: "frankunderwood@email.com",
	sign_in_count: "1",
	user: "Frank",
	agency_id: Agency.first.id,
	phone: "1234567890",
	first_name: "Frank",
	last_name: "Underwood"
	}
	])

Outlet.create!([
	{
	service_url: "http://facebook.com/raddit",
	organization: "Raddit Org",
	info_url: "http://raddit.gov",
	account: "raddit",
	language: "English",
	service: "facebook"
	},
	{
	service_url: "http://facebook.com/foo",
	organization: "Foo Org",
	info_url: "http://foo.gov",
	account: "foo",
	language: "English",
	service: "facebook"
	}
	])

OfficialTag.create!([
	{
	tag_text: "stayhome",
	gallery_count: "0",
	mobile_app_count: "0",
	outlet_count: "0"
	},
	{
	tag_text: "commute",
	gallery_count: "0",
	mobile_app_count: "0",
	outlet_count: "0"
	}
	])






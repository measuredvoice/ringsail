FactoryGirl.define do
  sequence :gov_email do |n|
    "valid#{n}@example.gov"
  end
  
  sequence :nongov_email do |n|
    "invalid#{n}@example.com"
  end
  
  sequence :shortname  do |n|
    "examples#{n}"
  end
  
  sequence :account do |n|
    "example#{n}"
  end
  
  factory :auth_token do
    email { generate(:gov_email) }
    phone "555-1212"
    
    factory :auth_token_ld do
      duration 'long'
    end
  end
  
  factory :agency do
    name      "Department of Examples"
    shortname
  end
  
  factory :sponsorship do
    outlet
    agency
  end

  factory :outlet do
    service     :twitter
    account
    service_url {"http://twitter.com/#{account}"}
    language    "English"
    auth_token  { create(:auth_token).token }
    
    # Remember to add an agency using outlet.agencies << FG.create(:agency)
  end
end

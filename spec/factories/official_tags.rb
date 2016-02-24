# == Schema Information
#
# Table name: official_tags
#
#  id                         :integer          not null, primary key
#  tag_text                   :string(255)
#  created_at                 :datetime
#  updated_at                 :datetime
#  draft_gallery_count        :integer          default(0)
#  draft_mobile_app_count     :integer          default(0)
#  draft_outlet_count         :integer          default(0)
#  published_gallery_count    :integer          default(0)
#  published_mobile_app_count :integer          default(0)
#  published_outlet_count     :integer          default(0)
#  tag_type                   :integer          default(0)
#

FactoryGirl.define do
  factory :official_tag do 
    sequence(:tag_text) {|n| "#{Faker::Lorem.word}-#{n}"} #ensure uniqueness, create a seperate generator to test this validation
  end
end


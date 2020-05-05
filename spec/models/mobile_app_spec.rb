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

require 'rails_helper'

RSpec.describe MobileApp, type: :model do 
	it { should have_many(:gallery_items) }
	it { should have_many(:mobile_app_agencies) }
	it { should have_many(:agencies) }
	it { should have_many(:mobile_app_users) }
	it { should have_many(:users) }
	it { should have_many(:mobile_app_versions) }
	it { should have_many(:mobile_app_official_tags) }
	it { should have_many(:official_tags) }
	# it { is_expected.to validate_presence_of :name }
end

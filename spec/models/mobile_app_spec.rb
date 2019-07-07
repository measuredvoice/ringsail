# == Schema Information
#
# Table name: mobile_apps
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  short_description :text(65535)
#  long_description  :text(65535)
#  icon_url          :text(65535)
#  language          :string(255)
#  agency_id         :integer
#  status            :integer          default(0)
#  mongo_id          :string(255)
#  created_at        :datetime
#  updated_at        :datetime
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

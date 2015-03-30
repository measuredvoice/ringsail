# == Schema Information
#
# Table name: agencies
#
#  id                         :integer          not null, primary key
#  name                       :string(255)
#  created_at                 :datetime
#  updated_at                 :datetime
#  shortname                  :string(255)
#  info_url                   :string(255)
#  mongo_id                   :string(255)
#  parent_mongo_id            :string(255)
#  parent_id                  :integer
#  draft_outlet_count         :integer          default("0")
#  draft_mobile_app_count     :integer          default("0")
#  published_outlet_count     :integer          default("0")
#  published_mobile_app_count :integer          default("0")
#  draft_gallery_count        :integer          default("0")
#  published_gallery_count    :integer          default("0")
#

require 'rails_helper'

RSpec.describe Agency, type: :model do
	it { is_expected.to validate_presence_of :name }
	it { should have_many(:mobile_app_agencies) }
	it { should have_many(:mobile_apps) }
	it { should have_many(:gallery_agencies) }
	it { should have_many(:galleries) }
	it { should have_many(:users) }
	it { should belong_to(:parent)}
	it { should have_many(:children)}

end

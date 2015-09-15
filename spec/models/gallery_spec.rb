# == Schema Information
#
# Table name: galleries
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  draft_id          :integer
#  short_description :text(65535)
#  long_description  :text(65535)
#  status            :integer          default("0")
#

require 'rails_helper'

RSpec.describe Gallery, type: :model do
	it { should validate_presence_of(:name) }

	it { should have_many(:gallery_users) }
	it { should have_many(:users)}
	it { should have_many(:gallery_official_tags) }
	it { should have_many(:official_tags) }
	it { should have_many(:gallery_items) }
	it { should have_one(:published) }
	it { should have_many(:outlets) }

end

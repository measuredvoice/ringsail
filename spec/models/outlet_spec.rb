# == Schema Information
#
# Table name: outlets
#
#  id                    :integer          not null, primary key
#  service_url           :string(255)
#  organization          :string(255)
#  account               :string(255)
#  language              :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#  service               :string(255)
#  status                :integer          default("under_review")
#  short_description     :text(16777215)
#  long_description      :text(16777215)
#  twitter_followers     :integer
#  twitter_posts         :integer
#  twitter_interactions  :integer
#  facebook_followers    :integer
#  facebook_likes        :integer
#  facebook_posts        :integer
#  facebook_interactions :integer
#  youtube_subscribers   :integer
#  youtube_view_count    :integer
#  youtube_comment_count :integer
#  youtube_video_count   :integer
#  instagram_followers   :integer
#  instagram_posts       :integer
#  access_token          :string(255)
#  validated_at          :datetime
#  primary_contact_id    :integer
#  secondary_contact_id  :integer
#  primary_agency_id     :integer
#  secondary_agency_id   :integer
#  notes                 :text(65535)
#

require 'rails_helper'

RSpec.describe Outlet, type: :model do
  it "should pass validations" do
    outlet = FactoryGirl.create(:outlet)
    expect(outlet.valid?).to eq(true)
  end

end

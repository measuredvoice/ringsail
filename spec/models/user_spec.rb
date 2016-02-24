# == Schema Information
#
# Table name: users
#
#  id                           :integer          not null, primary key
#  email                        :string(255)      default(""), not null
#  remember_created_at          :datetime
#  sign_in_count                :integer          default(0)
#  current_sign_in_at           :datetime
#  last_sign_in_at              :datetime
#  current_sign_in_ip           :string(255)
#  last_sign_in_ip              :string(255)
#  created_at                   :datetime
#  updated_at                   :datetime
#  user                         :string(255)      not null
#  agency_id                    :integer
#  phone                        :string(255)
#  first_name                   :string(255)
#  last_name                    :string(255)
#  groups                       :text(65535)
#  role                         :integer          default(0)
#  agency_notifications         :boolean          default(FALSE)
#  agency_notifications_emails  :boolean          default(FALSE)
#  contact_notifications        :boolean          default(TRUE)
#  contact_notifications_emails :boolean          default(TRUE)
#  email_notification_type      :integer          default(0)
#

require 'rails_helper'

RSpec.describe User, type: :model do
  it "should pass validations" do
    user = FactoryGirl.create(:user)
    expect(user.valid?).to eq(true)
  end

  it "should return admin status IFF an admin" do
    admin_user = FactoryGirl.create(:admin_user)
    expect(admin_user.admin?).to eq(true)
    user = FactoryGirl.create(:user)
    expect(user.admin?).to eq(false)
  end

end

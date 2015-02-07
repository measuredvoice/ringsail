# == Schema Information
#
# Table name: email_messages
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  to         :string(255)
#  subject    :string(255)
#  body       :text(65535)
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe EmailMessage, type: :model do

  it "validations should run and be successful for the factory" do
    email = Factory(:email_message)
    email.valid?.should == true
  end
  
end

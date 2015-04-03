# == Schema Information
#
# Table name: email_messages
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  to         :text(65535)
#  subject    :string(255)
#  body       :text(65535)
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe EmailMessage, type: :model do
	it { should validate_presence_of(:to) }  
	it { should validate_presence_of(:subject) }  
	it { should validate_presence_of(:body) }  
end

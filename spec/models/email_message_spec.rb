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

RSpec.describe EmailMessage, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

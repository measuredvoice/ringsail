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

class EmailMessage < ActiveRecord::Base
	belongs_to :user

	validates :to, :presence => true
	validates :subject, :presence => true
	validates :body, :presence => true

  paginates_per 25
end

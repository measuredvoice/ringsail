# == Schema Information
#
# Table name: email_messages
#
#  id              :integer          not null, primary key
#  current_user_id :integer
#  to              :string(255)
#  subject         :string(255)
#  body            :text(65535)
#  created_at      :datetime
#  updated_at      :datetime
#

class EmailMessage < ActiveRecord::Base
	belongs_to :users

	validates :to, :presence => true
	validates :subject, :presence => true
	validates :body, :presence => true
end

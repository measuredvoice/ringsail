class EmailMessage < ActiveRecord::Base
	belongs_to :users

	validates :to, :presence => true
	validates :subject, :presence => true
	validates :body, :presence => true
end

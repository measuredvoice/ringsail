# == Schema Information
#
# Table name: galleries
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text(65535)
#

class Gallery < ActiveRecord::Base
	 #handles logging of activity
	include PublicActivity::Model
	tracked owner: Proc.new{ |controller, model| controller.current_user }

	#handles versioning
	has_paper_trail

	has_many :mobile_app_galleries
	has_many :mobile_apps, through: :mobile_app_galleries
	
	has_many :gallery_users
	has_many :users, through: :gallery_users

end

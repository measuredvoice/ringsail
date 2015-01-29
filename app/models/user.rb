# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  email               :string(255)      default(""), not null
#  remember_created_at :datetime
#  sign_in_count       :integer          default(0)
#  current_sign_in_at  :datetime
#  last_sign_in_at     :datetime
#  current_sign_in_ip  :string(255)
#  last_sign_in_ip     :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  user                :string(255)      not null
#  agency_id           :integer
#  phone               :string(255)
#  first_name          :string(255)
#  last_name           :string(255)
#  groups              :string(1000)
#

class User < ActiveRecord::Base
  #handles logging of activity
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  #handles versioning
  has_paper_trail

  belongs_to :agency
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :cas_authenticatable, :trackable

  has_many :email_messages
  has_many :mobile_app_users
  has_many :mobile_apps, through: :mobile_app_users
  
  has_many :gallery_users
  has_many :gallerys, through: :gallery_users

  paginates_per 200

  def cas_extra_attributes=(extra_attributes)
    extra_attributes.each do |name, value|
      case name.to_sym
      when "Email-Address"
        self.email = value
      when "Org-Agency-Name"
        self.agency = Agency.where("name LIKE ?","%#{value}%").first
      when "Phone"
        self.phone = value
      when "First-Name"
        self.first_name = value
      when "Last-Name"
        self.last_name = value
      when "GroupList"
        self.groups = value
      end
    end
  end

end

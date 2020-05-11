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
#  groups                       :text(16777215)
#  role                         :integer          default("user")
#  agency_notifications         :boolean          default(FALSE)
#  agency_notifications_emails  :boolean          default(FALSE)
#  contact_notifications        :boolean          default(TRUE)
#  contact_notifications_emails :boolean          default(TRUE)
#  email_notification_type      :integer          default("full_html_email")
#

class User < ActiveRecord::Base

  belongs_to :agency
  
  devise :omniauthable, omniauth_providers: %i[login_dot_gov] 
  devise :trackable, :timeoutable

  enum role: { user: 0, super_user: 1, admin: 2, banned: 3}
  enum email_notification_type: { full_html_email: 0, plain_text_email: 1 }

  has_many :email_messages

  has_many :mobile_app_users
  has_many :mobile_apps, through: :mobile_app_users
  
  has_many :gallery_users
  has_many :gallerys, through: :gallery_users

  has_many :outlet_users
  has_many :outlets, :through => :outlet_users

  has_many :notifications
  # serialize :agency_notifications_settings, :contact_notifications_settings

  paginates_per 200


  def self.from_omniauth(auth)
    if(auth.info.email.end_with?(".gov") || auth.info.email.end_with?(".mil"))
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0, 20]
        user.first_name = auth.info.try(:first_name)   # assuming the user model has a name
        user.last_name = auth.info.try(:last_name)
      end
    else
      return nil
    end
  end

  def cross_agency?
    admin? || super_user?
  end

end

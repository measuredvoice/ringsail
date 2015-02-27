# To make use of this module, item must have agencies and users as a has_many relationship
module Notifications
  extend ActiveSupport::Concern

  def build_notifications(message_type, message="")
    notifications_users_list.each do |notification_user|
      Notification.create!(item: self, user: notification_user, message_type: message_type, message: message )
    end
  end

  def notifications_users_list
    contacts_list = []
    contacts_list << users.where(contact_notifications: true)
    contacts_list << User.where(agency_id: agencies.map(&:id), agency_notifications: true)
    contacts_list.flatten.uniq
  end
end
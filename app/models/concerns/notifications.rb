# To make use of this module, item must have agencies and users as a has_many relationship
module Notifications
  extend ActiveSupport::Concern

  def build_notifications(message_type, message="")
    contact_users = users.where(contact_notifications: true)
    contact_users.each do |notification_user|
      Notification.create!(item: self, user: notification_user, notification_type: :contact, message_type: message_type, message: message )
    end
    contact_user_ids = contact_users.map(&:id)

    # ensure we don't double create notifications. contacts list is done first, then agencies for those that sub to them.
    
    User.where(agency_id: agencies.map(&:id), agency_notifications: true).where("id NOT IN (?)",contact_user_ids).each do |notification_user|
      Notification.create!(item: self, user: notification_user, notification_type: :agency, message_type: message_type, message: message )
    end
    contact_user_ids <<  User.where(agency_id: agencies.map(&:id), agency_notifications: true).where("id NOT IN (?)",contact_user_ids).map(&:id)
    contact_user_ids = contact_user_ids.flatten.uniq
    User.where(role: User.roles[:admin]).where("id NOT in (?)",contact_user_ids).each do |notification_user|
      Notification.create!(item: self, user: notification_user, notification_type: :admin, message_type: message_type, message: message)
    end
  end

  def build_admin_notifications(message_type, message="")
    User.where(role: User.roles[:admin]).each do |notification_user|
      Notification.create!(item: self, user: notification_user, notification_type: :admin, message_type: message_type, message: message)
    end
  end

  def notifications_users_list
    contact_users = users.where(contact_notifications: true)
    contact_user_ids = contact_users.map(&:id)
    contact_users << User.where(agency_id: agencies.map(&:id), agency_notifications: true).where("id NOT IN (?)",contact_user_ids)
    contact_users.flatten
  end

end
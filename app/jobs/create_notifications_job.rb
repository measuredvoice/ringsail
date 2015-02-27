class CreateNotificationsJob < ActiveJob::Base
  queue_as :default

  def perform(record)
    record.try(:build_notifications)
  end
end

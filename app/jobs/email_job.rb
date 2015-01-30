class EmailJob < ActiveJob::Base
  queue_as :default

  def perform(record)
  	UserMailer.emailnow(record).deliver_now
  end
end

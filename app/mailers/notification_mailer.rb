class NotificationMailer < ActionMailer::Base
  default from: "Social Media Registry <socialmediaregistry@gsa.gov>"

  def email(notification)
    @notification = notification
    subject = "#{t(@notification.item.class)} has been #{@notification.message_type}"
    body = "#{@notification.message}"
    mail(:to => @notification.user.email, :subject => subject) do |format|
    format.html {
      render "body"
    }

    end
  end
end

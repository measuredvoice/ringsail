class EmailMessageMailer < ActionMailer::Base
  default from: "US Digital Registry <socialmediaregistry@usa.gov>"
  def email(record)
  	@email = record
  	mail(:to => @email.to, :subject => @email.subject, :body => @email.body)
  end
end

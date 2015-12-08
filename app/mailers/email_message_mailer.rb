class EmailMessageMailer < ActionMailer::Base
  default from: "Social Media and Mobile Product Registry <socialmediaregistry@gsa.gov>"
  def email(record)
  	@email = record
  	mail(:to => @email.to, :subject => @email.subject, :body => @email.body)
  end
end

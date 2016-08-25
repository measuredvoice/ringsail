class EmailMessageMailer < ActionMailer::Base
  default from: "US Digital Registry <digitalregistry@usa.gov>"
  
  def email(record)
  	@email = record
  	mail(:to => @email.to, :subject => @email.subject, :body => @email.body)
  end
end

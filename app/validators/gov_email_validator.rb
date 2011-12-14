class GovEmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, email_address)
    record.errors.add attribute, "must be a .gov or .mil email address" unless gov_address?(email_address) || admin_user?(email_address)
  end
  
  def admin_user?(email_address)
    !User.find_by_email(email_address).nil?
  end

  def gov_address?(email_address)
    email_address =~ /\A[\w+\-.]+@[a-z\d\-.]+\.(gov|mil)\z/i
  end
end

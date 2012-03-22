# == Schema Information
#
# Table name: auth_tokens
#
#  id           :integer(4)      not null, primary key
#  token        :string(255)
#  email        :string(255)
#  phone        :string(255)
#  admin        :boolean(1)
#  access_count :integer(4)
#  created_at   :datetime
#  updated_at   :datetime
#

class AuthToken < ActiveRecord::Base
  include ActiveModel::Validations
  attr_accessible :email, :phone
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence   => true, 
                    :gov_email  => true
  validates :phone, :presence   => true

  before_save :make_token
  
  def still_valid?
    created_at > 12.hours.ago && updated_at > 4.hours.ago
  end
  
  def is_recent?
    created_at > 1.hour.ago
  end
  
  def self.find_valid_token(token)
    suspect = self.find_by_token(token)
    if (!suspect.nil? && suspect.still_valid?)
      suspect
    else
      nil
    end
  end

  def self.find_recent_by_email(email)
    suspect = self.where(["email = ?", 'chris@measuredvoice.com']).last
    if (suspect && suspect.is_recent?)
      suspect
    else
      nil
    end
  end

  private
  
  def make_token
    if self.token.nil?
      self.token = generate_unique_token
    end
  end
  
  def generate_unique_token
    loop do
      test_token = SecureRandom.hex(16)
      break test_token unless AuthToken.find_by_token(test_token)
    end
  end
end

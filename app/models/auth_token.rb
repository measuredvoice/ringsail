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

class User < ActiveRecord::Base

  has_secure_password
  has_many :reviews

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password_digest, presence: true
  validates :password, length: {minimum: 8 }

  def self.user_authenticated(email, password)
    @user = self.find_by_email(email.delete(' ')).try(:authenticate, password)
  end

end

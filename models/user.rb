require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  validates :username, presence: true, uniqueness: true
  validates :role, inclusion: { in: %w[admin editor viewer] }

  def password
    @password ||= Password.new(password_digest)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_digest = @password
  end

  def authenticate(test_password)
    password == test_password
  end

  def admin?
    role == 'admin'
  end

  def can_edit?
    ['admin', 'editor'].include?(role)
  end
end

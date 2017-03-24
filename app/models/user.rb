class User < ActiveRecord::Base
  has_secure_password

  has_many :playlists
  has_many :songs, through: :playlists

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i

  validates :first_name, :last_name, :email, presence: true
  validates :email, format: { with: EMAIL_REGEX }, uniqueness: { case_sensitive: true }

  before_validation :downcase_email

  private

  def downcase_email
    self.email = email.downcase if email.present?
  end

end

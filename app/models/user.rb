class User < ActiveRecord::Base
  before_save { self.email = email.to_s.downcase }
  mount_uploader :picture, PictureUploader
  validates(:name, presence: true, length: {maximum: 255})
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates(:email, presence: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX}, uniqueness: true)
  validates :password, presence: true, length: {minimum: 6}, confirmation: true, allow_nil: true
  validate :picture_size
  has_secure_password

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
end
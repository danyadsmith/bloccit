class User < ActiveRecord::Base

  before_save { self.email = email.downcase }
  before_create { self.name = formatName(self.name) }

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, length: { minimum: 1, maximum: 100 }, presence: true

  validates :password, presence: true, length: { minimum: 6 }, if: "password_digest.nil?"
  validates :password, length: { minimum: 6 }, allow_blank: true


  validates :email,
            presence: true,
            uniqueness: true,
            length: { minimum: 3, maximum: 100 },
            format: { with: EMAIL_REGEX }

   has_secure_password

  private 
  
  def formatName(name)
    return if name.nil?
    name_parts = name.split(" ")
    name_parts.each do |part|
        part.capitalize!
    end
    full_name = name_parts.join(" ")
  end

end
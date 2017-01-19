class User < ApplicationRecord
	rolify
	# before_save { self.username = username.downcase }
    has_many :orders, :dependent => :destroy
    has_many :drivers, :dependent => :destroy
    validates :username, uniqueness: true
	# User virtual attributes now include password and password_confirm
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }
end

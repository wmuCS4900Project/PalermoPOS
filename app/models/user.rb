class User < ApplicationRecord
	rolify
	# before_save { self.username = username.downcase }
  has_many :orders, :dependent => :destroy
  has_many :drivers, :dependent => :destroy
  validates :username, uniqueness: true
	
	# User virtual attributes now include password and password_confirm
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  
  # Check a user's capabilities
  def can?(action, object)
    # Check each role has cap
    # if this.roles.blank?
    # 	return false 
    # end

    self.roles.each do |role|  
      if role.has_cap?(action, object)
      	return true
      end 
    end

    # If hasn't returned by now, no can do
    return false
  end
end

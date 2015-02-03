class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_secure_password #validate that the two passwords match
  after_destroy :ensure_an_admin_remains
  #before_update :Check_old_password_correct
  private
	def ensure_an_admin_remains
	
		if User.count.zero?
			raise "Can't delete last user"
		end
	end

end

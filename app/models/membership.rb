class Membership < ActiveRecord::Base
	has_many :renewals
	has_many :members
	
	def full_home_address
		home_address + "\n" + "#{city}, #{state} #{zip}"
	end
end

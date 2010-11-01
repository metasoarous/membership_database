module ApplicationHelper
	
	def new_member_path_for membership
		new_member_path + "?membership_id=#{membership.id}"
	end
end

module SessionsHelper
	def toggle_membership_view_link
		display_string = "Switch to #{session[:membership_view] == :cards ? 'table' : 'card'} view"
		link_to display_string, toggle_membership_view_path
	end
end

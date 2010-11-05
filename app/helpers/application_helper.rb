module ApplicationHelper
	def destroy_link(text, record, options = {})
		confirm = options.fetch(:confirm, "Are you sure?")
		link_to text, record, :confirm => confirm, :method => :delete
	end
end

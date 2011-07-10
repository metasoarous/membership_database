module ApplicationHelper
	def destroy_link(text, record, options = {})
		confirm = options.fetch(:confirm, "Are you sure?")
		link_to text, record, :confirm => confirm, :method => :delete
	end
	def write_membership_number_to_file membership
		$logfile = File.new "/home/cts/numbers.txt", "w+"
		$logfile.puts membership.number
		$logfile.close
	end
end

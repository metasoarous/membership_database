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
	
	# From the complex forms example application by Ryan Bates, which 
	# should work for Rails 3 (we'll see if it conflict with anything else 
	# specific that I'm using).
	def link_to_remove_fields(name, f)
		f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
	end
	
	def link_to_add_fields(name, f, association, callback = "function() {}")
		new_object = f.object.class.reflect_on_association(association).klass.new
		fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
			render(association.to_s.singularize + "_fields", :f => builder)
		end
		link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\", \"#{callback}\")" )
	end
end

module MembershipsHelper
	# Some javascript foo magick here in these two methods which let us
	# dynamically add fields for members and renewals.
	def add_member_link(name, form)
		link_to_function name, :class => "jqui_button" do |page|
			member = render(:partial => 'member_form', :locals => { :membership_form => form, :member => Member.new })
			page << %{
	var new_member_id = new Date().getTime();
	$('.members').append( "#{ escape_javascript member }".replace(/membership_members_attributes_\\d+_/g, "membership_members_attributes_" + new_member_id + "_").replace(/\\[members_attributes\\]\\[\\d+\\]/g, "[members_attributes][" + new_member_id + "]") );
	}
		end
	end	
	def add_renewal_link(name, form)
		link_to_function name, :class => "jqui_button" do |page|
			renewal = render(:partial => "renewal_form", :locals => {:membership_form => form, :renewal => Renewal.new})
			page << %{
				var new_renewal_id = new Date().getTime();
				$('.renewals').append( "#{ escape_javascript renewal }".replace(/membership_renewals_attributes_\\d+_/g, "membership_renewals_attributes_" + new_renewal_id + "_").replace(/\\[renewals_attributes\\]\\[\\d+\\]/g, "[renewals_attributes][" + new_renewal_id + "]") );
				}
		end
	end
	
	# The following two methods return either a form remove link or record
	# delete link depending on whether or not the record input is a new_record?
	# or not. It also has a little h4 tag for diplaying what object is being
	# dealt with.
	def member_header(member)
		"<h4>Member</h4> #{member.new_record? ? link_to_function("Remove", "$(this).closest('.member').remove()") : delete_member_link("Delete Record", member.id)}"
	end
	def renewal_header(renewal)
		"<h4>Renewal</h4> #{renewal.new_record? ? link_to_function("Remove", "$(this).closest('.renewal').remove()") : delete_renewal_link("Delete Record", renewal.id)}"
	end
	
	# The two methods above use these two methods for the actual delete
	# links both of which reference ajax jquery function.
	def delete_member_link(name, member_id)
		link_to_function name, "deleteMember(#{member_id});", :confirm => "Are you sure you want to delete this record? This action can not be undone."
	end
	def delete_renewal_link(name, renewal_id)
		link_to_function name, "deleteRenewal(#{renewal_id});", :confirm => "Are you sure you want to delete this record? This action can not be undone."
	end
	
	# This makes it possible to create a new member on a form which doesn't
	# have any other information on it. Might want to remove this at some 
	# in favor of simplifying so that just the membership edit form is where
	# this sort of thing takes place.
	def new_member_path_for membership
		new_member_path + "?membership_id=#{membership.id}"
	end
end

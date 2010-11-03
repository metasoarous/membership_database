module MembershipsHelper
	def add_member_link(name, form)
		link_to_function name, :class => "jqui_button" do |page|
			member = render(:partial => 'member', :locals => { :membership_form => form, :member => Member.new })
			page << %{
	var new_member_id = new Date().getTime();
	$('.members').append( "#{ escape_javascript member }".replace(/membership_members_attributes_\\d+_/g, "membership_members_attributes_" + new_member_id + "_").replace(/\\[members_attributes\\]\\[\\d+\\]/g, "[members_attributes][" + new_member_id + "]") );
	}
		end
	end
	
	def new_member_path_for membership
		new_member_path + "?membership_id=#{membership.id}"
	end
end

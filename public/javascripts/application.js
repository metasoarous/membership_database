$(function() {
	$("#membership_form_tabs").tabs();
	$(".jqui_button").button();
});

deleteMember = function(member_id) {
	var answer = confirm("Are you sure you want to delete this record? This can not be undone.")
	if (answer) {
		$.ajax({
			type: "DELETE",
			url: "/members/" + member_id,
			success: function() {
				$(".member#member_" + member_id).replaceWith("<p>Member record successfully deleted.<p>");
			}
		});
	}
}

deleteRenewal = function(renewal_id) {
	var answer = confirm("Are you sure you want to delete this record? This can not be undone.")
	if (answer) {
		$.ajax({
			type: "DELETE",
			url: "/renewals/" + renewal_id,
			success: function() {
				$(".renewal#renewal_" + renewal_id).replaceWith("<p>Renewal record successfully deleted.<p>");
			}
		});
	}
}
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

function add_fields(link, association, content, callback) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(link).before(content.replace(regexp, new_id));
	var t = setTimeout(callback, 50)
}

/* 
These are from the complex forms example application that Ryan Bates created
(see github account)
*/
function remove_fields(link) {
	var remove = true;
	var newRecord = $(link).closest(".fields").attr("id") == "layer_new";
	if(!newRecord) {
		remove = confirm("Are you sure you want to remove this record?");
	}
	if(remove) {
		$(link).prev("input[type=hidden]").val("1");
		$(link).closest(".fields").hide();
		if(!newRecord) {
			$("div.notices").append("<notice>Record will be removed when you submit form.</notice>");
		}
	}
}

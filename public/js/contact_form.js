$(document).ready(function(){



	$("#contact").on("submit", function(e){
		e.preventDefault();

		var $currentTarget = $(e.currentTarget);
		var button = $currentTarget.find(".submit");


		if(button.hasClass("done")){

		}else{
			var contents = $currentTarget.find("#contents").val();
			var subject = $currentTarget.find("#subject").val();
			var email = $currentTarget.find("#email").val();
			$.ajax({
				type: "POST",
			    url: "/contact_ajax.json?email=" + email + "&contents=" + contents + "&subject=" + subject
			})
			.error(function(data){
				button.val("Something went wrong!! Please try again.");
				button.removeClass("button-blue");
				button.addClass("button-red");
				button.addClass("done");
			})
			.done(function( data ) {
				button.val("Thank you for your note!");
				button.addClass("done");
			});
		}
		return false;

	});


});
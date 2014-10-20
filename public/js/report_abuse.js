$(document).ready(function(){



	$(".report").on("click", function(e){
		e.preventDefault();

		var $currentTarget = $(e.currentTarget);
		if($currentTarget.hasClass("done")){

		}else{

			$.ajax({
				type: "POST",
			    url: "/report.json?url=" + window.location
			})
			.error(function(data){
				$currentTarget.text("Something went wrong!! Please try again.");
				$currentTarget.removeClass("button-blue");
				$currentTarget.addClass("button-red");
				$currentTarget.addClass("done");
			})
			.done(function( data ) {
				$currentTarget.text("Thank you for your report. We are looking into it now.");
				$currentTarget.addClass("done");
			});
		}
		return false;

	});


});
$(document).ready(function(){



	$(".report").on("click", function(e){
		e.preventDefault();

		var $currentTarget = $(e.currentTarget);
		if($currentTarget.hasClass("done")){

		}else{

			$.ajax({
				type: "POST",
			    url: "/report?url=" + window.location
			})
			.error(function(data){
				$currentTarget.text("Something went wrong!! Please try again.");
				$currentTarget.removeClass("button-blue");
				$currentTarget.addClass("button-red");
				$currentTarget.addClass("done");
				$currentTarget.enabled = false;
			})
			.done(function( data ) {
				$currentTarget.text("Thanks!");
				$currentTarget.addClass("done");
				$currentTarget.enabled = false;
			});
		}
		return false;

	});


});
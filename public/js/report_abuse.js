$(document).ready(function(){



	$(".report").on("click", function(e){
		e.preventDefault();


		$.ajax({
			type: "POST",
		    url: "/report?url=" + window.location
		})
		.done(function( data ) {
	      console.log( "Sample of data:", data.slice( 0, 100 ) );
		});

		return false;

	});


});
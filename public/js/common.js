$(document).ready(function(){
	$('.tooltipper').qtip({
	    content: {
	        text: function(event, api) {
	            // Retrieve content from custom attribute of the $('.selector') elements.
	            return $(this).data('tooltip');
	        }
	    },
	    position: {
	        my: 'top center',  // Position my top left...
	        at: 'bottom center' // at the bottom right of...
	    },
	    style: {
	        classes: 'qtip-youtube'
	    }
	});


	$(".marquee").marquee({
		duration: 20000
	});


});
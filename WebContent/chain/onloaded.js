/*
new fullpage('#fullpage', {
	anchors:['process', 'as-is', 'fund', 'contact-us'],
    navigation: true,
    navigationPosition: 'right',
    normalScrollElements: '.search_list',
    // fadingEffect: true, 
    onLeave: function(index, nextIndex, direction){
    	if (nextIndex != null && typeof nextIndex == 'object') {
    		if (nextIndex.isLast) {
    			$(".footer").delay(800).slideDown('fast');
    		} else $(".footer").slideUp();
    	}
    }
});

$(document).ready(function() {
  	$(".footer").hide();
  $(".slideup").show();
	
});
*/
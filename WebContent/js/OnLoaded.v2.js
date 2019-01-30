function goTop() {
	try {
    	$('body, html').animate({ scrollTop: $("#header").offset().top }, 400);
	} catch(e) {}
}

$(document).ready(function() {

	$("span.menu>ul>li>ul").hide();

	// menu click event
	var selected = -1;
	$("span.menu").find("span").click(function() {
		$("span.menu ul>li").find("span").removeClass("opened");
		$("span.menu ul>li>ul").hide();
		if (selected!=$(this).parent().index()) {
			$(this).parent().find("ul").show();
			$(this).parent().find("span").addClass("opened");
			selected = $(this).parent().index();
		} else selected = -1;
	});
	
	// mouse leave in burger menu
	$("span.menu").mouseleave(function() {
		hidePopMenu();
	});

	// outer click in burger menu
	$(document).on("click", ".section, .footer", function(event){
		console.log($(this).focus());
		if ($("span.menu").position().left < $(window).width()) hidePopMenu();
		event.stopPropagation();
	});
	
});

// toggle drawer
function toggleDrawer() {
	if ($("span.menu").position().left > $(window).width()) {
		$("span.menu").animate({right:'0px'}, 200);
	} else  hidePopMenu();
}

// hide drawer
function hidePopMenu() {
	$("span.menu").animate({right:'-260px'}, 200);
}
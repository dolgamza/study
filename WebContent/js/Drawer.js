// @required section_pop_menu

$(document).ready(function() {

	// set menu
	$("#section_pop_menu").html($("#nav_menu").html());
	$("#section_pop_menu").find("ul").hide();
	
	// menu click event
	var objCurrent = -1;
	$("#section_pop_menu").find("span").click(function() {
		$("#section_pop_menu").find("span").removeClass("opened");
		if (objCurrent==$(this).parent().index()) {
			$(this).parent().find("ul").toggle();
		} else {
			$("#section_pop_menu").find("ul").hide();
			$(this).parent().find("ul").toggle();
		}
		objCurrent=$(this).parent().index();
		
		if ($(this).parent().find("ul").css('display')!='none') $(this).parent().find("span").addClass("opened");
		
	});
	
	// mouse leave in burger menu
	$("#section_pop_menu").mouseleave(function() {
		hidePopMenu();
	});

	// outer click in burger menu
	$("#section_body, #header, #footer").click(function(event){
		if ($("#section_pop_menu").position().left < $(window).width()) hidePopMenu();
		event.stopPropagation();
	});
	
});

// toggle drawer
function toggleDrawer() {
	if ($("#section_pop_menu").position().left > $(window).width()) {
		$("#section_pop_menu").animate({right:'0px'}, 200);
	} else  hidePopMenu();
}

// hide drawer
function hidePopMenu() {
	$("#section_pop_menu").animate({right:'-260px'}, 200);
}


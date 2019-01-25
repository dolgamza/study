// @required strLocation

function goTop() {
	try {
    	$('body, html').animate({ scrollTop: $("#header").offset().top }, 400);
	} catch(e) {}
}

$(document).ready(function() {
	// set title
	$("#section_location span").html(strLocation);
	if ($(window).width()<1021) setMobileMode(); // @see ScrollEvent.js
	else setWebMode(); // @see ScrollEvent.js
	
	// navigation menu control
	$("#nav_menu.menu li").hover(function(){
		$('ul:first',this).show();
	}, function(){
		$('ul:first',this).hide();
	});
	
});

// unused
function setLocation() {
	if ($(window).width()<1021 && strLocation.indexOf("<a")>-1) {
		var s = strLocation.split("<a");
		var u = "<a" + s[s.length-1];
		$("#section_location span").html(u);
	} else $("#section_location span").html(strLocation);
}
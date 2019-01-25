// @required enableLocation
// @required enableScrollEvent

$(document).ready(function() {
	// scroll
	$(window).scroll(function() {
		if ($(window).width()>1020) setWebMode();
		else setMobileMode();
	});
	// resize
	$(window).resize(function() {
		if ($(window).width()>1020) setWebMode();
		else setMobileMode();
	});
});

// web mode
function setWebMode() {
	if (enableLocation==1) {
		$("#section_location").show();

	}
	else $("#section_location").hide();

	$("#drawer").hide();

	if (enableScrollEvent==1) { 
		if ($(window).scrollTop()>20) {
			$("#header").hide();
			if (enableLocation==1) {
				$("#section_location").addClass("fixed");
				$("#section_body").css({'top':'80px'});
			}
		} else 	{
			$("#header").show();
			if (enableLocation==1) {
				$("#section_location").removeClass("fixed");
				$("#section_body").css({'top':'140px'});
			}
		}
	} else {
		$("#header").css({'position': 'fixed'});
		$("#header").css('top', '0px');
	}
}

// mobile mode
function setMobileMode() {
	$("#header").show();
	$("#section_location").hide();
	$("#drawer").show();
	$("#header").css({'position': 'fixed'});
	$("#header").css('top', '0px');
	$("#section_body").css({'top':'80px'});

}

// unused
function setLocation() {
	if ($(window).width()<1021 && strLocation.indexOf("<a")>-1) {
		var s = strLocation.split("<a");
		var u = "<a" + s[s.length-1];
		$("#section_location span").html(u);
	} else $("#section_location span").html(strLocation);
}
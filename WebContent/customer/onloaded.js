var timer;
var slider;

// initialize slides
function initSlide(tgt) {
	if ($(window).width() < 1041) {
		$(".slide li").css('width', '100%');
	} else {
		$(".slide li").css('width', '15%');
	}
	var w = $(".slide li:first-child").width() + 38;
	$(".slide."+tgt+" li").each (function(idx) {
		idx = idx%6;
		$(this).css('left', idx*w);
	});	
}

// slide control
function slide() {
	if ($(window).width() < 1900) {
		slider = setTimeout(moveRight, 3000);
	} 
}

// move
function moveRight() {
	var w = $(".slide li:first-child").width() + 38;
	// kiosk
	if ($(".slide.kiosk li:last-child").position().left + $(".slide.kiosk li:last-child").width() - 50 < $(".slide.kiosk").position().left + $(".slide.kiosk").width()) {
		initSlide("kiosk");
	} else {
		$(".slide.kiosk li").each (function(idx) {
			$(this).animate({'left':$(this).position().left-w}, "slow");
		});
	}
	// study room
	if ($(".slide.studyroom li:last-child").position().left + $(".slide.studyroom li:last-child").width() - 50 < $(".slide.studyroom").position().left + $(".slide.studyroom").width()) {
		initSlide("studyroom");
	} else {
		$(".slide.studyroom li").each (function(idx) {
			$(this).animate({'left':$(this).position().left-w}, "slow");
		});
	}
	// recurse
	slide();
}
  
$(document).ready(function() {

	// window resize event
	$(window).resize(function() {
		initSlide("kiosk");
		initSlide("studyroom");
		clearTimeout(slider);
		clearTimeout(timer)
		timer = setTimeout(slide, 150);
	});
	
	// start
	initSlide("kiosk");
	initSlide("studyroom");
	slide();
	
});

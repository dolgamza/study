var timer;
var slider;

// initialize slides
function initSlide(tgt) {
	if ($(window).width() < 1041) {
		$(".slide li").css('width', '100%');
	} else {
		$(".slide li").css('width', '14%');
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
		slider = setTimeout(round, 3000);
	} 
}

// move
function round() {
	moveRight("slow");
	slide();
}
 
function moveRight(speed) {
	var w = $(".slide li:first-child").width() + 38;
	// kiosk
	if ($(".slide.kiosk li:last-child").position().left + $(".slide.kiosk li:last-child").width() - 50 < $(".slide.kiosk").position().left + $(".slide.kiosk").width()) {
		initSlide("kiosk");
	} else {
		$(".slide.kiosk li").each (function(idx) {
			$(this).animate({'left':$(this).position().left-w}, speed);
		});
	}
	// study room
	if ($(".slide.studyroom li:last-child").position().left + $(".slide.studyroom li:last-child").width() - 50 < $(".slide.studyroom").position().left + $(".slide.studyroom").width()) {
		initSlide("studyroom");
	} else {
		$(".slide.studyroom li").each (function(idx) {
			$(this).animate({'left':$(this).position().left-w}, speed);
		});
	}	
}

function moveLeft(speed) {
	var w = $(".slide li:first-child").width() + 38;
	// kiosk
	if ($(".slide.kiosk li:first-child").position().left < 0) {
		$(".slide.kiosk li").each (function(idx) {
			$(this).animate({'left':$(this).position().left+w}, speed);
		});
	}
	// study room
	if ($(".slide.studyroom li:first-child").position().left < 0) {
		$(".slide.studyroom li").each (function(idx) {
			$(this).animate({'left':$(this).position().left+w}, speed);
		});
	}	
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
	
	var x;

	$(".slide img").bind('touchstart', function(e){
		e.preventDefault();
		clearTimeout(slider);
		clearTimeout(timer);
		x = e.originalEvent.changedTouches[0].pageX;
	});

	$(".slide img").bind('touchmove', function(e){
		e.preventDefault();
	});
	
	$(".slide img").bind('touchend', function(e){
		e.preventDefault();
		var tx;
		tx = e.originalEvent.changedTouches[0].pageX;
		if (tx < x) {
			moveRight("fast");
		} else if (tx > x) {
			moveLeft("fast");
		}
		slide();
	});
	
	
});

var t = -1;

function goBack() {
	location.href='seat.jsp';
}

$(document).ready(function() {

	$(".choice li").click(function() {
		t = $(".choice li").index(this);
		$(".choice li").addClass("off");
		$(".choice li").eq(t).removeClass("off");		
	});

	$(".pop div span").click(function() {
		if ($(".pop div span").index(this) == 0) settle();
		else {
			$('#mask').hide();
			$(".pop").hide();
		}
	});
	
});

function complete() {
	var strNotChoice = "__-1__0__1__2__9__11__14__20__";
	if (strNotChoice.indexOf("__"+t+"__")>-1) { alert('골라주세요');}
	else {
		var maskHeight = $(document).height();  
        var maskWidth = $(window).width();  
        $('#mask').css({'width':maskWidth,'height':maskHeight});  
        $('#mask').fadeIn(300);      
        $('#mask').fadeTo("slow",0.7);
        $(".pop").show();
        $("html, body").scrollTop(0);
	}
}

function settle() {
	alert('settle!');
}
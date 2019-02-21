var t = -1;
var product;

function goBack() {
	location.href='seat.jsp';
}

$(document).ready(function() {

	$(".pop div span").click(function() {
		if ($(".pop div span").index(this) == 0) settle();
		else {
			$('#mask').hide();  
			$(".pop").hide();
		}
	});
	
});


/*
function complete(storeNo, cardNo, roomType) {
	if (typeof product == "undefined") { 
		alert('이용권을 석택하세요.')
	} else {
		location.href="seatSelectList.jsp?paramSeqNo="+storeNo+"&paramCardNo="+cardNo+"&paramroomType="+roomType;
	}
	 
	} else {
		var maskHeight = $(document).height();  
        var maskWidth = $(window).width();  
        $('#mask').css({'width':maskWidth,'height':maskHeight});  
        $('#mask').fadeIn(300);      
        $('#mask').fadeTo("slow",0.7);
        $(".pop").show();
        $("html, body").scrollTop(0);
	}
}
*/

function complete(storeNo, cardNo, roomType) {
	   if (typeof product == "undefined") { 
	      alert('이용권을 선택하세요.')
	   } else {
	      var maskHeight = $(document).height();  
	        var maskWidth = $(window).width();  
	        $('#mask').css({'width':maskWidth,'height':maskHeight});  
	        $('#mask').fadeIn(300);      
	        $('#mask').fadeTo("slow",0.7);
	        $(".pop").show();
	        $("html, body").scrollTop(0);
	        $(".pop .settle").click(function() {
	           location.href="seatSelectList.jsp?paramSeqNo="+storeNo+"&paramCardNo="+cardNo+"&paramroomType="+roomType;
	        });
	        $(".pop .cancel").click(function() {
	           $(".pop").hide();
	        });
	   }
	}


function settle() {
	var frm = document.frmPrice;
	frm.target = "_self";
	frm.action = 'inipay.jsp';
	frm.submit();
}
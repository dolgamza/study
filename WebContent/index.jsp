<%@page contentType="text/html;charset=utf-8"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);
%>
<!DOCTYPE html>
<html lang="ko" >

<head>
  <meta charset="UTF-8">
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
  <meta name="format-detection" content="telephone=yes">
  <meta name="mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta http-equiv="Expires" content="-1"> 
  <meta http-equiv="Pragma" content="no-cache"> 
  <meta http-equiv="Cache-Control" content="No-Cache"> 
  <meta name="keywords" content="">
  <meta name="description" content="">
  <meta name="robots" content="index,follow">
  <meta property="og:title" content="http://www.beablekorea.com">
  <meta property="og:url" content="비에이블코리아(주)">
  <meta property="og:image" content="<%=application.getContextPath() %>/images/link.png">
  <meta property="og:description" content="무인카페, 스터디카페, 조용한분위기">

  <title>beablekorea</title>
  <link rel='stylesheet' href='https://rawgit.com/alvarotrigo/fullPage.js/dev/src/fullpage.css'>
  <link rel="stylesheet" href="./css/style.v2.css" type="text/css" media="all">
  <style>
body {background-image:url('./images/main/bg_00.png');}

.logo {z-index:10;position:absolute;}
.section .title {position:absolute;top:100px;margin:0px 40px;font-size:3em;color:#fff;}

.section ul {text-align:center;display:inline-table;width:90%;margin:0;}
.section li {display:inline;width:calc(30% - 20px);padding:20px;float:left;list-style:none;position:relative;}
.section li img {width:70%;}

.section.main-section-1 img {width:40%}

.section.main-section-2 .darky {padding:0 15px;height:200px;text-align:left;line-height:1.4em;font-size:0.9em;color:white;background-color:rgba(0,0,0,0.4);border-right:1px solid #777;text-align:center;}
.section.main-section-2 .darky:nth-child(3n) {border:0;}
.section.main-section-2 .darky.hr {height:20px;border:0;}

.section.main-section-3 ul {both:clear;margin-top:100px;}
.section.main-section-3 li {padding:10px;}
.section.main-section-3 li img {width:80%;}

.section.main-section-4 li {width:calc(50% - 60px);}
.section.main-section-4 li img {width:45%;}
.section.main-section-4 li.settle {display:none;}

.section.main-section-2 .darky {text-align:left;}

/* responsive web */
@media only screen and (max-width : 1040px) {
	body {font-size:1.1em;}	
	.section .title {font-size:2em;}
	.footer table {width:96%;}
	.section div img {width:100%;}
	.section.main-section-1 img {width:80%}
	
	.section.main-section-2 li {display:block;float:none;height:150px;}
	.section.main-section-2 ul {margin-top:100px;margin-left:20px;}
	.section.main-section-2 ul:nth-child(1) {position:absolute;top:0;left:60px;width:30%;}
	.section.main-section-2 ul:nth-child(2) {position:absolute;top:0;left:130px;}
	.section.main-section-2 li img {width:100px;}
	.section.main-section-2 .darky {width:58%;height:150px;padding:20px;border-right:0;border-bottom:1px solid #777;}
	.section.main-section-2 .darkl:last-child {border-bottom:0;}
	.section.main-section-2 .darky.hr {display:none;}
	.section.main-section-3 ul, .section.main-section-4 ul {width:25%;}
	.section.main-section-3 li, .section.main-section-4 li {display:block;float:none;width:100%;height:100%;}
	.section.main-section-2 img {width:100%;margin-left:-70px;}
	.section.main-section-3 li img {width:120%;margin-left:-30px;}
	.section.main-section-4 li img {width:120%;margin-left:-70px;padding-left:0;}
	.section.main-section-4 li.settle {display:block;}
}
	</style>
  
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js" type="text/javascript"></script>
  	<script type="text/javascript">
  	$(document).ready(function() {

  		$(window).scroll(function(){
  			console.log($(window).scrollTop());
	  	});
  		
  		$('.over').hover(function(){
  			$(this).attr("src", $(this).attr("src").replace('.png', '_on.png'));
  		}, function() {
  			$(this).attr("src", $(this).attr("src").replace('_on.png', '.png'));
  		});
  		
  		$(".main-section-3 li").click(function(){
  	    	var idx = $(".main-section-3 li").index(this);
  	    	$(".section.main-section-3").css("background-image", "url('./images/main/bg_section_"+idx+".jpg')");
  	    	$(".section.main-section-3").css("background-size", "cover");
  	    });
  		
  	});
  	</script>
</head>

<body>

  <div class='logo'><img src='./images/main/logo.png'></div>

  <div id="fullpage">
    <div class="section main-section-1"><img src='./images/main/logo_neon.png?1'></div>
    <div class="section main-section-2">
		<ul>
			<li><img src='./images/main/section_2_icon_1.png'></li>
			<li><img src='./images/main/section_2_icon_2.png'></li>
			<li><img src='./images/main/section_2_icon_3.png'></li>
		</ul>
		<ul>
			<li class='darky hr'></li>
			<li class='darky hr'></li>
			<li class='darky hr'></li>
			<li class='darky'>비에이블스터디카페는 2016년 4월 1호점 서울대입구센터를 시작으로 현재 까지 수도권을 기반으로 전국적인 개설센터 및 운영중에 있습니다.  </li>
			<li class='darky'>대표의 지휘아래 모든 공사 과정을 본사에서 직접 진행하며, 비에이블만의 차별화된 컨셉과 디자인으로 업계 최고의 인테리어를 구축하였습니다. </li>
			<li class='darky'>센터의 통합 관리를 통한 운영 메뉴얼화로 국내 최초 자동화 시스템 원천기술을 보유하고 있으며, 시스템 업데이트 및 유지보수를 진행하고 있습니다.  </li>
			<li class='darky hr'></li>
			<li class='darky hr'></li>
			<li class='darky hr'></li>
		</ul>
    </div>
    <div class="section main-section-3">
	    <div class='title'>_공간소개</div>
    	<ul>
			<li><img src='./images/main/section_3_icon_1.png' class='over'></li>
			<li><img src='./images/main/section_3_icon_2.png' class='over'></li>
			<li><img src='./images/main/section_3_icon_3.png' class='over'></li>
		</ul>
    </div>

    <div class="section main-section-4" >
    	<ul>
			<li><a href='./customer/'><img src='./images/main/section_4_icon_1.png' class='over'></a></li>
			<li><a href='./chain/'><img src='./images/main/section_4_icon_2.png' class='over'></a></li>
			<li class='settle'><a href=''><img src='./images/main/section_4_icon_settle.png' ></a></li>
		</ul>
    </div>
</div>

    <div class="footer" >
		<table>
			<tr>
				<th>상호</th>
				<td>비에이블스터디카페</td>
				<th> 주소</th>
				<td> 서울특별시 강서구 양천로 583</td>
			</tr>
			<tr>
				<th>대표자</th>
				<td>전보익</td>
				<th></th>
				<td>(염창동, 우림블루나인비즈니스센터) , A동 2210호</td>
			</tr>
			<tr>
				<th>사업자 등록번호</th>
				<td> 641-81-01148</td>
				<th>대표번호</th>
				<td>1544-8306</td>
			</tr>
		</table>
		
    </div>

  <script src='https://rawgit.com/alvarotrigo/fullPage.js/dev/src/fullpage.js'></script>
  <script type="text/javascript">
  	new fullpage('#fullpage', {
  		anchors:['top', 'intro', 'space', 'customer'],
        navigation: true,
        navigationPosition: 'right',
        fadingEffect: true,
        onLeave: function(index, nextIndex, direction){
        	$(".section.main-section-3").css("background-image", "");
        	if (nextIndex != null && typeof nextIndex == 'object') {
        		console.log(JSON.stringify(nextIndex));
        		if (nextIndex.isLast) {
        			$(".footer").delay(800).slideDown('fast');
        		} else $(".footer").slideUp();
        	}
        }
  	});
  	$(".footer").hide();
  	</script>

</body>
</html>

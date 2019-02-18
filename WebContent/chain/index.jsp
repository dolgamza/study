<%@page contentType="text/html;charset=utf-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "kr.co.dw.util.*" %>
<%@ page import = "kr.co.beable.chain.*" %>
<%
	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
	
	String strTitle 	= "";
	String strLocation 	= "";
	int tot_cnt			= 0;
	
	String strPage		= StrUtil.getParameter(request.getParameter("strPage"), "1");
	String strPageBlock	= StrUtil.getParameter(request.getParameter("strPageBlock"), "10");
	int intPage			= Integer.parseInt(strPage);
	int intPageBlock	= Integer.parseInt(strPageBlock);
	
	String strSelFg		= StrUtil.getParameter(request.getParameter("strSelFg"), "FC_NAME");
	String strSelVal	= StrUtil.getParameter(request.getParameter("strSelVal"), "");
	
	ArrayList<ChainVO.resLocationTapVO> arr = new ChainBean().FC_LOCATION_TAP_PROC();
	if(arr != null && arr.size() > 0) {
		tot_cnt = Integer.parseInt(arr.get(0).TOT_CNT);
	}
	
	StringBuffer sb 			= new StringBuffer();

	ArrayList<ChainVO.resLocationMapVO> arrMap = new ChainBean().FC_LOCATION_MAP_PROC("", "", "A");
	if(arrMap != null && arrMap.size() > 0){
		
		String comma	 = ",";
		
		for(int i=0; i<arrMap.size(); i++){
			
			if(i == (arrMap.size()-1)) comma = "";
			
			ChainVO.resLocationMapVO vo = (ChainVO.resLocationMapVO)arrMap.get(i);
			
			sb.append("{content:\n");
			sb.append("	'<div class=\"wrap\">'+\n");
			sb.append("		'<div class=\"info\">'+\n");
			sb.append("			'<div class=\"title\">"+vo.STORE_NM+"</div>'+\n");
			sb.append("			'<div class=\"body\">'+\n");
// 			sb.append("				'<div class=\"img\">'+\n");
// 			sb.append("                '<img src=\""+vo.FC_THUMBNAIL+"\" width=\"73\" height=\"70\">'+\n");
// 			sb.append("           	'</div>'+\n");
			sb.append("				'<div class=\"desc\">'+\n");
			sb.append("					'<div class=\"ellipsis\">"+vo.ADDR+"</div>'+\n");
			sb.append("					'<div class=\"jibun ellipsis\">"+vo.PHONE_NO+"</div>'+\n");
			sb.append("					'<div><a href=\""+vo.WEB_URL+"\" target=\"_blank\" class=\"link\">홈페이지</a></div>'+\n");
			sb.append("				'</div>'+\n");
			sb.append("			'</div>'+\n");
			sb.append("		'</div>'+\n");
			sb.append("	'</div>'\n");
			sb.append(",");
			sb.append("latlng:new daum.maps.LatLng("+vo.COORDINATE+")");
			sb.append("}" + comma);
		}
	}
	
%>
<jsp:include page="../inc/Header.v2.jsp" flush="false">
	<jsp:param name="title" value="<%=java.net.URLEncoder.encode(strTitle, java.nio.charset.StandardCharsets.UTF_8.toString())%>"/>
	<jsp:param name="location" value="<%=java.net.URLEncoder.encode(strLocation, java.nio.charset.StandardCharsets.UTF_8.toString()) %>"/>
</jsp:include>
<style>

.section.bg {background-image:url('../images/main/bg_02.jpg');height:500px;background-size:cover;}
.section.main-section-3,  .section.main-section-4,  .section.main-section-5 {position:relative;background-color:white;}
.section:last-child {padding-bottom:120px;}
.rooptop {position:fixed;top:0;}
.footer {position:relative;margin-top:-50px;}

/* #process */
.section.main-section-2 {padding-top:30px;background-color:#fff;}
.slideup {text-align:center;width:100%;height:480px;}
.slideup > .subheading_img {margin-top:0;}

/* as-is */
.main-section-3 ul {width:90%;margin-left:auto;margin-right:auto;}
.main-section-3 li {display:inline-block;list-style:none;font-size:0.9em;width:48%;}
.main-section-3 .chain_search {margin-bottom:10px;background:url('../images/m.png') no-repeat;background-position:calc(100% - 10px);}
.main-section-3 li table {width:100%;margin-top:0px;margin-bottom:10px;}
.main-section-3 li table th, .main-section-3 li table td {border-top:1px solid #ccc;}
.main-section-3 li table td.underline {border-bottom:1px solid #ccc;}
.main-section-3 li table td.detail {text-align:left;padding-left:10px;color:#555;}

.main-section-3 td.pic {width:150px;height:150px;padding:0px;} 
.main-section-3 td img {width:100%;height:100%;margin-bottom:-3px;}

/* #fund */
.main-section-4 table {margin-top:0;}
.main-section-4 th {width:10%;border-bottom:1px solid #a0393f;}
.main-section-4 td {width:30%;border-bottom:1px solid #ccc;}
.main-section-4 .topline {border-top:1px solid #ccc;}
.main-section-4 ul {text-align:left;width:90%;margin-left:auto;margin-right:auto;margin-top:15px;font-size:0.7em;}
.main-section-4 li {list-style-position:inside;margin-bottom:8px;text-indent:-24px;padding-left:24px;}

/* contacts */
.form {margin-top:40px;}
.form ul {position:relative;width:90%;margin-left:auto;margin-right:auto;text-align:left;}
.form li {list-style:none;width:50%;}
.form label {display:inline-block;width:150px;height:30px;color:#80191f;border-bottom:1px solid #80191f;font-size:0.85em;}

.main-section-5 li {position:relative;}
.main-section-5 table {position:absolute;top:0;left:156px;margin:0;padding:0;width:calc(100% - 189px);font-size:1em;}
.main-section-5 label {padding-top:7px;}
.main-section-5 td {margin:0;padding:0;background-color:white;width:30%;border:1px solid #80191f;}
.main-section-5 td:last-child {}
.main-section-5 td.at {width:5%;text-align:center;border:0;}
.main-section-5 input, .main-section-5 select {background-color:white;padding:5px;font-size:0.825em;height:auto;}
.main-section-5 td input, .main-section-5 td select {border:0;}
.form select {height:auto;margin-left:3px;width:calc(100% - 11px);}

.form .half {width:calc(100% - 200px);}
.form li.textarea {position:absolute;top:0;left:50%;}
.form textarea {width:100%;margin-left:-30px;height:86px;resize:none;overflow-y:scroll;}
.phone {font-size:2.4em;color:#80191f;margin-top:-30px;}
.email a {color:#80191f;}

.btn {width:90%;margin-left:auto;margin-right:auto;}


.wrap {position: absolute;left: 0;bottom: 40px;width: 288px;height: 132px;margin-left: -144px;text-align: left;overflow: hidden;font-size: 12px;font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;line-height: 1.5;}
.wrap * {padding: 0;margin: 0;}
.wrap .info {width: 286px;height: 120px;border-radius: 5px;border-bottom: 2px solid #ccc;border-right: 1px solid #ccc;overflow: hidden;background: #fff;}
.wrap .info:nth-child(1) {border: 0;box-shadow: 0px 1px 2px #888;}
.info .title {padding: 5px 0 0 10px;height: 30px;background: #d95050;border-bottom: 1px solid #ddd;font-size: 18px;font-weight: bold;}
.info .close {position: absolute;top: 10px;right: 10px;color: #888;width: 17px;height: 17px;background: url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');}
.info .close:hover {cursor: pointer;}
.info .body {position: relative;overflow: hidden;}
.info .desc {position: relative;margin: 13px 0 0 90px;height: 75px;}
.desc .ellipsis {overflow: hidden;text-overflow: ellipsis;white-space: nowrap;}
.desc .jibun {font-size: 11px;color: #888;margin-top: -2px;}    
.info:after {content: '';position: absolute;margin-left: -12px;left: 50%;bottom: 0;width: 22px;height: 12px;background: url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
.info .link {color: #5085BB;}
   
select.fa {width:calc(30% - 17px);}
input.fb {width:calc(50% - 0px);margin:5px;}
input.fc {width:calc(20% - 27px);background-color:#80191f;text-align:center;color:white;padding-right:10px;cursor:pointer;}
.chain_search {margin-bottom:8px;background:url('../images/m.png') no-repeat;background-position:calc(100% - 10px);}
   
.main-section-3 div>ul>li>div>span:hover {background-color:orange;}
.main-section-3 div>ul>li>div>span:last-child {border-right:1px solid #ccc;}

/* pagination */ 
#pagination {position:relative;width:90%;height:40px;padding-top:15px;font-size:0.9em;text-align:left;}
#pagination #paging {display:inline-block;position:absolute;}
#pagination #paging .btn {border-radius:3px;padding:4px 6px;vertical-align:middle;color:#000;background-color:#fff;margin-right:3px;}
#pagination #paging .btn:hover {color:#fff;background-color:#000;}
#pagination #paging .on {background-color:#80191f;color:#fff;}

.phone {margin-top:20px;}
.phone img {width:35px;}

/* responsive web */
@media only screen and (max-width : 1040px) {
	.subheading {font-size:1.6em;}
	.slideup {text-align:center;width:90%;height:300px;;margin-left:auto;margin-right:auto;}
	.slideup div img {width:100%;}

	.main-section-3 .chain_search {display:inline-block;}
	.main-section-3 li:nth-child(1) {width:0;} 
	.main-section-3 li:nth-child(2) {width:100%;text-align:left;}
	.main-section-3 td.pic {width:120px;height:120px;}
	.main-section-3 th {display:none;}

	.main-section-5 table {left:86px;width:calc(100% - 86px);}
	.form li.textarea {position:relative;left:30px;width:calc(100% - 22px);margin-top:5px;}

	.form li {width:100%;margin-bottom:2px;}
	.form label {width:80px;height:28px;}
	.form .half {width:calc(100% - 100px);}

	.subheading.s {font-size:1.4em;margin-bottom:30px;}
	.phone {font-size:1.4em;margin-top:10px;}
	.phone img {width:20px;}
	
	.main-section-3 .maparea {display:none;}
	.fb {width:30%;}
	
}


.main-section-3 div>ul>li>div>span {
   display:inline-block;font-size:0.8em;padding:10px 4.5px;background-color:#fff;border:1px solid #ccc;border-right:0;
   width:calc(95%/5 - 10px);
   text-align:center;cursor:pointer;
}





</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/js/alertify.css?0.5" type="text/css" media="screen">
<script src="${pageContext.request.contextPath}/js/alertify.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/paging.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/formchecker.js?0.1" type="text/javascript"></script>
<script type="text/javascript">
$(function(){
	$(window).on("load",function() {
		goPage(1);
	});
});

function search() {
	goPage(1);
}

function goPage(i) {
	
	//페이지번호 셋팅
	$("#strPage").val(i);
	
	//리스트 가져오기
	$.post("../settle/centerAjax.jsp", $("#frmSearch").serialize(), function(data){
		var json = JSON.parse($.trim(data));
		if(json.isSuccess) {
			fnMakList(i, json.intTotalCnt, json.resData);
		} else {
			fnMakList(1, 0, "");
		}
	})
	.error(function(){
		fnMakList(1, 0, "");
	});
}

function fnMakList(intCurrentPage, intTotalRowNum, jsonList) {
	/* 화면 페이징 구현 */
	fnMakPaging(intCurrentPage, intTotalRowNum, $("#strPageBlock").val(), 10, "goPage");
	
	/* 화면 리스트 구현 */
	var listHtml = '<table>';
	if(jsonList != '' && jsonList.length > 0) {
		listHtml += '';
		for (var i = 0; i < jsonList.length; i++) {
			listHtml += '<tr>';
			listHtml += '	<td rowspan="4" class="pic underline"><img src=""></td>';
			listHtml += '	<td colspan="2">'+jsonList[i].STORE_NM+'</td>';
			listHtml += '</tr>';
			listHtml += '<tr>';
			listHtml += '	<th>주소</th>';
			listHtml += '	<td class="detail">'+jsonList[i].ADDR+'</td>';
			listHtml += '</tr>';
			listHtml += '<tr>';
			listHtml += '	<th>전화번호</th>';
			listHtml += '	<td class="detail">'+jsonList[i].PHONE_NO+'</td>';
			listHtml += '</tr>';
			listHtml += '<tr>';
			listHtml += '	<th class="underline">홈페이지</th>';
			listHtml += '	<td class="detail underline">'+jsonList[i].WEB_URL+'</td>';
			listHtml += '</tr>';
		}
	} else {
		listHtml += '<tr><td style="height:150px;">검색 결과가 없습니다.</td></tr>';
	}
	
	listHtml += '</table>';
	
	$(".list").html(listHtml);
}
</script>
<div id="fullpage">
	<div class='section bg'></div>
	<div class="section main-section-2" tabindex="1">
    	<div class='slideup'>
    		<img src='../images/main/logo4sub.png' class='subheading_img'/>
    		<div class='subheading'>개설절차</div>
    		<div><img src='../images/chain/process.png?3' width="70%"></div>
    	</div>	
	</div>
	<div class="section main-section-3">
		<img src='../images/main/logo4sub.png' class='subheading_img'/>
   		<div class='subheading'>센터현황</div>	
   		<div>
   			<ul>
   				<!-- 지도영역 --> 
   				<li class='maparea'>
                  	<div style="text-align:left;margin-bottom:10px;">
                  	<%
           			String strTag_first = "";
           			String strTag_last 	= "";
           		
           			if(arr != null && arr.size() > 0) {
           				for(int i=0; i<arr.size(); i++){
           					if(i == 0){ strTag_last = ""; strTag_first = "<!-- "; 
           					} else if(i==(arr.size()-1))  {
           						strTag_last = " -->"; strTag_first = "";
           					} else  {
           						strTag_last = " -->"; strTag_first = "<!-- ";
           					}
           					
           					ChainVO.resLocationTapVO vo = (ChainVO.resLocationTapVO)arr.get(i);
           					out.println(strTag_last+"<span><a href=\"javascript:setLocMove('"+vo.LOC_LATITUDE+"','"+vo.LOC_LONGITUDE+"');\">"+vo.SIDO_NM+" ("+vo.CNT+")</a></span>"+strTag_first);
           				}
					}
                  	%>
                  	</div>
	   				<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dab0208119ff46e1af518efed56ac285"></script>
					<div id="map" style="width:95%;height:450px;border:1px solid #ccc;" tabindex="2"></div>
				</li>
				<!-- // 지도영역 -->
   				<li>
   					<div>
   						<form name="frmSearch" id="frmSearch" method="post">
   						<input type="hidden" name="strPage" id="strPage">
						<input type="hidden" name="strPageBlock" id="strPageBlock" value="5">
						<div>
							<span>
								<label for='strSelFg'></label>
								<select name='strSelFg' id='strSelFg' class='fa'>
									<option value="FC_NAME" <%if("FC_NAME".equals(strSelFg)){ out.println("selected");} %>>센터명</option>
									<option value="FC_TELN" <%if("FC_TELN".equals(strSelFg)){ out.println("selected");} %>>연락처</option>
									<option value="FC_ADDR" <%if("FC_ADDR".equals(strSelFg)){ out.println("selected");} %>>주소</option>
								</select></span><!-- 
							--><span><input type='text' name='strSelVal' id='strSelVal' class='fb chain_search'></span><!--
							--><span><input type='text' value='검색' class='fc' onclick='search();'></span>
						</div>
   						</form>
   					</div>
   					<div style="overflow:auto;width:100%; height:450px;" class="search_list" tabindex="1">
	   					<div class='list'></div>
						<div id="pagination"></div>
					</div>
   				</li>
   			</ul>
   		</div>
	</div>
	<div class="section main-section-4">
		<img src='../images/main/logo4sub.png' class='subheading_img'/>
   		<div class='subheading'>창업비용</div>
   		<div><img src='../images/chain/type.png' width='90%'></div>
   		<!-- table>
  			<tr>
  				<th class='topline'>평수</th>
  				<td class='topline'>50평</td>
  				<td class='topline'>60평</td>
  				<td class='topline'>70평</td>
  			</tr>
    		<tr>
  				<th>도면사진</th>
  				<td><img src="../images/chain/floor_plan_50.jpg" width='100%'></td>
  				<td><img src="../images/chain/floor_plan_60.jpg" width='100%'></td>
  				<td><img src="../images/chain/floor_plan_70.jpg" width='100%'></td>
  			</tr> 
  			<tr>
  				<th>비용</th>
  				<td>155,000,000원</td>
  				<td>175,000,000원</td>
  				<td>195,000,000원</td>
  			</tr>		
  		</table -->

  		<ul>
  			<li>센터 환경에 따라 공사 인테리어 비용이 변동될 수 있음</li>
  			<li>소방, 전기증설, 냉난방 공사(평수 크기 비례)시 별도 책정</li>
  			<li>임대보증금, 계약시 중개수수료는 점주님 별로 납부 진행</li>
			<li>멀티자판기, 커피자판기 등 협력업체 계약금 별도 진행</li>
  		</ul>

	</div>
	<div class="section main-section-5">
		<img src='../images/main/logo4sub.png' class='subheading_img'/>
   		<div class='subheading s'>비에이블스터디카페 가맹문의</div>
		<div class='phone'><img src='../images/chain/phone.png'> 1544-8306</div>
		<div class='email'><a href='mailto:beablestudy@naver.com'>beablestudy@naver.com</a></div>

		<div class='form'>
			<form name='frmEnt' id='frmEnt' method='post'>
			<ul>
				<li>
					<label for='f_name'>이름</label>
					<input type='text' id='f_name' name='f_name' class='half' maxlength='15'>
				</li>
				<li>
					<label for='f_mail'>이메일</label>
					<table>
						<tr>
							<td><input type='text' id='f_mail' name='f_mail' maxlength='20'></td>
							<td class='at'>@</td>
							<td><input type='text' id='f_mail_domain' name='f_mail_domain' maxlength='30'></td>
						</tr>
					</table>
				</li>
				<li>
					<label for='f_phone'>연락처</label>
					<input type='text' id='f_phone' name='f_phone' class='half' maxlength='3' onkeypress='numberOnly(this);'>
				</li>
				<li class='textarea'><textarea id="f_bigo" name='f_bigo' maxlength='250'></textarea></li>
			</ul>
			</form>
			<div class='btn'>신청</div>
		</div> 
		 
	</div>
	<div class='section'></div> 
</div>

<script>
			     
var positions =  [<%=sb.toString() %>] 

var mapContainer = document.getElementById('map'), // 지도를 표시할 div
    mapOption = { 
        center: new daum.maps.LatLng(37.557116552265875,126.86434741907806), // 지도의 중심좌표
        level: 9 // 지도의 확대 레벨
    };
  
// 지도를 생성합니다        
var map = new daum.maps.Map(mapContainer, mapOption); 

//지도, 스카이뷰    
var mapTypeControl = new daum.maps.MapTypeControl();
    map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);

//ZOOM    
var zoomControl = new daum.maps.ZoomControl();
map.addControl(zoomControl, daum.maps.ControlPosition.BOTTOMRIGHT);    
    
var imageSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png', // 마커이미지의 주소입니다    
    imageSize = new daum.maps.Size(24, 35), // 마커이미지의 크기입니다
    imageOption = {offset: new daum.maps.Point(13, 40)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.    

// 지도 위에 마커를 표시합니다
for (var i = 0, len = positions.length; i < len; i++) {
    // 마커를 생성하고 지도위에 표시합니다
    addMarker(positions[i].latlng, positions[i].content);
}   
  
// 마커를 생성하고 지도 위에 표시하고, 마커에 mouseover, mouseout, click 이벤트를 등록하는 함수입니다
function addMarker(position, content) {         
   // 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
	var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imageOption);    	
    
    // 마커를 생성하고 이미지는 기본 마커 이미지를 사용합니다
    var marker = new daum.maps.Marker({
        map: map,
        position: position,
        image: markerImage
    });    
    
    //커스텀오버레이 생성
    var customOverlay = new daum.maps.CustomOverlay({
        map: map,
        position: marker.getPosition(),             
        //content: content,
        clickable: true,
        yAnchor: 5
    }); 
  
    customOverlay.setContent(content);
    customOverlay.setMap(null);
        
    // 마커에 click 이벤트를 등록합니다
    daum.maps.event.addListener(marker, 'click', function() {
        setCenter(position);
		customOverlay.setMap(map);        
        daum.maps.event.preventMap();
    });
    
    daum.maps.event.addListener(map, 'click', function(mouseEvent) {        
        // 클릭한 위치에 마커를 표시합니다 
        customOverlay.setMap('');          
    });    
}
    
function setCenter(position) {
    // 이동할 위도 경도 위치를 생성합니다 
    var moveLatLon = position;
    
    // 지도 중심을 이동 시킵니다
    map.panTo(moveLatLon);
}

function setLocMove(x, y) {
	var goLoc = new daum.maps.LatLng(x,y);
	setCenter(goLoc);
}

function goSearch(){
	$.get( "./mapListProc.jsp?strLocCode="+loc, function(data) {
		alert(data);
		var json = JSON.parse($.trim(data));
		if(json.isSuccess) {
			var goLoc = new daum.maps.LatLng(json.strCoodinate);
			setCenter(goLoc);
		} else {
			console.log("데이터 없냐옹");
		}
	})
	.error(function(){
		console.log("카카오api 연동중...오류");
	});		
}



$(document).ready(function() {
	
	//가맹문의 신청
	$(".btn").click(function(){
		if (!fnRegChk()) {
			return;
		} else {
			alertify.confirm("신청을 하시겠습니까?", function (e) {
				if (e) {
					$.post("./contactProc.jsp", $("#frmEnt").serialize(), function(data){
						var json = JSON.parse($.trim(data));
						if(json.isSuccess) {
							location.href = json.resUrl;
						} else {
							alertify.alert(json.resMsg);
						}
					})
					.error(function(){
						alertify.alert("신청서 제출중 오류가 발생하였습니다. \n시스템 관리자에게 문의하세요.");
					});
				}
			});
		}
    });
	
});

function fnRegChk() {
	
	//이름
	if (!checkLength($('#f_name'), 1, 15)) {
		alertify.alert('이름을 입력해 주세요.');
		$('#f_name').css('background-color' ,'#fee');
		$('#f_name').focus();
		return false;
	} else $('#f_name').css('background-color' ,'#fff');
	
	//이메일주소
	if (!checkLength($('#f_mail'), 1, 20)) {
		alertify.alert('이메일을 입력해 주세요.');
		$('#f_mail').css('background-color' ,'#fee');
		$('#f_mail').focus();
		return false;
	} else $('#f_mail').css('background-color' ,'#fff');
	
	//도메인
	if (!checkLength($('#f_mail_domain'), 1, 30)) {
		alertify.alert('이메일 도메인을 입력해 주세요.');
		$('#f_mail_domain').css('background-color' ,'#fee');
		$('#f_mail_domain').focus();
		return false;
	} else $('#f_mail_domain').css('background-color' ,'#fff');
	
	//연락처
	if (!checkLength($('#f_phone'), 1, 13)) {
		alertify.alert('연락처를 입력해 주세요.');
		$('#f_phone').css('background-color' ,'#fee');
		$('#f_phone').focus();
		return false;
	} else $('#f_phone').css('background-color' ,'#fff');
	
	//비고
	if (!checkLength($('#f_bigo'), 1, 250)) {
		alertify.alert('문의사항을 입력해 주세요.');
		$('#f_bigo').css('background-color' ,'#fee');
		$('#f_bigo').focus();
		return false;
	} else $('#f_bigo').css('background-color' ,'#fff');
	
	return true;
}

</script>

<script src='onloaded.js?0.4'></script>


<jsp:include page="../inc/Footer.v2.jsp" flush="false">
	<jsp:param name="param" value=""/>
</jsp:include>


<%@page contentType="text/html;charset=utf-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "kr.co.beable.chain.*" %>
<%
	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
	
	String strTitle 	= "";
	String strLocation 	= "";
	int tot_cnt			= 0;
	
	ArrayList<ChainVO.reqLocationTapVO> arr = new ChainBean().FC_LOCATION_TAP_PROC("");
	if(arr != null && arr.size() > 0) {
		tot_cnt = Integer.parseInt(arr.get(0).TOT_CNT);
	}
	
	StringBuffer sb 			= new StringBuffer();

	ArrayList<ChainVO.reqLocationMapVO> arrMap = new ChainBean().FC_LOCATION_MAP_PROC();
	if(arrMap != null && arrMap.size() > 0){
		
		String comma	 = ",";
		
		for(int i=0; i<arrMap.size(); i++){
			
			if(i == (arrMap.size()-1)) comma = "";
			
			ChainVO.reqLocationMapVO vo = (ChainVO.reqLocationMapVO)arrMap.get(i);
			
			sb.append("{content:\n");
			sb.append("	'<div class=\"wrap\">'+\n");
			sb.append("		'<div class=\"info\">'+\n");
			sb.append("			'<div class=\"title\">"+vo.FC_NM+"</div>'+\n");
			sb.append("			'<div class=\"body\">'+\n");
// 			sb.append("				'<div class=\"img\">'+\n");
// 			sb.append("                '<img src=\""+vo.FC_THUMBNAIL+"\" width=\"73\" height=\"70\">'+\n");
// 			sb.append("           	'</div>'+\n");
			sb.append("				'<div class=\"desc\">'+\n");
			sb.append("					'<div class=\"ellipsis\">"+vo.FC_ADDR+"</div>'+\n");
			sb.append("					'<div class=\"jibun ellipsis\">"+vo.FC_MAIN_TEL_NO+"</div>'+\n");
			sb.append("					'<div><a href=\""+vo.FC_HOMEPAGE+"\" target=\"_blank\" class=\"link\">홈페이지</a></div>'+\n");
			sb.append("				'</div>'+\n");
			sb.append("			'</div>'+\n");
			sb.append("		'</div>'+\n");
			sb.append("	'</div>'\n");
			sb.append(",");
			sb.append("latlng:new daum.maps.LatLng("+vo.FC_COORDINATE+")");
			sb.append("}" + comma);
		}
	}
	
%>
<jsp:include page="../inc/Header.v2.jsp" flush="false">
	<jsp:param name="title" value="<%=java.net.URLEncoder.encode(strTitle, java.nio.charset.StandardCharsets.UTF_8.toString())%>"/>
	<jsp:param name="location" value="<%=java.net.URLEncoder.encode(strLocation, java.nio.charset.StandardCharsets.UTF_8.toString()) %>"/>
</jsp:include>
<style>
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
    
    .main-section-3 div>ul>li>div>span {
	   display:inline-block;font-size:0.8em;padding:10px 4.5px;background-color:#fff;border:1px solid #ccc;border-right:0;
	   width:calc(95%/<%=tot_cnt%> - 10px);
	   text-align:center;cursor:pointer;
	}
	.main-section-3 div>ul>li>div>span:hover {background-color:orange;}
	.main-section-3 div>ul>li>div>span:last-child {border-right:1px solid #ccc;}
</style>
<link rel='stylesheet' href='chain.css?0.1.0.18' />
<script src='https://rawgit.com/alvarotrigo/fullPage.js/dev/src/fullpage.js'></script>

<div id="fullpage">
	<div class="section main-section-2" tabindex="1">
    	<div class='slideup'>
    		<img src='../images/main/logo4sub.png' class='subheading_img'/>
    		<div class='subheading'>개설절차</div>
    		<div><img src='../images/chain/process.png' width="70%"></div>
    	</div>	
	</div>
	<div class="section main-section-3">
		<img src='../images/main/logo4sub.png' class='subheading_img'/>
   		<div class='subheading'>센터현황</div>	
   		<div>
   			<ul>
   				<!-- 지도영역 --> 
   				<li>
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
           					
           					ChainVO.reqLocationTapVO vo = (ChainVO.reqLocationTapVO)arr.get(i);
           					out.println(strTag_last+"<span><a href=\"javascript:setLocMove('"+vo.MM_LOC_LATITUDE+"','"+vo.MM_LOC_LONGITUDE+"');\">"+vo.MM_LOC_NM+" ("+vo.CNT+")</a></span>"+strTag_first);
           				}
					}
                  	%>
                  	</div>
	   				<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dab0208119ff46e1af518efed56ac285"></script>
					<div id="map" style="width:95%;height:450px;border:1px solid #ccc;" tabindex="2"></div>
				</li>
				<!-- // 지도영역 -->
   				<li>
   					<div><input type='text' class='chain_search' id='chain_search'></div>
   					<div style="overflow:auto;width:100%; height:450px;" class="search_list" tabindex="1">
	   					<table>
	   						<tr>
					        	<td rowspan="4" class='pic underline'><img src='../images/space/bangbae.jpg'></td>
					        	<td colspan="2">하계 센터</td>
					        </tr>
							<tr>
					        	<th>주소</th>
					        	<td class='detail'>서울특별시 강서구 양천로 583</td>
					        </tr>
					        <tr>
					        	<th>전화번호</th>
					        	<td class='detail'>000000</td>
					        </tr>
					        <tr>
					        	<th class='underline'>홈페이지</th>
					        	<td class='detail underline'>www.beablekorea.com</td>
					     	</tr>
						</table>
						<table>
	   						<tr>
					        	<td rowspan="4" class='pic underline'><img src='../images/space/bangbae.jpg'></td>
					        	<td colspan="2">하계 센터</td>
					        </tr>
							<tr>
					        	<th>주소</th>
					        	<td class='detail'>서울특별시 강서구 양천로 583</td>
					        </tr>
					        <tr>
					        	<th>전화번호</th>
					        	<td class='detail'>000000</td>
					        </tr>
					        <tr>
					        	<th class='underline'>홈페이지</th>
					        	<td class='detail underline'>www.beablekorea.com</td>
					     	</tr>
						</table>
						<table>
	   						<tr>
					        	<td rowspan="4" class='pic underline'><img src='../images/space/bangbae.jpg'></td>
					        	<td colspan="2">하계 센터</td>
					        </tr>
							<tr>
					        	<th>주소</th>
					        	<td class='detail'>서울특별시 강서구 양천로 583</td>
					        </tr>
					        <tr>
					        	<th>전화번호</th>
					        	<td class='detail'>000000</td>
					        </tr>
					        <tr>
					        	<th class='underline'>홈페이지</th>
					        	<td class='detail underline'>www.beablekorea.com</td>
					     	</tr>
						</table>
						<table>
	   						<tr>
					        	<td rowspan="4" class='pic underline'><img src='../images/space/bangbae.jpg'></td>
					        	<td colspan="2">하계 센터</td>
					        </tr>
							<tr>
					        	<th>주소</th>
					        	<td class='detail'>서울특별시 강서구 양천로 583</td>
					        </tr>
					        <tr>
					        	<th>전화번호</th>
					        	<td class='detail'>000000</td>
					        </tr>
					        <tr>
					        	<th class='underline'>홈페이지</th>
					        	<td class='detail underline'>www.beablekorea.com</td>
					     	</tr>
						</table>
						<table>
	   						<tr>
					        	<td rowspan="4" class='pic underline'><img src='../images/space/bangbae.jpg'></td>
					        	<td colspan="2">하계 센터</td>
					        </tr>
							<tr>
					        	<th>주소</th>
					        	<td class='detail'>서울특별시 강서구 양천로 583</td>
					        </tr>
					        <tr>
					        	<th>전화번호</th>
					        	<td class='detail'>000000</td>
					        </tr>
					        <tr>
					        	<th class='underline'>홈페이지</th>
					        	<td class='detail underline'>www.beablekorea.com</td>
					     	</tr>
						</table>
	   					<table>
	   						<tr>
					        	<td rowspan="4" class='pic underline'><img src='../images/space/banpo.jpg'></td>
					        	<td colspan="2">하계 센터</td>
					        </tr>
							<tr>
					        	<th>주소</th>
					        	<td class='detail'>서울특별시 강서구 양천로 583</td>
					        </tr>
					        <tr>
					        	<th>전화번호</th>
					        	<td class='detail'>000000</td>
					        </tr>
					        <tr>
					        	<th>홈페이지</th>
					        	<td class='detail'>www.beablekorea.com</td>
					     	</tr>
						</table>
					</div>
   				</li>
   			</ul>
   		</div>
	</div>
	<div class="section main-section-4">
		<img src='../images/main/logo4sub.png' class='subheading_img'/>
   		<div class='subheading'>창업비용</div>
   		<table>
  			<tr>
  				<th class='topline'>평수</th>
  				<td class='topline'>50평</td>
  				<td class='topline'>100평</td>
  				<td class='topline'>80,000평</td>
  			</tr>
    		<tr>
  				<th>도면사진</th>
  				<td><img src="../images/chain/floor_plan.jpg" width='100%'></td>
  				<td><img src="../images/chain/floor_plan.jpg" width='100%'></td>
  				<td><img src="../images/chain/floor_plan.jpg" width='100%'></td>
  			</tr> 
  			<tr>
  				<th>비용</th>
  				<td>1,000만원</td>
  				<td>2,000만원</td>
  				<td>5,000만원</td>
  			</tr>		
  		</table>

  		<ul>
  			<li>센터 환경에 따라 공사 인테리어 비용이 변동될 수 있음</li>
  			<li>소방, 전기증설, 냉난방 공사(평수 크기 비례)시 별도 책정</li>
  			<li>임대보증금, 계약시 중개수수료는 점주님 별로 납부로 진행</li>
			<li>협력업체 계약금 별도 진행</li>
  		</ul>

	</div>
	<div class="section main-section-5">
		<img src='../images/main/logo4sub.png' class='subheading_img'/>
   		<div class='subheading s'>비에이블스터디카페 가맹문의</div>
		<div class='phone'>☎ 1544-8306</div>
		<div class='email'><a href='mailto:beablestudy@naver.com'>beablestudy@naver.com</a></div>

		<div class='form'>
			<form name='frmEnt' id='frmEnt'>
			<ul>
				<li>
					<label for='f_name'>이름</label>
					<input id='f_name' type='text' class='half'>
				</li>
				<li>
					<label for='f_mail'>이메일</label>
					<table>
						<tr>
							<td><input id='f_mail' type='text'></td>
							<td class='at'>@</td>
							<td><input id='f_mail_domain' type='text'></td>
							<td><select>	<option>직접입력</option></select></td>
						</tr>
					</table>
				</li>
				<li>
					<label for='f_phone'>연락처</label>
					<input id='f_phone' type='text' class='half'>
				</li>
				<li class='textarea'><textarea></textarea></li>
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
        level: 10 // 지도의 확대 레벨
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


</script>

<script src='onloaded.js?0.2'></script>
<script>
</script>>
<div style='height:300px;'></div>


<jsp:include page="../inc/Footer.v2.jsp" flush="false">
	<jsp:param name="param" value=""/>
</jsp:include>


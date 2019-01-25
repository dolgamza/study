<%@page contentType="text/html;charset=utf-8"%>
<%
String strTitle = "비에이블";
String strLocation = String.format("<a href='%s/'>홈</a> / <a href=%s/cafe/'>홈비에이블스터디카페</a> / <a href='$s/cafe/'>소개</a>", application.getContextPath(), application.getContextPath(), application.getContextPath());
%>
<jsp:include page="../inc/Header.jsp" flush="false">
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
</style>
	<div id="articlecontent">

		<div id="comment">비에이블코리아(주) 오시는 길 안내입니다.</div>
		<div>경기</div>
			<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dab0208119ff46e1af518efed56ac285"></script>
			<div id="map" style="width:100%;height:350px;"></div>
			<a href="javascript:aa(1)">서울</a>
			<script>
			     
			var positions = [
			    {
			        content: '<div class="wrap">' +
			                 '    <div class="info">' + 
			                 '        <div class="title">' +
			                 '            카카오 0' +                 
			                 '        </div>' +
			                 '        <div class="body">' +                  
			                 '            <div class="desc">' +
			                 '                <div class="ellipsis">제주특별자치도 제주시 첨단로 242</div>' +
			                 '                <div class="jibun ellipsis">(우) 63309 (지번) 영평동 2181</div>' +
			                 '                <div><a href="http://www.kakaocorp.com/main" target="_blank" class="link">홈페이지</a></div>' +
			                 '            </div>' +
			                 '        </div>' + 
			                 '    </div>' +
			                 '</div>',        
			        latlng: new daum.maps.LatLng(37.557116, 126.864347)
			    },
			    {
			        content: '<div class="wrap">' +
			                 '    <div class="info">' + 
			                 '        <div class="title">' +
			                 '            카카오 1' +                 
			                 '        </div>' +
			                 '        <div class="body">' +
			                 '            <div class="img">' +
			                 '                <img src="http://cfile181.uf.daum.net/image/250649365602043421936D" width="73" height="70">' +
			                 '            </div>' +
			                 '            <div class="desc">' +
			                 '                <div class="ellipsis">제주특별자치도 제주시 첨단로 242</div>' +
			                 '                <div class="jibun ellipsis">(우) 63309 (지번) 영평동 2181</div>' +
			                 '                <div><a href="http://www.kakaocorp.com/main" target="_blank" class="link">홈페이지</a></div>' +
			                 '            </div>' +
			                 '        </div>' + 
			                 '    </div>' +
			                 '</div>', 
			        latlng: new daum.maps.LatLng(37.549137, 126.939702)
			    }
			    ,
			    {
			        content: '<div class="wrap">' +
			                 '    <div class="info">' + 
			                 '        <div class="title">' +
			                 '            카카오 2' +                 
			                 '        </div>' +
			                 '        <div class="body">' +
			                 '            <div class="img">' +
			                 '                <img src="http://cfile181.uf.daum.net/image/250649365602043421936D" width="73" height="70">' +
			                 '            </div>' +
			                 '            <div class="desc">' +
			                 '                <div class="ellipsis">제주특별자치도 제주시 첨단로 242</div>' +
			                 '                <div class="jibun ellipsis">(우) 63309 (지번) 영평동 2181</div>' +
			                 '                <div><a href="http://www.kakaocorp.com/main" target="_blank" class="link">홈페이지</a></div>' +
			                 '            </div>' +
			                 '        </div>' + 
			                 '    </div>' +
			                 '</div>', 
			        latlng: new daum.maps.LatLng(37.524693, 126.873324)
			    }
			]  
			
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div
			    mapOption = { 
			        center: new daum.maps.LatLng(37.557116, 126.864347), // 지도의 중심좌표
			        level: 8 // 지도의 확대 레벨
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
				alert(position);
			    // 이동할 위도 경도 위치를 생성합니다 
			    var moveLatLon = position;
			    
			    // 지도 중심을 이동 시킵니다
			    map.panTo(moveLatLon);
			}
			
			function aa(num){
				//Json 던지기
				if(num==1) {
					 var moveLatLon = new daum.maps.LatLng(37.557116, 126.864347);
					 setCenter(moveLatLon);
				}
			}
			
			</script>
 		 
	</div>
<jsp:include page="../inc/Footer.jsp" flush="false">
	<jsp:param name="enableLocation" value="1"/>
	<jsp:param name="enableScrollEvent" value="1"/>
</jsp:include>

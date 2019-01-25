<%@page contentType="text/html;charset=utf-8"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);

String strTitle = "";
String strLocation = "";
%>
<jsp:include page="../inc/Header.v2.jsp" flush="false">
	<jsp:param name="title" value="<%=java.net.URLEncoder.encode(strTitle, java.nio.charset.StandardCharsets.UTF_8.toString())%>"/>
	<jsp:param name="location" value="<%=java.net.URLEncoder.encode(strLocation, java.nio.charset.StandardCharsets.UTF_8.toString()) %>"/>
</jsp:include>

<link rel='stylesheet' href='customer.css?0.1.0.4' />

<div id="fullpage">
	<div class="section main-section-2">
    	<div class='slideup'>
    		<img src='../images/main/logo4sub.png' class='subheading_img'/>
    		<div class='subheading'>이용방법</div>
    		<div class='title'>_키오스크 이용방법</div>
    		<div class='detail'>
    			<ol>
    					<li>1~2시간 이용하셔도 회원카드는 발급받으셔야 합니다.</li>
    					<li>4주 회원권, 금액권, ...</li>
    					<li>퇴실</li>
    					<li>퇴실</li>
    					<li>퇴실</li>
    				</ol>
	    		</div>
    	</div>	
	</div>
	<div class="section main-section-3">
		<div class='slide kiosk'>
			<ul>
		   		<li>
		   			<div>
		   				<span>1</span>
		   				<span>&lt;회원카드 발급 터치&gt;</span><br/>
		   				<img src='../images/customer/k_01.jpg'>
		   				<div>회원카드발급 버튼을 터치하여 카드를 발급받습니다.</div>
		   			</div>
		   		</li>
		   		<li>
		   			<div>
		   				<span>2</span>
		   				<span>&lt;회원카드 발급 터치&gt;</span><br/>
		   				<img src='../images/customer/k_02.jpg'>
		   				<div>회원카드발급 버튼을 터치하여 카드를 발급받습니다.회원카드발급 버튼을 터치하여 카드를 발급받습니다.</div>
		   			</div>
		   		</li>
		   		<li>
		   			<div>
		   				<span>3</span>
		   				<span>&lt;회원카드 발급 터치&gt;</span><br/>
		   				<img src='../images/customer/k_03.jpg'>
		   				<div>회원카드발급 버튼을 터치하여 카드를 발급받습니다.</div>
		   			</div>
		   		</li>
		   		<li>
		   			<div>
		   				<span>4</span>
		   				<span>&lt;전화번호 입력&gt;</span><br/>
		   				<img src='../images/customer/k_04.jpg'>
		   				<div>전화번호를 통해 입출입문자, 퇴실알림문자 서비스 발송, 다양한 이벤트 및 연락의 수단 분실시 이용객과의 소통을 위해 필요한 절차입니다.</div>
		   			</div>
		   		</li>
		   		<li>
		   			<div>
		   				<span>5</span>
		   				<span>&lt;회원카드 발급 터치&gt;</span><br/>
		   				<img src='../images/customer/k_05.jpg'>
		   				<div>회원카드발급 버튼을 터치하여 카드를 발급받습니다.</div>
		   			</div>
		   		</li>
		   		<li>
		   			<div>
		   				<span>6</span>
		   				<span>&lt;회원카드 발급 터치&gt;</span><br/>
		   				<img src='../images/customer/k_06.jpg'>
		   				<div>회원카드발급 버튼을 터치하여 카드를 발급받습니다.</div>
		   			</div>
		   		</li>
	   		</ul>
   		</div>
	</div>
	<div class="section main-section-4">
   		<div class='title'>_스터디룸 이용방법</div>
   		<div class='slide studyroom'>
			<ul>
		   		<li>
		   			<div>
		   				<span>1</span>
		   				<span>&lt;회원카드 발급 터치&gt;</span><br/>
		   				<img src='../images/customer/k_01.jpg'>
		   				<div>회원카드발급 버튼을 터치하여 카드를 발급받습니다.</div>
		   			</div>
		   		</li>
		   		<li>
		   			<div>
		   				<span>2</span>
		   				<span>&lt;2/4/6인실 중 선택&gt;</span><br/>
		   				<img src='../images/customer/k_05.jpg'>
		   				<div>회원카드발급 버튼을 터치하여 카드를 발급받습니다. 회원카드발급 버튼을 터치하여 카드를 발급받습니다. 회원카드발급 버튼을 터치하여 카드를 발급받습니다.</div>
		   			</div>
		   		</li>
		   		<li>
		   			<div>
		   				<span>3</span>
		   				<span>&lt;시간 선택&gt;</span><br/>
		   				<img src='../images/customer/sr_03.jpg'>
		   				<div>회원카드발급 버튼을 터치하여 카드를 발급받습니다.</div>
		   			</div>
		   		</li>
		   	</ul>
	   	</div>
	</div>
	<div class="section main-section-5">
		<img src='../images/main/logo4sub.png' class='subheading_img'/>
   		<div class='subheading'>센터찾기</div>
		<div class='all'>
   			<div class='title'>_전체센터</div>
   			<div class='list'>
	   			<table>
	   				<tr>
	   					<td colspan='2'>서울</td>
	   				</tr>
	   				<tr>
	   					<th>강서구</th>
	   					<td class='chains'>등촌, 화곡</td>
	   				</tr>
	   				<tr>
	   					<th>강서구</th>
	   					<td class='chains'>등촌, 화곡</td>
	   				</tr>
	   				<tr>
	   					<th>강서구</th>
	   					<td class='chains'>등촌, 화곡</td>
	   				</tr>
	   				<tr>
	   					<th>강서구</th>
	   					<td class='chains'>등촌, 화곡</td>
	   				</tr>
	   				<tr>
	   					<th>강서구</th>
	   					<td class='chains'>등촌, 화곡</td>
	   				</tr>
	   				<tr>
	   					<th>강서구</th>
	   					<td class='chains'>등촌, 화곡</td>
	   				</tr>
	   				<tr>
	   					<th>강서구</th>
	   					<td class='chains'>등촌, 화곡</td>
	   				</tr>
	   				<tr>
	   					<th>강서구</th>
	   					<td class='chains'>등촌, 화곡</td>
	   				</tr>
	   				<tr>
	   					<th>강서구</th>
	   					<td class='chains'>등촌, 화곡</td>
	   				</tr>
	   				<tr>
	   					<th>강서구</th>
	   					<td class='chains'>등촌, 화곡</td>
	   				</tr>
	   				<tr>
	   					<th>강서구</th>
	   					<td class='chains'>등촌, 화곡</td>
	   				</tr>
	   				<tr>
	   					<th>강서구</th>
	   					<td class='chains'>등촌, 화곡</td>
	   				</tr>
	   				<tr>
	   					<th>강서구</th>
	   					<td class='chains'>등촌, 화곡</td>
	   				</tr>
	   				<tr>
	   					<th>강서구</th>
	   					<td class='chains'>등촌, 화곡</td>
	   				</tr>
	   				<tr>
	   					<th>강서구</th>
	   					<td class='chains'>등촌, 화곡</td>
	   				</tr>
	   				<tr>
	   					<th>강서구</th>
	   					<td class='chains'>등촌, 화곡</td>
	   				</tr>
	   				<tr>
	   					<th>강서구</th>
	   					<td class='chains'>등촌, 화곡</td>
	   				</tr>
	   				<tr>
	   					<th>강서구</th>
	   					<td class='chains'>등촌, 화곡</td>
	   				</tr>
	   				<tr>
	   					<th>강서구</th>
	   					<td class='chains'>등촌, 화곡</td>
	   				</tr>
	   				<tr>
	   					<th>강서구</th>
	   					<td class='chains'>등촌, 화곡</td>
	   				</tr>
	   				<tr>
	   					<th>강서구</th>
	   					<td class='chains'>등촌, 화곡</td>
	   				</tr>
	   				<!--  add last class at last row -->
	    			<tr>
	   					<th class='last'>강서구</th>
	   					<td class='chains last'>등촌, 화곡</td>
	   				</tr>  				
	   				
	   			</table>
	   		</div>
   		</div>
   		<div class='search'>

			<div><input type='text' class='chain_search'></div>
			<div class='list'>
 				<table>
 				<tr>
		        	<td rowspan="4" class='pic underline'><img src='../images/space/bangbae.jpg'></td>
		        	<td colspan="2">하계 센터</td>
		        </tr>
				<tr>
		        	<th>주소</th>
		        	<td class='chains'>서울특별시 강서구 양천로 583</td>
		        </tr>
		        <tr>
		        	<th>전화번호</th>
		        	<td class='chains'>000000</td>
		        </tr>
		        <tr>
		        	<th>홈페이지</th>
		        	<td class='chains underline'>www.beablekorea.com</td>
		     	</tr>
				</table>
 				<table>
 				<tr>
		        	<td rowspan="4" class='pic underline'><img src='../images/space/banpo.jpg'></td>
		        	<td colspan="2">하계 센터</td>
		        </tr>
				<tr>
		        	<th>주소</th>
		        	<td class='chains'>서울특별시 강서구 양천로 583</td>
		        </tr>
		        <tr>
		        	<th>전화번호</th>
		        	<td class='chains'>000000</td>
		        </tr>
		        <tr>
		        	<th>홈페이지</th>
		        	<td class='chains underline'>www.beablekorea.com</td>
		     	</tr>
				</table>
			</div>
   		</div>
	</div>
</div>

<!-- slide show event -->
<script src='onloaded.js?02'></script>

<jsp:include page="../inc/Footer.v2.jsp" flush="false">
	<jsp:param name="param" value=""/>
</jsp:include>


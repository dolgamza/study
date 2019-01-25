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

<style>
body {color:#777;}
.rooptop {position:relative;}
.footer {display:none;}

a {text-decoration:none;color:#000;}
a:visited {color:#555;}
a:hover {color:#80191f;}

.back {position:absolute;color:#80191f;font-size:1.4em;top:73px;left:20px;cursor:pointer;}

.section div {width:90%;margin-left:auto;margin-right:auto;margin-bottom:5px;}
.section div.title {margin-top:20px;text-align:center;color:#80191f;font-size:1.4em;margin-bottom:50px;}
.section div.subtitle {margin-top:20px;text-align:left;color:#80191f;font-size:1em;margin-bottom:10px;}

select.fa {width:calc(30% - 17px);}
input.fb {width:calc(50% - 0px);margin:5px;}
input.fc {width:calc(20% - 27px);background-color:#80191f;text-align:center;color:white;padding-right:10px;cursor:pointer;}
.chain_search {margin-bottom:8px;background:url('../images/m.png') no-repeat;background-position:calc(100% - 10px);}

div.list {width:90%;}
.section table {width:100%;margin:2px;}
.section td {background-color:white;border-top:1px solid #ccc;}
.section td.pic {width:160px;height:160px;padding:0;text-align:left;vertical-align:top;}
.section td img {width:100%;height:100%;}
.section td a {color:#80191f;}
.section .chains {text-align:left;color:#000;}

/* responsive web */
@media only screen and (max-width : 1040px) {
.section td.pic {width:120px;height:120px;}
}
</style>

<script>
function goBack() {
	location.href='../membership/login.jsp';
}

function search() {
	alert('sfasdfasf?');
}

</script>

<div class='back' onclick='goBack();'>&lt;</div>
<div class='section'>
   		<div class='title'>센터 검색</div>	

		<form>
		<div>
				<span><label for='f_cls'></label>
					<select id='f_cls' class='fa'>
						<option>센터명</option>
					</select></span><!--  
				--><span><input type='text' id='b' value='' class='fb chain_search'></span><!--  
				--><span><input type='text' id='b' value='검색' class='fc' onclick='search();'></span>
		</div>

		</form>

		<div class='list'>

				<table>
 				<tr>
		        	<td rowspan="3" class='pic'><img src='../images/space/bangbae.jpg'></td>
		        	<td colspan="2" class='chains'><a href='center_detail.jsp'>방배 센터</a></td>
		        </tr>
				<tr>
		        	<td class='chains'>서울특별시 강서구 양천로 583</td>
		        </tr>
		        <tr>
		        	<td class='chains'>000000</td>
		        </tr>
				</table>
 				<table>
 				<tr>
		        	<td rowspan="3" class='pic'><img src='../images/space/banpo.jpg'></td>
		        	<td colspan="2" class='chains'><a href='center_detail.jsp'>반포 센터</a></td>
		        </tr>
				<tr>
		        	<td class='chains'>서울특별시 강서구 양천로 583</td>
		        </tr>
		        <tr>
		        	<td class='chains'>000000</td>
		        </tr>
				</table>	
				
				<table>
				<tr><td colspan="3" style="height:150px;">검색 결과가 없습니다.</td>
				</table>
		
		
		
		</div>
</div>


<jsp:include page="../inc/Footer.v2.jsp" flush="false">
	<jsp:param name="param" value=""/>
</jsp:include>


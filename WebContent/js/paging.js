function getPaging(intCurrentPage, intTotalRowNum, intRowCntPerPage, intPageBlockSize, strFunc) {
	var strReturn           = "";
	var strReplace          = "";
	var intVirtualStartPage = 0;
	var intVirtualEndPage   = 0;
	var intVirtualPrevPage  = 0;
	var intVirtualNextPage  = 0;
	var intFinalPage        = parseInt(intTotalRowNum/intRowCntPerPage);
	var intRest             = intTotalRowNum%intRowCntPerPage;

	if (intRest==0) { }
	else { intFinalPage = intFinalPage+1; }

	// for mobile version
	if ($(window).width()<700) {
		intPageBlockSize = 10;
	}
	
	if (intCurrentPage>intPageBlockSize) {
		intVirtualStartPage = parseInt(((intCurrentPage-1)/intPageBlockSize))*intPageBlockSize+1;
		intVirtualPrevPage  = intVirtualStartPage-1;
	}
	else { intVirtualStartPage = 1; }

	intVirtualEndPage = intVirtualStartPage + intPageBlockSize - 1;
	if (intVirtualEndPage>=intFinalPage) { intVirtualEndPage = intFinalPage; }
	else { intVirtualNextPage = intVirtualEndPage+1; }

	strReturn = "<div id='paging'>\n";

	if (intVirtualPrevPage>0) {
		strReturn += "<a href='javascript:"+strFunc+"("+intVirtualPrevPage+");' title='이전목록'><img src='data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAwAAAAMCAYAAABWdVznAAAAZklEQVR42mNgwA3EgLgZiM0ZiAS5QPwBiI8BsRA+hWxAHAPEv6AaUgmZnAzEH6GKg4GYCZ/JIMV/gPgTEBcSMtkLauoXII7DZzLZGkBOSkJyUgGxwUm0p8kOVpIjDgZYoX7yRBYEAC3MGylOWuu9AAAAAElFTkSuQmCC' border=0 align='absmiddle' title='이전목록' alter='이전목록'></a>&nbsp;";
	}

	strReturn += "<span>";

	for (var i=intVirtualStartPage; i<intVirtualEndPage+1; i++) {
		strReturn += (i==intCurrentPage) ? "<a href='javascript:"+strFunc+"("+i+");' class='btn on' title='현재 페이지'>"+i+"</a>" : "<a href='javascript:"+strFunc+"("+i+");' title='"+i+"번째 페이지로 이동' class='btn off'>"+i+"</a>";
	}

	strReturn += "</span>";

	if (intVirtualNextPage>0) {
		strReturn += "<a href='javascript:"+strFunc+"("+intVirtualNextPage+");' title='다음목록'><img src='data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAwAAAAMCAYAAABWdVznAAAAYklEQVR42mNgQAWeQJwExKwMRAAhID4GxB+AOJeBSJAK1fALiGOAmI2QBiYgDoZq+gjEycTaVADEn4D4D9RPRNkUB8RfoLZ5UV1DIZKTkvE5iWRPkxSsZEWcORA3A7EYLgUA6McbKWj4dawAAAAASUVORK5CYII=' border='0' align='absmiddle' title='다음목록' alter='다음목록'></a>\n";
	}

	strReturn += "</div>";
	return strReturn;
	//document.write(strReturn);
}

function fnMakPaging(intCurrentPage, intTotalRowNum, intRowCntPerPage, intPageBlockSize, strFunc) {
	$("#pagination").html(getPaging(intCurrentPage, intTotalRowNum, intRowCntPerPage, intPageBlockSize, strFunc));
}

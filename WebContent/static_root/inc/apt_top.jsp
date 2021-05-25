<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
response.setHeader("Pragma", "no-cache"); 
response.setHeader("Cache-Control", "no-cache"); 
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<META http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<meta name="format-detection" content="telephone=no" /> <!-- 익스플로러 전화번호 효과 제거 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
<title>올마이티컴퍼니</title>
<%@ include file="apt_common.jsp" %>
<link type="text/css" rel="stylesheet" href="<c:out value='${COMMON_CSS_CONF}' />/apt_common.css" media=""/><!-- 초기화/공통/레이아웃 -->
<link type="text/css" rel="stylesheet" href="<c:out value='${COMMON_CSS_CONF}' />/apt_option.css" media=""/><!-- css 옵션 -->
<link type="text/css" rel="stylesheet" href="<c:out value='${COMMON_CSS_CONF}' />/apt_bbsTable.css" media=""/><!-- 게시물/테이블 -->
<link type="text/css" rel="stylesheet" href="<c:out value='${COMMON_CSS_CONF}' />/apt_content.css" media=""/><!-- 개별컨텐츠 -->
<link type="text/css" rel="stylesheet" href="<c:out value='${COMMON_CSS_CONF}' />/apt_main.css" media=""/><!-- 메인페이지 -->
<link type="text/css" rel="stylesheet" href="<c:out value='${COMMON_CSS_CONF}' />/nyroModal.css" media=""/>


<script type="text/javascript" src="<c:out value='${COMMON_JS_CONF}' />/jquery-1.7.2.min.js" ></script>
<script type="text/javascript" src="<c:out value='${COMMON_JS_CONF}' />/jquery.form.js" ></script>
<script type="text/javascript" src="<c:out value='${COMMON_JS_CONF}' />/jquery.cookie.js" ></script>
<script type="text/javascript" src="<c:out value='${COMMON_JS_CONF}' />/jqueryPaging.js"></script><!-- 페이징  -->
<script type="text/javascript" src="<c:out value='${COMMON_JS_CONF}' />/jquery.PrintArea.js_4.js" ></script><!-- 프린트 javascript -->
<script type="text/javascript" src="<c:out value='${COMMON_JS_CONF}' />/printThis.js" ></script><!-- 프린트 javascript -->
<script type="text/javascript" src="<c:out value='${COMMON_JS_CONF}' />/valid.js"></script> <!--  공통  js  -->
<script type="text/javascript" src="<c:out value='${COMMON_JS_CONF}' />/_link.js"></script> <!--  공통  js  -->
<script type="text/javascript" src="<c:out value='${COMMON_JS_CONF}' />/fileDownLoad.js"></script> <!--  공통  js  -->
<script type="text/javascript" src="<c:out value='${COMMON_JS_CONF}' />/apt_common.js"></script> <!--  공통  js  -->
<script type="text/javascript" src="<c:out value='${COMMON_JS_CONF}' />/jquery.nyroModal.custom.js"></script> <!--  레이어  js  -->
<script type="text/javascript" src="<c:out value='${COMMON_JS_CONF}' />/calendar/jquery-ui.min.js" ></script><!-- 달력 javascript -->
<link type="text/css" rel="stylesheet" href="<c:out value='${COMMON_JS_CONF}' />/calendar/jquery-ui.css" media=""/><!-- 달력 CSS -->
<script type="text/javascript" src="<c:out value='${EDITOR_INC_URL_CONF}' />/cheditor.js" ></script><!-- cheditor 인클루드  -->
<script type="text/javascript" src="<c:out value='${COMMON_JS_CONF}' />/json2.js"></script> <!--  공통  js  -->

<%
//치환 변수 선언
pageContext.setAttribute("cn", "\n"); //Enter
pageContext.setAttribute("newcn", "<br>"); //br 태그
pageContext.setAttribute("cr", "\u0020"); //Space
pageContext.setAttribute("newcr", "&nbsp;"); //Space
%>

<script>

$(document).ready(function () {
	
	// 익스플로러 브라우저 일때만
	// 뒤로가기 클릭시 페이지 만료 임시 예방(https -> http) : 추후 연구 필요
	/* var agent = navigator.userAgent.toLowerCase();
	if ((navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ) {
		
		var url = location.href;
		
		history.pushState(null, null, location.href);
		window.onpopstate = function(event) {
			
			if(url.indexOf("https://") != -1){
				url = url.replace("https","http");
				$(location).attr('href',url);	
			}else{
				window.history.back();
			}
			
		};
	} */
	
	$.cookie("starttime", new Date().getTime());
	$.cookie("counttime", 1800);
	initTimer();
	
	/* $(document).bind("contextmenu", function(e){
		alert("오른쪽 버튼을 이용할 수 없습니다.");
		return false;
	}); */
});

function Lpad(str, len) {
	str = str + "";
	while(str.length < len) {
		str = "0"+str;
	}
	return str;
}

var child = [];
var childcnt = 0;

// 자동로그아웃 처리 몇초전에 경고를 보여줄지 설정하는 부분, 초단위
var noticeSecond = 58;
var timerchecker = null;

function initTimer() {
	if($.cookie('starttime') != "") {
		// 사용자부터 마우스 또는 키보드 이벤트가 발생했을경우 자동로그아웃까지의 대기시간을 다시 초기화 
		if(window.event) {
			$.cookie("starttime", new Date().getTime());	// 쿠키시간 초기화
			$.cookie("counttime", 1800);						// 경고창 카운팅 시간 초기화
			clearTimeout(timerchecker);
// 			$('#coverFilmMain').hide();						// 입력방지 레이어 해제
// 			$('#timer').hide();								// 자동로그아웃 경고레이어 해제
		}
		rMinute = parseInt($.cookie("counttime") / 60);
		rSecond = $.cookie("counttime") % 60;
		//console.log($.cookie("counttime"));
		if($.cookie("counttime") > 0)	{
			// 지정한 시간동안 마우스, 키보드 이벤트가 발생되지 않았을 경우
// 			if($.cookie("counttime") < noticeSecond) {
// 	 			$('#coverFilmMain').height($('body').prop("scrollHeight")); 
// 				$('#coverFilmMain').show();	// 입력방지 레이어 활성
// 				$('#timer').show();			// 자동로그아웃 경고레이어 활성
// 			}
			// 자동로그아웃 경고레이어에 경고문+남은 시간 보여주는 부분
// 			$('#timer').html("일정시간동안 사용이 없어 잠시 후 자동로그아웃 됩니다.<br/><span style='color:#FF0000;'>" + Lpad(rMinute, 2) +":"+Lpad(rSecond, 2)+"</span>");
			$.cookie("counttime", Number($.cookie("counttime") - 1));
			timerchecker = setTimeout("initTimer()", 1000); // 1초 간격으로 체크
			
// 			console.log(Lpad(rMinute, 2)+":"+Lpad(rSecond, 2)+"===="+childcnt+"===="+child.length);
		}
		else {
			if("${INIT_DATA.SESSION_USR_ID}" != ""){
				if(confirm("사용 시간(30분)이 경과하였습니다.\n 로그아웃 하시겠습니까?")){
					clearTimeout(timerchecker);
					alert("사용 시간(30분)이 경과하여\n 시스템에서 자동으로 로그아웃 되었습니다");
					for( var a = 0; a < child.length; a++) {
						//console.log(child[a]);
						child[a].loginchk();
					}
					$.cookie("starttime", '');
					location.href="/logOut.do";
				}else{
					$.cookie("counttime", 1800);
					initTimer();
				}
			}
		}
	}
}

document.onclick = initTimer;		// 현재 페이지의 사용자 마우스 클릭이벤트
document.onkeypress = initTimer;	// 현재 페이지의 키보트 입력이벤트

</script>
<%-- <%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="career.framework.common.DataMap"%> --%>
<!DOCTYPE html>
<html lang="ko">

<head>
<%-- 	<%@ include file="/static_root/inc/top.jsp" %> --%>
	<script type="text/javascript">
		$(document).ready(function() {
			
			if("<c:out value="${INIT_DATA.ERROR_CD}"/>" == "999"){
				alert("로그인에 실패하였습니다.\n아이디 및 패스워드를 확인하세요");
			}
			
			doPopup();
			
			//학생상담센터 전수검사 파업창 쿠키 확인
			// 검사기간 끝나고 나면 주석처리 매년 사용됨
			if (getcookie("popUcPsyMain")==null){
				$("#popUcPsyMain").show();
			}else{
				$("#popUcPsyMain").hide();
			}
			
			if (getcookie("popCaMain")==null && "${INIT_DATA.CANOT}" != "Y" && "${INIT_DATA.TAR_YN}" == "Y"){
				$("#popCaMain").show();
			}else{
				$("#popCaMain").hide();
			}
		});
		function fnGoPage(conArea){
			if(conArea == 'B1'){
				location.href = "/user/In/InCt030L.do?CURRENT_MENU_CODE=MENU0192&TOP_MENU_CODE=MENU0189";
			}else if(conArea == 'P2'){
				$('#CON_AREA1').val('');
				$('#CON_AREA2').val('Y');
				$('#CON_AREA4').val('');
				$('#frm').attr("action", "/user/Uc/UcStP2Cm.do");
				$('#frm').submit();
			}else if(conArea == 'B3'){
				location.href = "/common/index.do?jpath=/user/Ep/file_down2&fileDiv=2";
			}
		}
		
		//외부 회원가입
		function fnJoin(){
			gfnOpenLayerPopup('/common/index.do?jPath=/common/pop_normalUserJoin');
		}
		
		//멘토 회원가입
		function fnJoin3(){
			gfnOpenLayerPopup('/common/index.do?jPath=/common/Mt/pop_addMentor&ADMIN_YN=N');
		}
		
		//기업 회원가입
		function fnJoin2(){
			
			var strUrl= '/join.do';
			var popup= window.open('about:blank','CompJoin','left=100,width=1000,height=800,scrollbars=yes');
			popup.focus();
	
			$('#login').attr("action", strUrl);
			$('#login').attr("target", "CompJoin");
			$('#login').submit();
			$('#login').attr("target", "");
		}
		
		
		//회원가입 선택
		function fnJoinSelect(){
			gfnOpenLayerPopup('/common/index.do?jPath=/common/pop_selectUserJoin');
		}
		
		// 유저 타입변경
		function fnchUserType(type){
			$("#USR_TYPE").val(type);
			
			if(type == "S"){
				$('#USR_S').addClass('on');
				$('#USR_P').removeClass();
				$('#USR_C').removeClass();
			}else if(type == "P"){
				$('#USR_P').addClass('on');
				$('#USR_S').removeClass();
				$('#USR_C').removeClass();
			}else if(type == "C"){
				$('#USR_C').addClass('on');
				$('#USR_S').removeClass();
				$('#USR_P').removeClass();
			}
			
		}
		
		// 로그인
		function fnLogin(){		
			if($("#USR_TYPE").val() == ""){
				$("#USR_TYPE").val('S');
			}
			
			if( $("#USRID").val() == "" || $("#USRPWD").val() == ""){
				alert("아이디와 패스워드를 입력하여 주세요");
				return;
			}
			
			if($("#USR_TYPE").val() == "C"){
				fnCompLogin();
			}else{
				if($('#USRID').val().substring(0,5) == "00000"){
					fnImsiLogin();
				}else{
					loginPortal();
				}
			}
		}
		
		//포탈 로그인 처리 전 임시 로그인
		function fnImsiLogin() {
			$.ajax({
				 type		: "POST"
				,url		: "/login.do"
				,dataType	: "json"
				,data		: {
					"INTG_UID" : $("#USRID").val()
					,"USER_PWD" : $('#USRPWD').val()
					,"COMMON_CAMP_GB" : "J"
				}
				,success : function(transport) {
					if (transport.ERROR_CD == '900') { //로그인 성공
						if(transport.AUTH0007_CNT != "0"){ // 비교과 마이페이지
							$("#frm").attr("action", "/user/My/MyMg010L.do?CURRENT_MENU_CODE=MENU0063&TOP_MENU_CODE=MENU0008");
						}else if(transport.SESSION_USER_TY_CD == "S"){ //학생
							$("#frm").attr("action", "/user/My/MySt011L.do?CURRENT_MENU_CODE=MENU0044&TOP_MENU_CODE=MENU0007");
						}else if(transport.SESSION_USER_TY_CD == "P"){ //교원
							$("#frm").attr("action", "/user/My/MyPf011L.do?CURRENT_MENU_CODE=MENU0078&TOP_MENU_CODE=MENU0010");
						}else if(transport.SESSION_USER_TY_CD == "A"){ //조교
							$("#frm").attr("action", "/user/Co/CoAs010L.do?CURRENT_MENU_CODE=MENU0210&TOP_MENU_CODE=MENU0209");
						}else if(transport.SESSION_USER_TY_CD == "T"){ //상담사
							$("#frm").attr("action", "/user/Co/CoMc010L.do?ONLOAD=Y&CURRENT_MENU_CODE=MENU0074&TOP_MENU_CODE=MENU0009");
						}else{
							$("#frm").attr("action", "/user/Bd/BdCm010L.do?BD_NO=1&CURRENT_MENU_CODE=MENU0040&TOP_MENU_CODE=MENU0006");
						}
					
						$("#frm").submit();
					} else { //로그인 실패
						alert("로그인에 실패하였습니다.\n아이디 및 패스워드를 확인하세요");
						return;
					}
				}
				,error : function(transport) { //ERROR
					alert("로그인 중 오류가 발생하였습니다.");
				}
			});
		}
		
		//서일대 포탈 로그인
		function loginPortal() {
			$("#userid").val($('#USRID').val());
			$("#passwd").val(encrypt.encode($('#USRPWD').val()));
			$("#portalSSO").submit();
		}
		
		//로그인
		function fnCompLogin(){
			$.ajax({ 
				 type : "post"
				,url  : "/compLogin.do"
				,data : {
					 "INTG_UID" 	: $("#USRID").val()
					,"INTG_PWD" 	: $("#USRPWD").val()
				}
				,dataType : "json"
				,success : function(transport) {
					if(transport.ERROR_CD == '901'){
						alert("로그인에 실패하였습니다.\n아이디 및 패스워드를 확인하세요");
						return;
					}else if(transport.ERROR_CD == "401"){
						alert("관리자 승인이 필요합니다.");
						return;
					}else if(transport.ERROR_CD == '900'){ // 로그인 성공
						if(transport.SESSION_USER_TY_CD == "MT"){
							introFrm.action = "/user/Mt/MtMm010L.do?CURRENT_MENU_CODE=MENU0222&TOP_MENU_CODE=MENU0221";
						}else if(transport.SESSION_USER_TY_CD == "C"){
							introFrm.action = "/user/mypage_company/infaco_myEdit.do?CURRENT_MENU_CODE=MENU0085&TOP_MENU_CODE=MENU0011";
						}else{
							introFrm.action = "/user/Bd/BdCm010L.do?BD_NO=1&CURRENT_MENU_CODE=MENU0040&TOP_MENU_CODE=MENU0006";
						}
						introFrm.submit();
					}else{
						alert("로그인에 실패하였습니다.\n아이디 및 패스워드를 확인하세요");
						return;
					}
				}
			});
		}
		
		$(document).ready(function() {
			$(".consult_hover").hide();
	
			$(".box_con").hover(function() {
			    $(".consult_hover").animate({ "marginLeft": "0"}, 50);
			    $(".consult_hover").show();
			}, 
			function() {
			    $(".consult_hover").animate({"marginLeft": "100%"}, 50);
			    $(".consult_hover").hide();
			});	
		});	
		
		function fncMainMenuMove(menuid, url,topcd) {
			var currentMenuCd = "";
			var main = document.frm;
			$.ajax({ 
				 type : "post"
				,url  : "/moveMenu.do"
				,data : {
					"MENU_URL" 	  :url
					,"CURRENT_MENU_CODE" : menuid
				}
				,dataType : "json"
				,success : function(transport) {
					if(transport.RET_MSG != ''){
						if('${INIT_DATA.SESSION_USR_ID}' == ''){
							alert("로그인 해주세요");
						}else{
							alert(transport.RET_MSG);
						}
					}else{
						var resultMst = eval(transport.leftMenu);
						currentMenuCd = resultMst.CURRENT_MENU_CODE;
						if(url.indexOf("?") > -1){
							main.action=url + "&CURRENT_MENU_CODE=" + currentMenuCd+ "&TOP_MENU_CODE=" + topcd;
							main.submit();
						}else
						{
							main.action=url + "?CURRENT_MENU_CODE=" + currentMenuCd+ "&TOP_MENU_CODE=" + topcd;
							main.submit();
						}
					}
					
				}
			});
		}
		
		function fnEpPrmDetail(seq, gb){
			var url = "/user/Ep/EpMng010PD.do?PRM_SEQ=" + seq;
			if(gb == "G"){
				url = "/user/Ep/EpMng010GD.do?PRM_SEQ=" + seq;
			}
			fncMainMenuMove("MENU0058",url,"MENU0006");
		}
		
		function popCaClose(flag){
			if(flag == "Y"){
				exday=new Date();
				exday.setDate(exday.getDate()+1);
				document.cookie="popCaMain="+escape("yes")+"; expires="+exday.toGMTString()+"; ";
			}
			$("#popCaMain").hide();
		}
		
		
	</script>

	<!-- 메인 슬라이드 -->
	<link rel="stylesheet" type="text/css" href="/static_root/css/slick.css"/>
	<link rel="stylesheet" type="text/css" href="/static_root/css/slick-theme.css"/>
	<script type="text/javascript" src="/static_root/js/slick.js"></script>
	<script>
	$(document).ready(function() {
		// 메인 - 카드형 비교과 프로그램
		$('#MN_card_ext').slick({
			infinite: false,
			speed: 300,
			slidesToShow: 4,
			slidesToScroll: 1,
			slide: 'div',
			dots: false,
			prevArrow: '<a class="card-prev" aria-label="Previous"><span><img src="/static_root/images/main/card_arr_prev.png" alt="카드형비교과Prev" /></span></a>',
			nextArrow: '<a class="card-next" aria-label="Next"><span><img src="/static_root/images/main/card_arr_next.png" alt="카드형비교과Next" /></span></a>',
		    responsive: [
	               {
		                 breakpoint: 2090,
		                 settings: {
		                   slidesToShow: 3,
		                   slidesToScroll: 1,
		                 }
		               },
	               {
	                 breakpoint: 1747,
	                 settings: {
	                   slidesToShow: 2,
	                   slidesToScroll: 1,
	                   infinite: true,
	                   variableWidth : true
	                 }
	               },
	               {
	                   breakpoint: 1329,
	                   settings: {
	                     slidesToShow: 1,
	                     slidesToScroll: 1,
	                     infinite: false,
	                     variableWidth : false
	                   }
	                 },
	                 {
	                     breakpoint: 1199,
	                     settings: {
	                       slidesToShow: 3,
	                       slidesToScroll: 1,
	                       infinite: true,
	                       centerMode : true,
	                       variableWidth : true
	                     }
	                   },
	               {
	                 breakpoint: 989,
	                 settings: {
	                   slidesToShow: 3,
	                   slidesToScroll: 1,
	                   infinite: true,
	                   centerMode : true,
	                   variableWidth : true
	                 }
	               },
	               {
	                 breakpoint: 767,
	                 settings: {
	                   slidesToShow: 2,
	                   slidesToScroll: 1,
	                   infinite: true,
	                   centerMode : true,
	                   variableWidth : true
	                 }
	               },
	               {
		                 breakpoint: 479,
		                 settings: {
		                   slidesToShow: 1,
		                   slidesToScroll: 1,
		                   infinite: true,
		                   centerMode : true,
		                   variableWidth : true
		                 }
		               }
	             ]
		});
	});
	</script>
</head>
<body id="user" class="main_bd">
	<form name="frm" id="frm" method="post" action="">
	</form>
	<form name="login" id="login" method="post" action="#">
		<input type="hidden" name="USR_TYPE" id="USR_TYPE" value="${INIT_DATA.USR_TYPE }"/>
		<input type="hidden" name="LOGIN_TYPE" id="LOGIN_TYPE" value="MT" />
	</form>
	<div id="wrap">
		<!-- 상단영역 -->
		<%@ include file="/static_root/inc/header.jsp" %>
		<!-- 상단영역 끝 -->
		
		<!-- 메인 콘텐츠영역 -->
		<div id="main_wrap">
			<div class="mn_visual">
				<div class="mn_slogan">
					<h2>우리집 만들기 프로젝트</h2>
				</div>
				<div class="mn_quick">
					<ul class="clearfix">
						<li onclick="window.open('http://hm.seoil.ac.kr/74', '_blank')">
							<dl class="clearfix">
								<dt>
									<strong>아파트 정보</strong>
									<span>Apartmane Infomation</span>
								</dt>
								<dd><span><img src="/static_root/images/main/mn_quick01.png" alt="학사 일정" /></span></dd>
							</dl>
						</li>
						<li onclick="window.open('https://stis.seoil.ac.kr', '_blank')">
							<dl class="clearfix">
								<dt>
									<strong>입주자 관리</strong>
									<span>Infomation</span>
								</dt>
								<dd><span><img src="/static_root/images/main/mn_quick02.png" alt="학사 정보" /></span></dd>
							</dl>
						</li>
						<li onclick="javascript:fncMainMenuMove('MENU0025','/common/userReady.do','MENU0008');">
							<dl class="clearfix">
								<dt>
									<strong>회비관리</strong>
									<span>Infomation</span>
								</dt>
								<dd><span><img src="/static_root/images/main/mn_quick03.png" alt="학생성공 네비게이터" /></span></dd>
							</dl>
						</li>
					</ul>
				</div>
			</div>
			
			<div class="mn_cont" id="cont">
				<div class="mn_cont_btm">
					<div id="cont_box" class="box_selfAc clearfix" onclick="fncMainMenuMove('MENU0039','/user/Ex/ExCs010L.do','MENU0004');">
						<h3>사이트 안내</h3>
						<p>Our Apt<br/>사이트를 소개합니다.</p>
						<a href="#">VIEW MORE <span>+</span></a>
					</div>
					<div id="cont_box" class="box_blue box_jinroRm clearfix" onclick="fncMainMenuMove('MENU0038','/user/Myroadmap/myRoadMapList.do','MENU0003');">
						<h3>문의하기</h3>
						<p>DB관리의 편리성, 지금 문의해 보세요.</p>
						<a href="#">VIEW MORE <span>+</span></a>
					</div>
					<div id="cont_box" class="box_notice clearfix">
						<div class="nt_title clearfix">
							<h3>공지사항</h3>
							<a href="javascript:fncMainMenuMove('MENU0059','/user/Bd/BdCm010L.do?BD_NO=1','MENU0007');">VIEW MORE <span>+</span></a>
						</div>
						<p>Our Apt 공지사항.</p>
						<ul class="nt_list">
							<c:if test="${not empty INIT_DATA.MainBdList}">
								<c:forEach var="item" items="${INIT_DATA.MainBdList }" varStatus="rowStatus">
									<li class="clearfix">
										<a href="javascript:fncMainMenuMove('MENU0059','/user/Bd/BdCm010D.do?BD_NO=1&BBS_NO=${item.BBS_NO}','MENU0007');">${item.TITLE}</a>
										<span>${item.REGDATE}</span>
									</li>
								</c:forEach>
							</c:if>
							<c:if test="${empty INIT_DATA.MainBdList}">
								<li class="clearfix">등록된 공지사항이 없습니다.</li>
							</c:if>
						</ul>
					</div>
					<div id="cont_box" class="box_notice clearfix">
						<div class="nt_title clearfix">
							<h3>우리집 홍보</h3>
							<a href="javascript:fncMainMenuMove('MENU0059','/user/Bd/BdCm010L.do?BD_NO=1','MENU0007');">VIEW MORE <span>+</span></a>
						</div>
						<p>우리집의 최근소식. 모두에게 알려주세요.</p>
						<ul class="nt_list">
							<c:if test="${not empty INIT_DATA.MainBdList}">
<%-- 								<c:forEach var="item" items="${INIT_DATA.MainBdList }" varStatus="rowStatus"> --%>
									<li class="clearfix">
										<a href="javascript:fncMainMenuMove('MENU0059','/user/Bd/BdCm010D.do?BD_NO=1&BBS_NO=${item.BBS_NO}','MENU0007');">일루미 더블역세권~</a>
										<span>2021-05-20</span>
									</li>
<%-- 								</c:forEach> --%>
							</c:if>
							<c:if test="${empty INIT_DATA.MainBdList}">
								<li class="clearfix">등록된 글이 없습니다.</li>
							</c:if>
						</ul>
					</div>
				</div>
				
			</div>
		</div>
	</div>
	<!-- 메인 콘텐츠영역 끝 -->
	
	<form name="introFrm" id="introFrm" method="post">
	</form>
	
	<!-- 하단영역 -->
	<%@ include file="/static_root/inc/footer.jsp" %>
	<!-- 하단영역 끝 -->
	
</body>
</html>

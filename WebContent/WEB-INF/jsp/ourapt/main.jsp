<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
	<%@ include file="/static_root/inc/apt_top.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		
		
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
		<%@ include file="/static_root/inc/apt_header.jsp" %>
		<!-- 상단영역 끝 -->
		
		<!-- 메인 콘텐츠영역 -->
		<div id="main_wrap">
			<div class="mn_visual">
				<div class="mn_slogan">
					<h2>우리집 만들기의 첫걸음</h2>
				</div>
				<div class="mn_quick">
					<ul class="clearfix">
						<li onclick="window.open('http://hm.seoil.ac.kr/74', '_blank')">
							<dl class="clearfix">
								<dt>
									<strong>아파트 정보</strong>
									<span>Apartmane Infomation</span>
								</dt>
								<dd><span><img src="/static_root/apt/images/main/mn_quick01.png" alt="학사 일정" /></span></dd>
							</dl>
						</li>
						<li onclick="window.open('https://stis.seoil.ac.kr', '_blank')">
							<dl class="clearfix">
								<dt>
									<strong>입주자 관리</strong>
									<span>Infomation</span>
								</dt>
								<dd><span><img src="/static_root/apt/images/main/mn_quick02.png" alt="학사 정보" /></span></dd>
							</dl>
						</li>
						<li onclick="javascript:fncMainMenuMove('MENU0025','/common/userReady.do','MENU0008');">
							<dl class="clearfix">
								<dt>
									<strong>회비관리</strong>
									<span>Infomation</span>
								</dt>
								<dd><span><img src="/static_root/apt/images/main/mn_quick03.png" alt="학생성공 네비게이터" /></span></dd>
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
	
	<!-- 하단영역 -->
	<%@ include file="/static_root/inc/apt_footer.jsp" %>
	<!-- 하단영역 끝 -->
	
</body>
</html>

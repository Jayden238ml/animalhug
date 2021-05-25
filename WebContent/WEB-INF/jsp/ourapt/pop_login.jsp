<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html lang="ko">
<head>
<title>로그인</title>
<%@ include file="/static_root/inc/apt_top.jsp" %>
<script type="text/javascript">
	function fnLogin(){
		if($('#INTG_UID').val() == "" || $('#INTG_PWD').val() == ""){
			alert("아이디 및 패스워드를 입력해 주세요");
			return;
		}
		
// 		$.ajax({
// 			 type		: "POST"
// 			,url		: "/loginSeoil.do"
// 			,dataType	: "json"
// 			,data		: {
// 				"INTG_UID" : $('#INTG_UID').val()
// 				,"USER_PWD" : $('#INTG_PWD').val()
// 			}
// 			,success : function(transport) {
				
// 				$('#USRID').val($('#INTG_UID').val());
// 				if(transport.ERROR_CD == '900'){
// 					fileDownFrmFooter.action= '/main.do';
// 					fileDownFrmFooter.submit();					
// 				}else if(transport.ERROR_CD == '901'){
// 					alert("로그인에 실패하였습니다.아이디/패스워드를 확인하세요.");	
// 					return;
// 				}
// 			}
// 			,error : function(transport) { //ERROR
// 				alert(transport.ERR_MSG);
// 			}
// 		});
	}	
</script>
</head>
<body>
<form name="popFrm" id="popFrm" method="post">
	<div class="layerWrap680 login_pop_inner">
		<div class="bg"></div>
		<!-- 로그인 -->
		<div class="loginLayer">
			<p>
				<c:if test="${INIT_DATA.TYPE eq 'P'}">
					<a href="javascript:gfnLayerClose();" class="cbtn"><img src="/static_root/apt/images/content/totalMN_close.jpg" alt="닫기" title="닫기" /></a>
				</c:if>
				<c:if test="${INIT_DATA.TYPE eq 'M'}">
					<a href="javascript:gfnMobileLayerClose();" class="cbtn"><img src="/static_root/apt/images/content/totalMN_close.jpg" alt="닫기" title="닫기" /></a>
				</c:if>
			</p>
			<div id="loginDiv">
				<h1>입주자<span>&nbsp;회원관리 시스템</span></h1>
				<h2>발급받은 아이디와 비밀번호를 사용해 주세요.<br/>발급받지 않은 계정 로그인 시에는 카카오, 네이버로 로그인 해 주세요.</h2>
				<div>&nbsp;</div>
				<fieldset>
					<legend>로그인</legend>
					<dl>
						<dt>
							<ul>
								<li><input type="text" name="INTG_UID" id="INTG_UID" value="" title="아이디" class="lgID" placeholder="ID" maxlength="20" onkeyup="if(event.keyCode==13){fnLogin();}"/></li>
								<li><input type="password" name="INTG_PWD" id="INTG_PWD" value="" title="비밀번호" class="lgPW" placeholder="Password" onkeyup="if(event.keyCode==13){fnLogin();}"/></li>
							</ul> 
							<div><a href="javascript:fnLogin();">로그인</a></div>
						</dt>
						<dd>
							<a href="#" class="cbtn"><img src="/static_root/images/btnIcn/kakao_Login.png" alt="카카오 로그인" title="카카오 로그인" /></a>
							<a href="#" class="cbtn"><img src="/static_root/images/btnIcn/naver_Login.png" alt="네이버 로그인" title="네이버 로그인" /></a>
						</dd>
					</dl>
				</fieldset>
			</div>				
		</div>
		<!-- 로그인 끝 -->
	</div>
</form>
</body>
</html>
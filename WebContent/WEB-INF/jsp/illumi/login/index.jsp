<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<%
	String LOGIN_IP= request.getRemoteAddr();	
%>
<html lang="ko">
	<head>
		<%@ include file="/static_root/inc/iladmin_head.jsp" %>
	</head>
	<script type="text/javascript">	
	function fnLogin(){
		if($('#MEMBER_ID').val() == ""){
			$('#NON_ID').show();
			$('#MEMBER_ID').focus();
			return;
		}else{
			$('#NON_ID').hide();
		}
		if($('#MEMBER_PWD').val() == ""){
			$('#NON_PW').show();
			$('#MEMBER_PWD').focus();
			return;
		}else{
			$('#NON_PW').hide();
		}
		$.ajax({
			 type		: "POST"
			,url		: "/login.do"
			,dataType	: "json"
			,data		: {
				"MEMBER_ID" : $('#MEMBER_ID').val()
				,"MEMBER_PWD" : $('#MEMBER_PWD').val()
				,"USERTYPE" : "A"
			}
			,success : function(transport) {
				if(transport.ERROR_CD == '900'){
					$('#loginFrm').attr("action", "/illumi/illumiMain.do").submit();
					
				}else if(transport.ERROR_CD == '901'){
					alert("아이디 또는 비밀번호가 일치하지 않습니다.");	
					return;
				}
			}
			,error : function(transport) { //ERROR
				alert(transport.ERR_MSG);
			}
		});
	}
		
	</script>
	<body class="login-bg">
			
			



		<!-- 로그인 -->
		<form name="loginFrm" id="loginFrm" method="post" action="" class="form-inline">
			<fieldset>
				<legend>로그인</legend>
				<div class="login-area">
					<p><img src="/static_root/images/common/illumi_logo.png" alt="" title="" /></p>
					<h1><span>일루미스테이트</span> 운영진 </h1>
					<ul>
						<li>
							<input type="text" name="MEMBER_ID" id="MEMBER_ID" title="아이디" maxlength="" class="form-control id-icn w100p" placeholder="아이디" />
							<div class="alert-danger" id="NON_ID" style="display:none;"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i> 아이디를 입력하세요.</div> 
						</li>
						<li>
							<input type="password" name="MEMBER_PWD" id="MEMBER_PWD" title="비밀번호" maxlength="" class="form-control pw-icn w100p" placeholder="비밀번호" onkeyup="if(event.keyCode==13){fnLogin();}"/>
							<div class="alert-danger" id="NON_PW" style="display:none;"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i> 비밀번호를 입력하세요.</div>
						</li>
					</ul>
					<div>
						<a href="javascript:fnLogin();">로그인</a>
					</div>
				</div>
				
			</fieldset>
		</form>
		<!-- 로그인 끝 -->



			

	</body>
</html>
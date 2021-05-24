<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<meta name="title" content="로그인" />
		<%@ include file="/static_root/inc/head.jsp" %>
	</head>
	<script type="text/javascript">
		
		function fnLogin(){
			if($('#MEMBER_ID').val() == ""){
				alert("ID를 입력해 주세요.");
				$('#MEMBER_ID').focus();
				return;
			}
			if($('#MEMBER_PWD').val() == ""){
				alert("비밀번호를 입력해 주세요.");
				$('#MEMBER_PWD').focus();
				return;
			}
			
			$.ajax({
				 type		: "POST"
				,url		: "/login.do"
				,dataType	: "json"
				,data		: {
					"MEMBER_ID" : $('#MEMBER_ID').val()
					,"MEMBER_PWD" : $('#MEMBER_PWD').val()
				}
				,success : function(transport) {
					if(transport.ERROR_CD == '900'){
						$('#loginFrm').attr("action", "/main.do").submit();
						
					}else if(transport.ERROR_CD == '999'){
						alert("처리중 오류가 발생 하였습니다.");	
						return;
					}else if(transport.ERROR_CD == '901'){
						alert("아이디 또는 비밀번호가 일치하지 않습니다.");	
						return;
					}else if(transport.ERROR_CD == '905'){
						alert("비밀번호 5회 오류로 로그인이 제한되었습니다.\n관리자에게 문의 하세요.");	
						return;
					}
				}
				,error : function(transport) { //ERROR
					alert(transport.ERR_MSG);
				}
			});
		}
		
		
		//이메일 유효성 검사
		function validateEmail(sEmail) {
			var filter = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
			if(filter.test(sEmail)) {
				return true;
			}else {
				return false;
			}
		}
		
		function validateTel(){
			var c_no = $('#COMP_TEL').val();
			if(c_no != ""){
				if(isNaN(c_no) == true){
					alert("숫자만 입력 가능 합니다.");
					$('#COMP_TEL').focus();
					return;
				}
			}
			return true;
		}
		
		function fnMemberCreate(){
			$('#loginFrm').attr("action", "/member/memberCre.do").submit();
		}
		
		function fnSearch(){
			$('#loginFrm').attr("action", "/member/memberIDSearch.do").submit();
		}
		
	</script>
	<body>
		<div id="wrap">
			<!-- 상단영역 -->
			<%@ include file="/static_root/inc/header.jsp" %>
			<!-- 상단영역 끝 -->
			<!-- 본문영역 -->
			<div id="content">
				<!-- 타이틀 -->
				<div class="title-area">
					<h1>로그인</h1>
				</div>
				<!-- 타이틀 끝 -->
				<!-- 사이트맵 -->
				<form name="loginFrm" id="loginFrm" method="post" action="" class="form-inline">
					<fieldset>
						<legend>로그인</legend>
						<div class="login-area">
							<ul>
								<li>
									<input type="text" name="MEMBER_ID" id="MEMBER_ID" title="ID" maxlength="" class="form-control w100p" placeholder="ID를 입력해 주세요." />
								</li>
								<li>
									<input type="password" name="MEMBER_PWD" id="MEMBER_PWD" title="비밀번호" maxlength="" class="form-control w100p" placeholder="비밀번호를 입력해 주세요." />
								</li>
							</ul>
							<div class="text-center">
								<a href="javascript:fnLogin();" class="btn btn-secondary btn-lg w50p">로그인</a>
							</div>
							<ol>
								<li>
									<div><a href="javascript:fnMemberCreate();" class="btn btn-danger btn-lg w100p"><i class="fa fa-address-card-o" aria-hidden="true"></i> &nbsp;회원가입</a></div>
								</li>
								<li>
									<div><a href="javascript:fnSearch();" class="btn btn-warning btn-lg w100p"><i class="fa fa-key" aria-hidden="true"></i> &nbsp;ID/비밀번호 찾기</a></div>
								</li>
							</ol>
						</div>
					</fieldset>
				</form>
				<!-- 사이트맵 끝 -->

			</div>
			<!-- 본문영역 끝 -->

			<!-- 하단영역 -->
			<%@ include file="/static_root/inc/footer.jsp" %>
			<!-- 하단영역 끝 -->
		</div>
	</body>
</html>
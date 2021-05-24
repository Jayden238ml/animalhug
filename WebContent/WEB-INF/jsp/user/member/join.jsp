<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<meta name="title" content="회원가입" />
		<%@ include file="/static_root/inc/head.jsp" %>
	</head>
	<script type="text/javascript">
		// 취소 클릭 시 로그인 화면으로 이동
		function fnMoveLogin(){
			$('#addFrm').attr("action", "/member/member_login.do").submit();
		}
		
		// 회원정보 등록
		function fnAddMember(){
			
			if($('#MEMBER_ID').val() == ""){
				alert("ID를 입력해 주세요.");
				$('#MEMBER_ID').focus();
				return;
			}
			
			// 비밀번호 확인
			if(!validatePwd()){
				return;
			}
			
			if($('#MEMBER_NICK').val() == ""){
				alert("닉네임을 입력해 주세요.");
				$('#MEMBER_NICK').focus();
				return;
			}
			
			if($('#MEMBER_NICK').val().search(/\s/) != -1) {
				alert("닉네임에는 공백을 사용할 수 없습니다.");
				$('#MEMBER_NICK').focus();
				return; 
			}
			
			if($('#MEMBER_NM').val() == ""){
				alert("성명을 입력해 주세요.");
				$('#MEMBER_NM').focus();
				return;
			}

			// 메일주소 확인
			if(fnDupCheckEmail() == false){
				return;
			}
			
			if(!$("#AGREECHK").is(":checked")){
				alert("개인정보의 이용목적에 동의 후 등록 가능합니다.");
				return;
			}
			
			$('#MEMBER_PWD').val($('#MEMBER_PWD1').val());
			
			if(confirm("회원가입 하시겠습니까?")){
				$.ajax({
					type: "POST",
					url : "/member/insertComMemberData.do",
					data: $("#addFrm").serialize(),
					dataType: "json",
					success: function (transport) {
						if(transport.ERROR_CD == "999"){
							alert("처리중 에러가 발생 하였습니다.");
							return;
						}else if(transport.ERROR_CD == "DUPID"){
							alert("이미 존재하는  회원ID 입니다.");
							$('#MEMBER_ID').focus();
							return;
						}else if(transport.ERROR_CD == "DUPNICK"){
							alert("이미 존재하는  닉네임 입니다.");
							$('#MEMBER_NICK').focus();
							return;
						}else{
							alert("가입 되었습니다.");
							$('#addFrm').attr("action", "/main.do").submit();
						}
					}
				});
			}
			
		}
		
		// 이메일 validation
		function fnDupCheckEmail(){
			var rtn = false;
			var email = $('#MEMBER_EMAIL').val();
			if(email == ""){
				alert("이메일을 입력해 주세요.");
				$('#MEMBER_EMAIL').focus();
				return false;
			}
			var filter = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
			if(filter.test(email) == false){
				alert("올바른 이메일 형식이 아닙니다.");
				$('#MEMBER_EMAIL').focus();
				return false;
			}else{
				return true;
			}
		}
		
		// 비밀번호 체크
		function validatePwd(){
			var pwd1 = $('#MEMBER_PWD1').val();
			var pwd2 = $('#MEMBER_PWD2').val();
			var check = /^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9])(?=.*[0-9]).{8,16}$/;
			
			if(pwd1 == ""){
				alert("비밀번호를 입력해 주세요.");
				$('#MEMBER_PWD1').focus();
				return;
			}
			if(pwd2 == ""){
				alert("비밀번호를 입력해 주세요.");
				$('#MEMBER_PWD2').focus();
				return;
			}
			
			if(pwd1 != pwd2){
				alert("비밀번호를 확인해 주세요.");
				$('#MEMBER_PWD1').focus();
				return;
			}
			if(pwd1.length < 8){
				alert("비밀번호는 8자 이상 입력해야 합니다.");
				$('#MEMBER_PWD1').focus();
				return;
			}
			
			return true;
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
					<h1>회원가입</h1>
				</div>
				<!-- 타이틀 끝 -->
				
				<!-- 로그인 정보등록 -->
				<form name="addFrm" id="addFrm" method="post" action="#" class="form-inline">
					<input type="hidden" id="MEMBER_PWD" name="MEMBER_PWD" value="" />
					<fieldset>
						<legend>회원가입</legend>
						<div class="member-write">
							<ul>
								<li>
									<div><input type="text" name="MEMBER_ID" id="MEMBER_ID" title="ID" maxlength="" class="form-control w100p" placeholder="ID" /></div>
								</li>
								<li>
									<div><input type="password" name="MEMBER_PWD1" id="MEMBER_PWD1" title="비밀번호" maxlength="" class="form-control w100p" placeholder="비밀번호" /></div>
									<div class="mt5"><span>* 비밀번호는 8자 이상으로 입력해 주세요.</span></div>
								</li>
								<li>
									<div><input type="password" name="MEMBER_PWD2" id="MEMBER_PWD2" title="비밀번호 확인" maxlength="" class="form-control w100p" placeholder="비밀번호 확인" /></div>
									<div class="mt5"><span>* 위에 기재한 비밀번호를 한번 더 입력해 주세요.</span></div>
								</li>
								<li>
									<div><input type="text" name="MEMBER_NICK" id="MEMBER_NICK" title="닉네임" maxlength="" class="form-control w100p" placeholder="닉네임" /></div>
									<div class="mt5"><span>* 공백을 제외한 모든 문자가 가능 합니다.</span></div>
								</li>
								<li>
									<div><input type="text" name="MEMBER_NM" id="MEMBER_NM" title="성명" maxlength="" class="form-control w100p" placeholder="성명" /></div>
								</li>
								<li>
									<div><input type="text" name="MEMBER_EMAIL" id="MEMBER_EMAIL" title="이메일" maxlength="" class="form-control w100p" placeholder="이메일" /></div>
									<div class="mt5"><span>* 비밀번호 분실 시 입력된 이메일로 새로운 비밀번호를 발송하여 드립니다.</span></div>
								</li>
							</ul>
							<div class="inquiry-request" style="overflow:auto; width:100%">
								<div class="ir-agree">
									개인정보 이용에 관한 동의<br/>
									애니멀허그 서비스 이용을 위하여 아래의 개인정보 이용에 대한 내용을 자세히 읽어 보신 후 동의 여부를 결정하여 주시기 바랍니다.<br/><br/>
									
									1. 개인정보의 이용 목적에 대한 커뮤니티 이용 및 현황관리<br/>
									
									2. 이용하는 개인정보의 항목 <br/>
									- 필수정보 : 성명(이름), 이메일, IP, 닉네임, 쿠키정보 등 <br/>
									※ 이용자 편의를 위해 쿠키정보를 활용할 수도 있습니다.<br/><br/>
									
									3. 귀하는 위와 같은 개인정보 이용에 동의하지 않으실 수 있습니다. <br/>
									동의를 하지 않을 경우 문의하기 서비스가 제한될 수 있습니다.<br/><br/>
									※ 본 개인정보의 이용 등에 대한 상세한 내용은 애니멀허그(www.animalhug.co.kr)에 공개된 개인정보처리방침을 참조하시기 바랍니다.<br/><br/>
								</div>
								
								<div class="ir-agree-chk">
									<div class="check-radio">
										<input type="checkbox" name="AGREECHK" id="AGREECHK" value="" title="개인정보의 이용목적에 동의합니다." /><label for="AGREECHK"><span></span> 개인정보의 이용목적에 동의합니다.</label>
									</div>
								</div>	
							</div>
							<p>
								<a href="javascript:fnAddMember();" class="btn btn-danger btn-lg w200"><i class="fa fa-address-card-o" aria-hidden="true"></i> 회원가입</a> &nbsp; &nbsp;
								<a href="javascript:fnMoveLogin();" class="btn btn-secondary btn-lg w200"><i class="fa fa-ban" aria-hidden="true"></i> 취소</a>
							</p>
						</div>
					</fieldset>
				</form>
				<!-- 로그인 정보등록 끝 -->
			</div>
			<!-- 본문영역 끝 -->

			<!-- 하단영역 -->
			<%@ include file="/static_root/inc/footer.jsp" %>
			<!-- 하단영역 끝 -->
		</div>
	</body>
</html>
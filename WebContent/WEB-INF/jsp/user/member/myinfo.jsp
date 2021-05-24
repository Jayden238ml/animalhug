<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<meta name="title" content="나의정보" />
		<%@ include file="/static_root/inc/head.jsp" %>
	</head>
	<script type="text/javascript">
		
		function fnChangePwd(){
			
			if($('#NOW_MEMBER_PWD').val() == ""){
				alert("기존 비밀번호를 입력해 주세요.");
				$('#NOW_MEMBER_PWD').focus();
				return;
			}
			// 비밀번호 확인
			if(!validatePwd()){
				return;
			}
			
			if(confirm("비밀번호를 변경 하시겠습니까?")){
				$.ajax({
					type: "POST",
					url : "/member/changePwdData.do",
					data: $("#chgFrm").serialize(),
					dataType: "json",
					success: function (transport) {
						if(transport.ERROR_CD == "999"){
							alert("처리중 에러가 발생 하였습니다.");
							return;
						}else if(transport.ERROR_CD == "444"){
							alert("입력한 기존 비밀번호를 확인해 주세요.");
							$('#NOW_MEMBER_PWD').focus();
							return;
						}else{
							alert("변경 되었습니다.");
							$('#NOW_MEMBER_PWD').val("");
							$('#MEMBER_PWD1').val("");
							$('#MEMBER_PWD2').val("");
							$('#OK_VIEW_TXT').hide();
						}
					}
				});
			}
		}
		
		// 비밀번호 체크
		function validatePwd(){
			var pwd1 = $('#MEMBER_PWD1').val();
			var pwd2 = $('#MEMBER_PWD2').val();
			var check = /^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9])(?=.*[0-9]).{8,16}$/;
			
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
		
		function fnPwView(){
			$('#OK_VIEW_TXT').show();
		}
		
		function fnOut(){
			if(confirm("회원탈퇴 시 재가입 후 이용 가능합니다.\n탈퇴하시겠습니까?")){
				$.ajax({
					type: "POST",
					url : "/member/memberOut.do",
					data: $("#chgFrm").serialize(),
					dataType: "json",
					success: function (transport) {
						if(transport.ERROR_CD == "999"){
							alert("처리중 에러가 발생 하였습니다.");
							return;
						}else{
							alert("탈퇴처리가 완료되었습니다. 그동안 이용해 주셔서 감사합니다.");
							$('#chgFrm').attr("action", "/logOut.do").submit();
						}
					}
				});
			}
		}
		
		
		function fnModify(){
			if(confirm("회원정보를 수정하시겠습니까?")){
				$.ajax({
					type: "POST",
					url : "/member/memberModify.do",
					data: $("#chgFrm").serialize(),
					dataType: "json",
					success: function (transport) {
						if(transport.ERROR_CD == "999"){
							alert("처리중 에러가 발생 하였습니다.");
							return;
						}else if(transport.ERROR_CD == "DUPNICK"){
							alert("이미 존재하는  닉네임 입니다.");
							$('#MEMBER_NICK').focus();
							return;
						}else{
							alert("회원정보가 수정 되었습니다.");
							$('#chgFrm').attr("action", "/main.do").submit();
						}
					}
				});
			}
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
					<h1>나의 정보</h1>
				</div>
				<!-- 타이틀 끝 -->
				
				<!-- 로그인 정보등록 -->
				<form name="chgFrm" id="chgFrm" method="post" action="#" class="form-inline">
					<fieldset>
						<legend>회원정보</legend>
						<div class="member-write">
							<div class="tableView">
								<table summary="멘토링">
									<caption>회원정보</caption>
									<colgroup>
										<col width="35%" />
										<col width="*" />
									</colgroup>
									<tr>
										<th>이름</th>
										<td><c:out value='${INIT_DATA.detail.MEMBER_NM}'/> </td>
									</tr>
									<tr>
										<th>가입일자</th>
										<td><c:out value='${INIT_DATA.detail.REGDATE}'/>  </td>
									</tr>
									<tr>
										<th>닉네임</th>
										<td>
											<input type="text" name="MEMBER_NICK" id="MEMBER_NICK" title="닉네임" value="<c:out value='${INIT_DATA.detail.MEMBER_NICK}'/>" maxlength="" class="form-control w100p" placeholder="닉네임" />
											<div class="mt5"><span>* 공백을 제외한 모든 문자가 가능 합니다.</span></div>
										</td>
									</tr>
									<tr>
										<th>이메일</th>
										<td>
											<input type="text" name="MEMBER_EMAIL" id="MEMBER_EMAIL" title="이메일" value="<c:out value='${INIT_DATA.detail.MEMBER_EMAIL}'/>" maxlength="" class="form-control w100p" placeholder="이메일" />
											<div class="mt5"><span>* 비밀번호 분실 시 입력된 이메일로 새로운 비밀번호를 발송하여 드립니다.</span></div>
										</td>
									</tr>
								</table>
								<li>
									<a href="javascript:fnPwView();" class="btn-cancle">비밀번호 변경</a>
									<a href="javascript:fnOut();" class="btn-delete">회원탈퇴</a>
								</li>
							</div>
							<div id="OK_VIEW_TXT" style="display:none;">
								<ul>
								<li>
									<div><input type="password" name="NOW_MEMBER_PWD" id="NOW_MEMBER_PWD" title="기존비밀번호" value="" maxlength="" class="form-control w100p" placeholder="기존비밀번호" /></div>
								</li>
								<li>
									<div><input type="password" name="MEMBER_PWD1" id="MEMBER_PWD1" title="새로운비밀번호" value="" maxlength="" class="form-control w100p" placeholder="새로운비밀번호" /></div>
									<div class="mt5"><span>* 신규 비밀번호 (8자 이상으로 입력해 주세요)</span></div>
								</li>
								<li>
									<div><input type="password" name="MEMBER_PWD2" id="MEMBER_PWD2" title="비밀번호 확인" value="" maxlength="" class="form-control w100p" placeholder="비밀번호 확인" /></div>
									<div class="mt5"><span>* 신규 비밀번호 확인(위에 입력한 비밀번호를 한번 더 입력해 주세요.)</span></div>
								</li>
								<P>
									<a href="javascript:fnChangePwd();" class="btn btn-warning btn-lg w150"><i class="fa fa-address-card-o" aria-hidden="true"></i> 비밀번호 변경</a>
								</P>
							</div>
							<p>
								<a href="javascript:fnModify();" class="btn btn-danger btn-lg w150"><i class="fa fa-address-card-o" aria-hidden="true"></i> 수정</a> &nbsp; &nbsp;
								<a href="/main.do" class="btn btn-secondary btn-lg w150"><i class="fa fa-ban" aria-hidden="true"></i> 나가기</a>
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
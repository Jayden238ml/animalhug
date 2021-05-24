<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<meta name="title" content="비밀번호 찾기" />
		<%@ include file="/static_root/inc/head.jsp" %>
	</head>
	<script type="text/javascript">
		function fnFindId(type){
			
			if($('#MEMBER_ID').val() == ""){
				alert("ID를 입력해 주세요.");
				$('#MEMBER_ID').focus();
				return;
			}
			if($('#MEMBER_NM').val() == ""){
				alert("성명을 입력해 주세요.");
				$('#MEMBER_NM').focus();
				return;
			}
			if($('#MEMBER_EMAIL').val() == ""){
				alert("이메일을 입력해 주세요.");
				$('#MEMBER_EMAIL').focus();
				return;
			}
			
			$.ajax({
				type: "POST",
				url : "/member/findMemberId.do",
				data: $("#findFrm").serialize(),
				dataType: "json",
				success: function (transport) {
					if(transport.ERROR_CD == "999"){
						alert("처리중 에러가 발생 하였습니다.");
						return;
					}else{
						if(transport.MEMBER_ID == ""){
							$('#NOT_VIEW_TXT').show();
							$('#OK_VIEW_TXT').hide();
						}else{
							$('#OK_VIEW_TXT').show();
							$('#NOT_VIEW_TXT').hide();
						}
						
					}
				}
			});
			
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
					<h1>이메일/비밀번호 찾기</h1>
				</div>
				<!-- 타이틀 끝 -->


				<!-- 탭버튼 -->
				<ul class="tab-btn">
					<li><a href="/member/memberIDSearch.do">ID 찾기</a></li>
					<li><a href="/member/memberPWSearch.do" class="active">비밀번호 찾기</a></li>
				</ul>
				<!-- 탭버튼 끝 -->

				
				<!-- 비밀번호 찾기 -->
				<form name="findFrm" id="findFrm" method="post" action="#" class="form-inline">
					<input type="hidden" name="FIND_TYPE" id="FIND_TYPE" value="PW" />
					<fieldset>
						<legend>비밀번호 찾기</legend>
						<div class="member-write">
							<ul>
								<li>
									<div><input type="text" name="MEMBER_ID" id="MEMBER_ID" title="ID" maxlength="" class="form-control w100p" placeholder="ID" /></div>
									<div class="mt5"><span>* 가입 시에 입력한 ID를 입력해주세요.</span></div>
								</li>
								<li>
									<div><input type="text" name="MEMBER_NM" id="MEMBER_NM" title="성명" maxlength="" class="form-control w100p" placeholder="성명" /></div>
									<div class="mt5"><span>* 가입 시에 입력한 성명을 입력해주세요.</span></div>
								</li>
								<li>
									<div><input type="text" name="MEMBER_EMAIL" id="MEMBER_EMAIL" title="이메일" maxlength="" class="form-control w100p" placeholder="이메일" /></div>
									<div class="mt5"><span>* 가입 시에 입력한 이메일주소를 입력해 주세요.</span></div>
								</li>
							</ul>
							<div id="OK_VIEW_TXT" style="display:none;">
								<h2>임시 비밀번호를 가입 시 입력한 이메일로 발송하였습니다.</h2>
								<h3 id="MAIL_ID"></h3>
							</div>
							<div id="NOT_VIEW_TXT" style="display:none;">
								<h2>
									회원 정보가 일치하지 않습니다.<br />
									다시한번 정확히 입력해 주시거나 관련 정보를 <br />
									csh238ml@gmail.com 으로 보내 주시기 바랍니다.
								</h2>
							</div>
							<p>
								<a href="javascript:fnFindId('P');" class="btn btn-danger btn-lg w200"><i class="fa fa-envelope-o" aria-hidden="true"></i> 비밀번호 이메일 전송</a>
								<a href="/main.do" class="btn btn-secondary btn-lg w200"><i class="fa fa-ban" aria-hidden="true"></i> 취소</a>
							</p>
						</div>
					</fieldset>
				</form>
				<!-- 비밀번호 찾기 끝 -->

			

			</div>
			<!-- 본문영역 끝 -->



			




			<!-- 하단영역 -->
			<%@ include file="/static_root/inc/footer.jsp" %>
			<!-- 하단영역 끝 -->
		</div>
	</body>
</html>
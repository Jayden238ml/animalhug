<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<meta name="title" content="ID찾기" />
		<%@ include file="/static_root/inc/head.jsp" %>
	</head>
	<script type="text/javascript">
		function fnFindId(){
			
			if($('#MEMBER_NM').val() == ""){
				alert("성명을 입력해 주세요.");
				$('#MEMBER_NM').focus();
				return;
			}
			if($('#MEMBER_NICK').val() == ""){
				alert("닉네임을 입력해 주세요.");
				$('#MEMBER_NICK').focus();
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
						var mem_id = transport.MEMBER_ID;
						if(mem_id == ""){
							$('#NOT_VIEW_TXT').show();
							$('#OK_VIEW_TXT').hide();
						}else{
							mem_id = mem_id.replace(mem_id.substring(mem_id.length -2 , mem_id.length) , "**");
							$('#USER_ID').text(mem_id);
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
					<li><a href="/member/memberIDSearch.do" class="active">ID 찾기</a></li>
					<li><a href="/member/memberPWSearch.do">비밀번호 찾기</a></li>
				</ul>
				<!-- 탭버튼 끝 -->

				
				<!-- 이메일 찾기 -->
				<form name="findFrm" id="findFrm" method="post" action="#" class="form-inline">
					<input type="hidden" name="FIND_TYPE" id="FIND_TYPE" value="ID" />
					<fieldset>
						<legend>이메일 찾기</legend>
						<div class="member-write">
							<ul>
								<li>
									<div><input type="text" name="MEMBER_NM" id="MEMBER_NM" title="성명" maxlength="" class="form-control w100p" placeholder="성명" /></div>
									<div class="mt5"><span>* 가입 시에 입력한 성명을 정확하게 입력해주세요.</span></div>
								</li>
								<li>
									<div><input type="text" name="MEMBER_NICK" id="MEMBER_NICK" title="닉네임" maxlength="" class="form-control w100p" placeholder="닉네임" /></div>
									<div class="mt5"><span>* 가입 시에 입력한 닉네임을 정확하게 입력해주세요.</span></div>
								</li>
							</ul>
							<div id="OK_VIEW_TXT" style="display:none;">
								<h2>ID는 아래와 같습니다.</h2>
								<h3 id="USER_ID"></h3>
							</div>
							<div id="NOT_VIEW_TXT" style="display:none;">
								<h2>
									회원 정보가 일치하지 않습니다.<br />
									다시한번 정확히 입력해 주시거나 관련 정보를 <br />
									csh238ml@gmail.com 으로 보내 주시기 바랍니다.
								</h2>
							</div>
							<p>
								<a href="javascript:fnFindId('E');"" class="btn btn-danger btn-lg w200"><i class="fa fa-envelope-o" aria-hidden="true"></i> ID찾기</a>
								<a href="/member/member_login.do" class="btn btn-secondary btn-lg w200"><i class="fa fa-ban" aria-hidden="true"></i> 취소</a>
							</p>
						</div>
					</fieldset>
				</form>
				<!-- 이메일 찾기 끝 -->

			</div>
			<!-- 본문영역 끝 -->

			<!-- 하단영역 -->
			<%@ include file="/static_root/inc/footer.jsp" %>
			<!-- 하단영역 끝 -->
		</div>
	</body>
</html>
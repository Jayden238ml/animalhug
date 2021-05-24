<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<meta name="title" content="개인정보취급방침" />
		<title>개인정보취급방침 | 애니멀허그</title>
		<%@ include file="/static_root/inc/head.jsp" %>
		<script type="text/javascript">
			function fnMove(idx){
				var scmove = $('#'+idx).offset().top-100;
				$('html, body').animate( { scrollTop : scmove }, 400 );
			}
		</script>
	</head>
	<body>
		<div id="wrap">
			<!-- 상단영역 -->
			<%@ include file="/static_root/inc/header.jsp" %>
			<!-- 상단영역 끝 -->






			<!-- 본문영역 -->
			<div id="content">
				
				
				
				<!-- 타이틀 -->
				<div class="title-area">
					<h1>개인정보취급방침</h1>
				</div>
				<!-- 타이틀 끝 -->

				
				<!-- 약관 -->
				<div class="privacy-area">
					<div>
						'애니멀허그' (이하 '애니멀허그')는 이용자의 소중한 개인정보를 보호하기 위하여 정보통신서비스제공자가 준수하여야 하는 대한민국의 관계 법령 및 개인정보보호 규정, 가이드라인을 준수하고 있습니다. 애니멀허그는 개인정보처리방침을 통하여 이용자가 제공하는 개인정보가 어떠한 목적으로, 어떠한 용도와 방식으로 이용되고 있는지, 개인정보보호를 위해 어떠한 조치가 취해지고 있는지 알려 드립니다.<br /><br />
						애니멀허그의 개인정보처리방침은 다음과 같은 내용을 담고 있습니다. 
					</div>

					<ul>
						<li><a href="javascript:fnMove(1);">1. 수집하는 개인정보 항목</a></li>
						<li><a href="javascript:fnMove(2);">2. 개인정보의 수집 및 이용목적</a></li>
						<li><a href="javascript:fnMove(3);">3. 개인정보의 보유 및 이용기간</a></li>
						<li><a href="javascript:fnMove(3);">4. 고지의 의무</a></li>
					</ul>


					<h2 id="1">1. 수집하는 개인정보 항목</h2>

					<div>
						사이트는 회원가입, 상담, 서비스 신청 등등을 위해 아래와 같은 개인정보를 수집하고 있습니다.
					</div>

					<h3>수집항목</h3>
					<div>
						이름, 로그인ID, 닉네임, 이메일, 쿠키, 접속 IP 정보
					</div>

					<h3>개인정보 수집방법</h3>
					<div>
						홈페이지(회원가입)  
					</div>


					<h2 id="2">2. 개인정보의 수집 및 이용목적</h2>
					<div>
						사이트는 수집한 개인정보를 다음의 목적을 위해 활용합니다.
					</div>
					
					<h3>서비스 제공에 관한 지원과 상담</h3>
					<h3>서비스 제공에 관한 지원과 상담</h3>
					<h3>회원 관리</h3>
					<div>
						회원제 서비스 이용에 따른 본인확인, 개인 식별, 불량회원의 부정 이용 방지와 비인가 사용 방지, 가입 의사 확인, 연령확인, 불만처리 등 민원처리
					</div>
					<h3>마케팅 및 광고에 활용</h3>
					<div>
						신규 서비스(제품) 개발 및 특화, 이벤트 등 광고성 정보 전달, 접속 빈도 파악 또는 회원의 서비스 이용에 대한 통계
					</div>

					<h2 id="3">3. 개인정보의 보유 및 이용기간</h2>
					<div>
						사이트 개인정보 수집 및 이용목적이 달성된 후에는 예외 없이 해당 정보를 지체 없이 파기합니다.
					</div>


					<h2 id="10">4. 고지의 의무 </h2>
					<div>
						현 개인정보처리방침 내용 추가, 삭제 및 수정이 있을 시에는 즉시 홈페이지의 게시판을 통해 이용자에게 고지할 것입니다. 해킹 또는 컴퓨터 바이러스로 인한 보안사고 발생 시 회사는 모든 피해 이용자에게 이를 즉시 통보합니다. <br /><br />
					</div>
				</div>
				<!-- 약관 끝 -->

			

			</div>
			<!-- 본문영역 끝 -->



			




			<!-- 하단영역 -->
			<%@ include file="/static_root/inc/footer.jsp" %>
			<!-- 하단영역 끝 -->
		</div>
	</body>
</html>
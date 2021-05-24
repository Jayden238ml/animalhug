<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<meta name="title" content="애니멀허그" />
	<meta name="description" content="유기견조회, 입양가능동물 조회, 자유게시판, 찾아주세요, 건의사항" />
	<meta name="keywords" content="animalhug,애니멀허그,유기견,유기견입양,커뮤니티" />
	<meta name="robots" content="index, follow">
	<link rel="canonical" href="http://www.animalhug.co.kr">
	<meta property="og:type" content="article" />
	<meta property="og:site_name" content="애니멀허그">
	<meta property="og:type" content="article">
	<meta property="og:url" content="http://www.animalhug.co.kr">
	<meta property="og:title" content="유기동물 | 커뮤니티 | 애니멀허그">
	<meta property="og:image" content="/static_root/images/common/meta_img.jpg">
	<meta property="og:description" content="애니멀허그 " />

	<title>애니멀허그</title>
	<%@ include file="/static_root/inc/head.jsp" %>
<script type="text/javascript">

//상세
function fnDetail(bdNo, bbsNo){
	$('#BD_NO').val(bdNo);
	$('#BBS_NO').val(bbsNo);
	$('#frm').attr("action", "/user/Board/comm_notice_view.do").submit();
}

function fnRecurit(seq){
	if(seq == '1'){
		window.open ('/static_root/event/recruit_list.html','english2','left=5,top=112,width=710,height=940,scrollbars=yes,toolbars=no,status=no,resizable=0,menubar=no');   
	}else if(seq == '2'){
		window.open ('/static_root/event/recruit_1903.html','english','left=5,top=112,width=710,height=940,scrollbars=yes,toolbars=no,status=no,resizable=0,menubar=no');
	}else{
		$('#frm').attr("action", "/common/index.do?jpath=/kor/offering/erp").submit();
	}
}
</script>
	</head>
	<body>
		<div id="wrap">
			<!-- 상단영역 -->
		<%@ include file="/static_root/inc/header.jsp" %>
		<!-- 상단영역 끝 -->

		<form name="frm"  id="frm" method="post" action="">
		</form>
		
		<div class="main-visual-slick">
			<div class="mvs-item" style="background:url('/static_root/images/main/dog2.jpg') center top no-repeat; background-size:cover;">
				<div class="main-copy">
					<h1>보호중인 유기동물<br />이젠 주인이 되어 주세요.</h1>
					<div><a href="/user/animal/adoptAnimal.do">자세히보기</a></div>
				</div>
			</div>					
			<div class="mvs-item" style="background:url('/static_root/images/main/dog1.jpg') center top no-repeat; background-size:cover;">
				<div class="main-copy">
					<h1>잃어버린 반려동물,<br />보호소에서 안전하게 보호하고 있습니다.</h1>
					<div><a href="/user/animal/findAnimal.do" >자세히보기</a></div>
				</div>
			</div>
			<div class="mvs-item" style="background:url('/static_root/images/main/dog3.jpg') center top no-repeat; background-size:cover;">
				<div class="main-copy">
					<h1>반려동물을 잃어버렸나요?<br />주위에 널리 알려보세요.</h1>
					<div><a href="/user/Board/findBoard.do">자세히보기</a></div>
				</div>
			</div>
		</div>

		<div style="height:100px; background:#fff;"></div>
		
		<!-- 건의하기 -->
		<div class="inquiry-area">
			<div>
				<h1>내가 키우는 반려동물의 이야기를 들려주세요</h1>
				<h2>반려동물의 이야기를 공유하고 소통하는 공간 입니다.</h2>
				<dl onclick="location.href='/user/Board/story.do';">
					<dt>반려동물 이야기</dt>
					<dd><i class="xi-angle-right"></i></dd>
				</dl>
			</div>
		</div>
		<!-- 건의하기 끝 -->


		<!-- 하단영역 -->
		<%@ include file="/static_root/inc/footer.jsp" %>
		<!-- 하단영역 끝 -->
	</div>
</body>
</html>
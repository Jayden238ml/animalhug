<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<meta name="title" content="입양안내" />
		<meta name="description" content="입양안내" />
		<meta name="title" content="입양안내" />
		<meta name="description" content="입양안내" />
		<meta name="keywords" content="animalhug,애니멀허그,유기견,유기견입양,커뮤니티" />
		<meta name="robots" content="index, follow">
		<link rel="canonical" href="http://www.animalhug.co.kr">
		<meta property="og:type" content="article" />
		<meta property="og:site_name" content="애니멀허그">
		<meta property="og:type" content="article">
		<meta property="og:url" content="http://www.animalhug.co.kr">
		<meta property="og:title" content="유기동물 | 커뮤니티 | 애니멀허그">
		<meta property="og:image" content="/static_root/images/common/meta_img.jpg">
		<meta property="og:description" content="입양안내 " />
		<title>입양안내 | 애니멀허그</title>
		<%@ include file="/static_root/inc/head.jsp" %>
		<script type="text/javascript">
		$(document).ready(function(){
			$(window).resize(function() { 
				fnAutoResize();
			});
		});
		
		window.onload = function () {
			fnAutoResize();
		}
		
		function fnAutoResize(){
			var windowWidth = $( window ).width();	
			$('.contentImg img').each(function() {
				if($('.contentImg').width() < this.naturalWidth){
					$(this).css("width", "100%");
					$(this).css("height", "auto");
				}else{
					$(this).css("width", this.naturalWidth);
					$(this).css("height", "auto");
				}
			});
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
				<div class="title-area">
					<h1>입양안내</h1>
				</div>
				<div class="insight-list">
					<dl>
						<dt><img src="/static_root/images/common/content.jpg" width="100%"  /></dt>
						<dd>
							<h2>입양 전 체크</h2><br/><br/>
							• 반려동물을 맞이할 환경적 준비, 마음의 각오는 되어 있습니까?<br/><br/>
							• 개, 고양이는 10~15년 이상 삽니다.<br/>&nbsp;&nbsp; 결혼, 임신, 유학, 이사 등으로 가정환경이 바뀌어도 한번 인연을 맺은 동물은 끝까지 책임지고 보살피겠다는 결심이 있습니까?<br/><br/>
							• 모든 가족과의 합의는 되어 있습니까?<br/><br/>
							• 내 동물을 위해 희생할 각오가 되어 있습니까?<br/><br/>
							• 아플 때 적절한 치료를 해주고, 중성화수술(불임수술)을 실천할 생각입니까?<br/><br/>
							• 입양으로 인한 경제적 부담을 짊어질 의사와 능력이 있습니까?<br/><br/>
							• 우리 집에서 키우는 다른 동물과 잘 어울릴 수 있을까요?<br/>
						</dd>
					</dl>
					<dl>
						<dt><img src="/static_root/images/common/content2.jpg" width="100%"  /></dt>
						<dd>
							<h2>입양 안내</h2><br/><br/>
							※ 애니멀허그의 메뉴에서 <span style="color: red;">유기동물 > 입양가능동물조회</span> 메뉴에서 조회되는 동물은 모두 <span style="color: red;">입양 가능</span>한 동물 입니다.<br/>
							( 시·군·구청에서 보호하고 있는 유기동물 중 공고한 지 10일이 지나도 주인이 나타나지 않는 경우 일반인에게 분양 가능함 )<br/><br/>
							• 입양 보호시설에 미리 전화로 문의하시고, 담당자의 안내에 따라 방문 일시 등을 예약 합니다.<br/><br/>
							• 입양 시 신분증 복사본2장과 개집,개줄,목걸이 등 필요한 물품을 준비하고 보호시설을 방문해 입양계약서를 작성해야 합니다.<br/><br/>
							• 입양 보호시설에는 신청자 본인이 직접 방문해야 합니다.<br/><br/>
							• 미성년자에게는 반려동물을 분양하지 않습니다. 분양을 원하는 미성년자는 부모님의 허락을 얻어 반드시 부모님과 함께 방문해야 합니다.<br/><br/>
						</dd>
					</dl>
				</div>

				<!-- 타이틀 -->
				<%@ include file="/static_root/inc/mid.jsp" %>
				<br/>
				<!-- 타이틀 끝 -->	
				<div style="margin-top:5px; text-align:center;">
					<p>
						<a href="/main.do" class="btn btn-secondary btn-lg w150">메인으로</a> &nbsp; &nbsp;
					</p>
					<br/>
				</div>
			</div>
			<!-- 본문영역 끝 -->

			<!-- 하단영역 -->
			<%@ include file="/static_root/inc/footer.jsp" %>
			<!-- 하단영역 끝 -->
		</div>
	</body>
</html>
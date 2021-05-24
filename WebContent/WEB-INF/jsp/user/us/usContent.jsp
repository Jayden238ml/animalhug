<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<meta name="title" content="animalhug" />
		<meta name="description" content="animalhug" />
		<meta name="title" content="animalhug" />
		<meta name="description" content="animalhug" />
		<meta name="keywords" content="animalhug,애animalhug" />
		<meta name="robots" content="index, follow">
		<link rel="canonical" href="http://www.animalhug.co.kr">
		<meta property="og:type" content="article" />
		<meta property="og:site_name" content="animalhug">
		<meta property="og:type" content="article">
		<meta property="og:url" content="http://www.animalhug.co.kr">
		<meta property="og:title" content="animalhug | animalhug | animalhug">
		<meta property="og:image" content="/static_root/images/common/meta_img.jpg">
		<meta property="og:description" content="animalhug " />
		<title>animalhug | animalhug</title>
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
			<%@ include file="/static_root/inc/usheader.jsp" %>
			<!-- 상단영역 끝 -->

			<!-- 본문영역 -->
			<div id="content">
				<div class="title-area">
					<h1>Site improvement in progress.</h1>
				</div>
				<div class="insight-list">
					<dl>
						<dt></dt>
						<dd>
							<h2><a href="http://www.animalhug.com" target="_blank">Go to the Animal Hug site</a>
							<%@ include file="/static_root/inc/mid.jsp" %>
							</h2>
							<h2>
							</h2>
						</dd>
					</dl>
				</div>

				<!-- 타이틀 -->
<%-- 				<%@ include file="/static_root/inc/mid.jsp" %> --%>
<!-- 				<br/> -->
				<!-- 타이틀 끝 -->	
			</div>
			<!-- 본문영역 끝 -->

			<!-- 하단영역 -->
			<%@ include file="/static_root/inc/usfooter.jsp" %>
			<!-- 하단영역 끝 -->
		</div>
	</body>
</html>
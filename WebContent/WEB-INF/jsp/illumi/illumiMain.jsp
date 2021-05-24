<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<%@ include file="/static_root/inc/illumi_head.jsp" %>
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
			$('.insight-list img').each(function() {
				if($('.insight-list').width() < this.naturalWidth){
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
			<%@ include file="/static_root/inc/illumi_header.jsp" %>
			<!-- 상단영역 끝 -->
			<!-- 본문영역 -->
			<div id="content">
				<br/>
				<div class="insight-list">
					<dl>
						<dd> 
<!-- 							<h2>회비 모금내역</h2><br/><br/> -->
<%-- 							• 현재 까지 <span style="color:#9900cc;"><b> <c:out value="${INIT_DATA.AMT_YN_CNT}" /> </b></span>세대원이 납부하여<br/>  --%>
<%-- 							• <span style="color:red;"><b> <c:out value="${INIT_DATA.TOTAL_AMT}" /> </b></span> 원이 모였습니다.<br/><br/> --%>
<!-- 							• <span style="color:#660000;">위 모금액은 지출액과 상관없이 현재까지 총 회비금액 입니다.</span><br/><br/> -->
<!-- 							<h2>위임장 수급내역</h2><br/><br/> -->
<%-- 							• 전체 수급률 : <span style="color:#ff00cc;"><b> <c:out value="${INIT_DATA.TOTAL_AVG}" /> % </b></span><br/> --%>
<%-- 							• 임대/보류지 제외 수급률 : <span style="color:#3333ff;"><b> <c:out value="${INIT_DATA.TOTAL_AVG2}" />% </b></span> <br/><br/><br/><br/> --%>
							 
							<h2>일루미 운영진분들 <br/><br/>올해에도 <span style="color:#ff66ff;">꽃길</span> 만 걸으세요   : ) </h2>  
							<br/><br/>
<!-- 							• <span style="color:red;">수정사항 있으시면 말씀 주시고 또한 이런 시스템 원치 않으시면 폐쇠할게요 </span> -->
						</dd>
					</dl>
					<img alt="" src="/static_root/images/main/illMain2.jpg" />
				</div>
				<div style="margin-top:5px; text-align:center;">
				</div>
			</div>
			<!-- 본문영역 끝 -->

			<!-- 하단영역 -->
			<%@ include file="/static_root/inc/illumi_footer.jsp" %>
			<!-- 하단영역 끝 -->
		</div>
	</body>
</html>
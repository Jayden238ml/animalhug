<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
	<%@ include file="/static_root/inc/apt_top.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		
	</script>

</head>
<body id="user" class="main_bd">
	<form name="frm" id="frm" method="post" action="">
	</form>
	<form name="login" id="login" method="post" action="#">
		<input type="hidden" name="USR_TYPE" id="USR_TYPE" value="${INIT_DATA.USR_TYPE }"/>
		<input type="hidden" name="LOGIN_TYPE" id="LOGIN_TYPE" value="MT" />
	</form>
	<div id="wrap">
		<!-- 상단영역 -->
		<%@ include file="/static_root/inc/apt_header.jsp" %>
		<!-- 상단영역 끝 -->
		
		<!-- 메인 콘텐츠영역 -->
		<div id="main_wrap">
			<div class="mn_visual">
				<div class="mn_slogan">
					<h2>우리집 만들기의 첫걸음</h2>
				</div>
				<div class="mn_quick">
					<ul class="clearfix">
						<li onclick="#">
							<dl class="clearfix">
								<dt>
									<strong>아파트 정보</strong>
									<span>Apartmane Infomation</span>
								</dt>
								<dd><span><img src="/static_root/apt/images/main/mn_quick01.png" alt="학사 일정" /></span></dd>
							</dl>
						</li>
						<li onclick="#">
							<dl class="clearfix">
								<dt>
									<strong>입주자 관리</strong>
									<span>Infomation</span>
								</dt>
								<dd><span><img src="/static_root/apt/images/main/mn_quick02.png" alt="학사 정보" /></span></dd>
							</dl>
						</li>
						<li onclick="#">
							<dl class="clearfix">
								<dt>
									<strong>실거래가 조회</strong>
									<span>Infomation</span>
								</dt>
								<dd><span><img src="/static_root/apt/images/main/mn_quick03.png" alt="학생성공 네비게이터" /></span></dd>
							</dl>
						</li>
					</ul>
				</div>
			</div>
			
			<div class="mn_cont" id="cont">
				<div class="mn_cont_btm">
					<div id="cont_box" class="box_selfAc clearfix" onclick="#">
						<h3>사이트 안내</h3>
						<p>Our Apt<br/>사이트를 소개합니다.</p>
						<a href="#">VIEW MORE <span>+</span></a>
					</div>
					<div id="cont_box" class="box_blue box_jinroRm clearfix" onclick="#">
						<h3>Q&A</h3>
						<p>궁금한 모든 내용을 물어보세요.</p>
						<a href="#">VIEW MORE <span>+</span></a>
					</div>
					<div id="cont_box" class="box_jobInfo clearfix" onclick="#">
						<h3>견적요청</h3>
						<p>DB관리의 편리성, 지금 문의해 보세요.</p>
						<a href="#">VIEW MORE <span>+</span></a>
					</div>
					<div id="cont_box" class="box_notice clearfix">
						<div class="nt_title clearfix">
							<h3>공지사항</h3>
							<a href="#">VIEW MORE <span>+</span></a>
						</div>
						<p>Our Apt 공지사항.</p>
						<ul class="nt_list">
<%-- 							<c:if test="${not empty INIT_DATA.MainBdList}"> --%>
<%-- 								<c:forEach var="item" items="${INIT_DATA.MainBdList }" varStatus="rowStatus"> --%>
									<li class="clearfix">
										부천 일루미스테이트 입주예정자분들 환영합니다.
										<span>2021-05-24</span>
<%-- 										<a href="javascript:fncMainMenuMove('MENU0059','/user/Bd/BdCm010D.do?BD_NO=1&BBS_NO=${item.BBS_NO}','MENU0007');">${item.TITLE}</a> --%>
<%-- 										<span>${item.REGDATE}</span> --%>
									</li>
									<li class="clearfix">
										한화포레나 수원장인 입주예정자분들 환영합니다.
										<span>2021-05-22</span>
									</li>
									<li class="clearfix">
										올마이티ㅋㅋㅋ퍼니 설립
										<span>2021-05-19</span>
									</li>
<%-- 								</c:forEach> --%>
<%-- 							</c:if> --%>
<%-- 							<c:if test="${empty INIT_DATA.MainBdList}"> --%>
<!-- 								<li class="clearfix">등록된 공지사항이 없습니다.</li> -->
<%-- 							</c:if> --%>
						</ul>
					</div>
				</div>
				
			</div>
			
		</div>
	</div>
	<!-- 메인 콘텐츠영역 끝 -->
	
	<!-- 하단영역 -->
	<%@ include file="/static_root/inc/apt_footer.jsp" %>
	<!-- 하단영역 끝 -->
	
</body>
</html>

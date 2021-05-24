<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 좌측영역 -->
<div id="lnb">
	<h1><a href="/admin/Mem/AdminMem.do"><span style="color:#ffffff">에니멀 허그</span></a></h1>
	<dl>
		<dt><a href="#" id="lnb-close"><i class="ion-ios-arrow-thin-left"></i></a></dt>
		<dd><a href="/admin/Mem/AdminMem.do"><i class="ion-ios-home-outline"></i></a></dd>
	</dl>

	<!-- 메뉴활성화 class="active" -->
	<div id="cssmenu">
		<ul>
			<li class='has-sub'><a href='/common/index.do?jpath=/admin/library/resource_list'><i class="fa fa-cog" aria-hidden="true"></i><span>관리자</span></a>
				<ul>
					<li><a href='/admin/mem/useMemList.do'><i></i> <span>사용자관리</span></a></li>
					<li><a href='#'><i></i> <span>로그인현황</span></a></li>
				</ul>
			</li>
			<li><a href='/admin/Bd/saBdList.do'><i class="fa fa-newspaper-o" aria-hidden="true"></i><span>공지사항 관리</span></a></li>
		</ul>
	</div>
</div>

<div id="lnb-open-btn"><i class="ion-ios-arrow-thin-right"></i></div>
<div id="lnb-close-bg">&nbsp;</div>
<!-- 좌측영역 끝 -->
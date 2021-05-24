<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="animal.framework.common.DataMap" %>
<%
	DataMap dataMap = (DataMap)request.getAttribute("INIT_DATA");
	if("".equals(dataMap.getString("SESSION_USR_ID")) || !"sukjaadmin".equals(dataMap.getString("SESSION_USR_ID"))){
		response.sendRedirect("/sukjalogin.do");
	}
%>

<script language="javascript">
	function fnLogout(){
		location.href="/logOut.do";
	}
</script>
<!-- 상단영역 (모바일) -->
<dl id="header-mobile">
	<dt><span>애</span><em>니</em><i>멀</i> <strong>관리자</strong></dt>
	<dd id="lnb-open"><i class="fa fa-th-list" aria-hidden="true"></i></dd>
</dl>
<!-- 상단영역 (모바일) 끝 -->


<!-- 상단영역 -->
<div id="header">
	<dl>
		<dt><strong>${INIT_DATA.SESSION_USR_NM}</strong> 님이 로그인 하셨습니다.</dt>
		<dd>
			<a href="/main.do" class="hvr-sweep-to-bottom" target="_blank"><i class="fa fa-external-link" aria-hidden="true"></i> <span>사이트 바로가기</span></a>
			<a href="javascript:fnLogout();" class="hvr-sweep-to-bottom"><i class="fa fa-sign-out" aria-hidden="true"></i> <span>로그아웃</span></a>
		</dd>
	</dl>
</div>
<!-- 상단영역 끝 -->
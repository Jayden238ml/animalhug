<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt"        prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"        prefix="fmt" %>
<%@ page import="animal.framework.common.DataMap" %>
<%
	DataMap dataMap = (DataMap)request.getAttribute("INIT_DATA");
	if("".equals(dataMap.getString("SESSION_USR_ID")) || !"illumi".equals(dataMap.getString("SESSION_USR_ID"))){
		response.sendRedirect("/main.do");
	}
%>
<!-- 상단영역 -->
<div id="header">
	<dl>
		<dt><a href="/illumi/illumiMain.do"><img src="/static_root/images/common/illumi_logo.png" alt="일루미 로고" title="일루미 로고" /></a></dt>
		<dd>
			<ul id="menuArea">
				<li><a href="/illumi/illumiMain.do">운영진</a></li>
				<li><a href="/illumi/acct_list.do">회계관리</a></li>
			</ul>
		</dd>
		<dt style="padding-top:2%;">
			<c:if test="${not empty INIT_DATA.SESSION_USR_ID }">
				<h1><span>${INIT_DATA.SESSION_USR_NICK}</span> 님 반갑습니다.</h1>
			</c:if>
		</dt>
	</dl>

	<div id="subMenuArea">
		<ul>
			<li>
				<h1>운영진</h1>
				<ul>
					<li><a href="/illumi/warrant_List.do">위임장 수급목록</a></li>
					<li><a href="/illumi/warrant_Avg.do">위임장 수급률</a></li>
					<li><a href="/illumi/meet_List.do">일루미 모임관리</a></li>
				</ul>
			</li>
			<li>
				<h1>회계관리</h1>
				<ul> 
					<li><a href="/illumi/acct_list.do">회비 입금관리</a></li>
					<li><a href="#">지출내역 관리</a></li>
				</ul>
			</li>
		</ul>
	</div>
</div>
<!-- 상단영역 끝 -->


<!-- 상단영역 - 모바일 -->
<div id="header-mobile">
	<dl class="hm-menu">
		<dt><i class="fa fa-bars" aria-hidden="true" id="mobileLnbOpen"></i></dt>
		<dd><a href="/illumi/illumiMain.do"><img src="/static_root/images/common/illumi_logo.png" height="30" alt="일루미 로고" title="일루미 로고" /></a></dd>
	</dl>
	<div class="hm-total">
		<dl>
			<dt>MENU</dt>
			<dd><i id="mobileLnbClose" class="fa fa-times" aria-hidden="true"></i></dd>
		</dl>
		<div id="cssmenu">
			<ul>
				<li class='has-sub'><a href='/illumi/illumiMain.do'><i class="fa fa-newspaper-o" aria-hidden="true"></i><span>운영진</span></a>
					<ul>
						<li><a href='/illumi/warrant_List.do'><i></i> <span>위임장 수급목록</span></a></li>
						<li><a href='/illumi/warrant_Avg.do'><i></i> <span>위임장 수급률</span></a></li>
						<li><a href='/illumi/meet_List.do'><i></i> <span>일루미 모임관리</span></a></li>
					</ul>
				</li>
				<li class='has-sub'><a href='/illumi/acct_list.do'><i class="fa fa-newspaper-o" aria-hidden="true"></i><span>회계관리</span></a>
					<ul>
						<li><a href='/illumi/acct_list.do'><i></i> <span>회비 입금관리</span></a></li>
						<li><a href='#'><i></i> <span>지출내역 관리</span></a></li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
</div>
<!-- 상단영역 - 모바일 끝 -->

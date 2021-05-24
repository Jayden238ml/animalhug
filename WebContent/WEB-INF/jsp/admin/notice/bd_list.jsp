<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/static_root/inc/admin_head.jsp" %>
<jsp:useBean id="now" class="java.util.Date"/>
<fmt:formatDate value="${now}" pattern="yyyy.MM.dd" var="todaydate"/>
		
<script language="javascript">
	var PAGE_SIZE = '${INIT_DATA.PAGE_SIZE}';
	$(document).ready(function(){
		fncMakePageBody('${INIT_DATA.TOTAL_CNT}','${INIT_DATA.CURR_PAGE}');
	});
	
	//페이징
	var page_List = function(pageNo) {
	    $("#CURR_PAGE").val(pageNo);        
	    $('#ListFrm').submit();
	};
	
	function fnList(){
		$('#frm').attr("action", "/admin/Bd/saBdList.do");
		$('#frm').submit();
	}
	
	function fnAddNotice(){
		$('#frm').attr("action", "/admin/notice/notice_write.do");
		$('#frm').submit();
	}
</script>
</head>

<body>
	<div id="wrap">			
		<!-- 상단영역 -->
		<%@ include file="/static_root/inc/admin_header.jsp" %>
		<!-- 상단영역 끝 -->

		<!-- 좌측영역 -->
		<%@ include file="/static_root/inc/admin_lnb.jsp" %>
		<!-- 좌측영역 끝 -->

		<!-- 본문영역 -->
		<div id="content">		
			<!-- 타이틀/네비 -->
			<dl class="title-navi">
				<dt>공지사항관리</dt>
				<dd>
					<i class="fa fa-home" aria-hidden="true"></i> 홈 > 관리자 > <span>공지사항관리</span>
				</dd>
			</dl>
			<!-- 타이틀/네비 -->
		
			<form name="frm"  id="frm" method="post" action="">
			<input type="hidden" name="CURR_PAGE"	id="CURR_PAGE"		value="<c:out value="${INIT_DATA.CURR_PAGE}"/>"/>
			<input type="hidden" name="PAGE_SIZE"	id="PAGE_SIZE"		value="<c:out value="${INIT_DATA.PAGE_SIZE}"/>"/>
			<input type="hidden" name="TOTAL_CNT"	id="TOTAL_CNT"		value="<c:out value="${INIT_DATA.TOTAL_CNT}"/>"/>
			<input type="hidden" name="MEMBER_ID" id="MEMBER_ID" value=""/>
			<fieldset>
				<legend>게시물 검색</legend>
				<div class="title-search">
					<dl>
						<dt><span>Total. ${INIT_DATA.TOTAL_CNT } </span></dt>
						<dd>
<!-- 							<select name="SCH_RET_YN" id="SCH_RET_YN" title="구분" class="form-control w24p"> -->
<!-- 								<option value=""  >탈퇴여부</option> -->
<%-- 								<option value="Y" <c:if test="${INIT_DATA.SCH_RET_YN eq 'Y'}">selected</c:if>>탈퇴</option> --%>
<%-- 								<option value="N" <c:if test="${INIT_DATA.SCH_RET_YN eq 'N'}">selected</c:if>>미탈퇴</option> --%>
<!-- 							</select> -->
							<button type="submit" onclick="fnSearch();" class="btn btn-dark"><i class="fa fa-search" aria-hidden="true"></i> 검색</button>
							<a href="javascript:fnAddNotice();" class="btn btn-danger" data-toggle="modal"><i class="fa fa-list-alt" aria-hidden="true"></i>공지등록</a>
						</dd>
					</dl>
				</div>
			</fieldset>
			
			<!-- 본문영역 ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
			<div>
		
			<div class="list-table">
				<table cellpadding="0" cellspacing="0" summary="목록">
					<caption>목록</caption>
					<colgroup>
						<col width="5%" />
						<col width="45%" />
						<col width="10%" />
						<col width="10%" />
						<col width="10%" />
						<col width="10%" />
					</colgroup>
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>게시판타입</th>
							<th>게시여부</th>
							<th>조회수</th>
							<th>등록일</th>
							<th>관리</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${!empty INIT_DATA.resultList }">
						<c:forEach items="${INIT_DATA.resultList }" var="item" varStatus="rowStatus">
						<tr>
							<td><c:out value="${item.RNUMUM}" /></td>
							<td><c:out value="${item.TITLE}" /></td>
							<td><c:out value="${item.BOARD_TYPE_NM}" /></td>
							<td><c:out value="${item.OPEN_YN_NM}" /></td>
							<td><c:out value="${item.VIEW_CNT}" /></td>
							<td><c:out value="${item.REGDATE}" /></td>
							<td>
								<a href="javascript:" class="btn btn-dark btn-xs">수정</a>
							</td>
						</tr>
						</c:forEach>
						</c:if>
						<c:if test="${empty INIT_DATA.resultList}">
						<tr>
							<td colspan="6">
								<div class="list-no">
									<p><img src="/static_root/images/btnIcn/icn_list_no.png" alt="" title="" /></p>
									<h1>목록이 없습니다.</h1>
								</div>
							</td>
						</tr>
						</c:if>
						</tbody>
					</table>
				</div>
				<dl class="list-paging">
					<dd id="paging_bar">
					</dd>
				</dl>				
			</div>
			</form>
		</div>
		
		<!-- 하단영역 -->
		<%@ include file="/static_root/inc/admin_footer.jsp" %>
		<!-- 하단영역 끝 -->
	</div>
</body>
</html>
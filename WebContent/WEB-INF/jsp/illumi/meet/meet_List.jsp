<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt"        prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"        prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1" />

<%@ include file="/static_root/inc/illumi_head.jsp" %>
<script type="text/javascript">
	var PAGE_SIZE = '${INIT_DATA.PAGE_SIZE}';
	$(document).ready(function(){
		fncMakePageBody('${INIT_DATA.TOTAL_CNT}','${INIT_DATA.CURR_PAGE}');

	});
	
	//페이징
	var page_List = function(pageNo) {
	    $("#CURR_PAGE").val(pageNo);        
	    $('#ListFrm').submit();
	};
	
	function fnSearch(){
		$("#CURR_PAGE").val("1"); 
		$('#ListFrm').attr("action", "/illumi/meet_List.do").submit();	
		$('#ListFrm').attr("target","_self");
		$('#ListFrm').submit();
	}
	
	
	function fnDetail(seq){
		$('#MEET_SEQ').val(seq);
		$('#SCH_TYPE').val("");
		$('#SCH_WORD').val("");
		$('#ListFrm').attr("action", "/illumi/meetReqList.do").submit();
	}
	
	function fnMeetWrite(){
		alert("나중에 만들게요...ㅠ");
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
			<div id="rightCnt">
			<form name="ListFrm" id="ListFrm" method="post" action="/illumi/meet_List.do">
			<input type="hidden" name="CURR_PAGE"	id="CURR_PAGE"		value="<c:out value="${INIT_DATA.CURR_PAGE}"/>"/>
			<input type="hidden" name="PAGE_SIZE"	id="PAGE_SIZE"		value="<c:out value="${INIT_DATA.PAGE_SIZE}"/>"/>
			<input type="hidden" name="TOTAL_CNT"	id="TOTAL_CNT"		value="<c:out value="${INIT_DATA.TOTAL_CNT}"/>"/>
			<input type="hidden" name="MEET_SEQ"	id="MEET_SEQ"	value=""/>
			<br/>
			<dl class="list-title-btn">
			</dl>
			<br/><br/>
			<!-- 리스트 - 정보/버튼 -->
			<div class="list-search2">
				<dl>
					<dt>Total. ${INIT_DATA.TOTAL_CNT }</dt>
					<dd>
						<fieldset>
							<legend>검색</legend>
							<dl>
								<dt>
									<select name="SCH_TYPE" id="SCH_TYPE" style="width: 70px;">
										<option value="">전체</option>
										<option value="01" <c:if test="${INIT_DATA.SCH_TYPE eq '01'}">selected="selected"</c:if>>모임명</option>
										<option value="02" <c:if test="${INIT_DATA.SCH_TYPE eq '02'}">selected="selected"</c:if> >장소</option>
										<option value="03" <c:if test="${INIT_DATA.SCH_TYPE eq '03'}">selected="selected"</c:if>>모임일자</option>
									</select>&nbsp;
									<input type="text" name="SCH_WORD" id="SCH_WORD" title="검색어" value="${INIT_DATA.SCH_WORD}" maxlength="30" class="form-control" placeholder="검색어를 입력하세요." />
								</dt>
								<dd><a href="#" onClick="javascript:fnSearch();"><i class="xi-search"></i></a></dd>
							</dl>
						</fieldset>
					</dd>
				</dl>
			</div>
			<!-- 리스트 - 정보/버튼 끝 -->
			<!-- 리스트 -->
			<div class="tableList tableTR">
				<table summary="교육과정 목록">
					<caption>교육과정 목록</caption>
					<colgroup>
						<col width="*" />
						<col width="10%" />
						<col width="15%" />
						<col width="13%" />
						<col width="13%" />
					</colgroup>
					<thead>
						<tr>
							<th>모임명</th>
							<th>대상<br/>인원</th>
							<th>총 참석<br/>인원</th>
							<th>총 예상<br/>입금액</th>
							<th>현재<br/>입금액</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${INIT_DATA.resultList }" var="item" varStatus="rowStatus">
						<tr>
							<td><a href="javascript:fnDetail('<c:out value="${item.MEET_SEQ}" />');"><c:out value="${item.MEET_NM }"/></a></td>
							<td><a href="javascript:fnDetail('<c:out value="${item.MEET_SEQ}" />');"><c:out value="${item.TARGET_CNT }"/>명</a></td>
							<td><a href="javascript:fnDetail('<c:out value="${item.MEET_SEQ}" />');"><c:out value="${item.TOTAL_CNT }"/>명</a></td>
							<td><a href="javascript:fnDetail('<c:out value="${item.MEET_SEQ}" />');"><c:out value="${item.DES_PLAN_AMT }"/>원</a></td>
							<td><a href="javascript:fnDetail('<c:out value="${item.MEET_SEQ}" />');"><c:out value="${item.DES_AMT }"/>원</a></td>
						</tr>
					</c:forEach>
					<c:if test="${empty INIT_DATA.resultList }">
						<tr>
							<td colspan="5">조회된 자료가 없습니다.</td>
						</tr>
					</c:if>
					</tbody>
				</table>
			</div>
			<dl class="list-title-btn">
<!-- 				<dd><a href="javascript:fnMeetWrite();" class="btn btn-secondary w150"><i class="fa fa-pencil-square-o" aria-hidden="true"></i> 등록</a></dd> -->
			</dl>
			<!-- 리스트 끝 -->
			<!-- 페이징 -->
			<div class="list-paging pt30 pb100">
				<dd id="paging_bar">
				</dd>
			</div>
			<!-- 페이징 끝 -->
		
			</form>
			</div>
		</div>
		<!-- 본문영역 끝 -->
		<!-- 하단영역 -->
		<%@ include file="/static_root/inc/illumi_footer.jsp" %>
		<!-- 하단영역 끝 -->
	</div>
</body>
</html>
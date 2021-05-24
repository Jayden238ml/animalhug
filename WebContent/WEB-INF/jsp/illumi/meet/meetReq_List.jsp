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
		$('#ListFrm').attr("action", "/illumi/meetReqList.do").submit();	
	}
	
	function fnList(){
		$('#ListFrm').attr("action", "/illumi/meet_List.do").submit();	
	}
	
	
	function fnDetail(seq){
		$('#MEET_SEQ').val(seq);
		$('#ListFrm').attr("action", "/illumi/meetReqView.do").submit();
	}
	
	function fnMainList(){
		$('#ListFrm').attr("action", "/illumi/meet_List.do").submit();
	}
	
	function fnWrite(seq){
		$('#MEET_DTL_SEQ').val(seq);
		$('#ListFrm').attr("action", "/illumi/meet_Write.do").submit();
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
			<form name="ListFrm" id="ListFrm" method="post" action="/illumi/meetReqList.do">
			<input type="hidden" name="CURR_PAGE"	id="CURR_PAGE"		value="<c:out value="${INIT_DATA.CURR_PAGE}"/>"/>
			<input type="hidden" name="PAGE_SIZE"	id="PAGE_SIZE"		value="<c:out value="${INIT_DATA.PAGE_SIZE}"/>"/>
			<input type="hidden" name="TOTAL_CNT"	id="TOTAL_CNT"		value="<c:out value="${INIT_DATA.TOTAL_CNT}"/>"/>
			<input type="hidden" name="MEET_SEQ"	id="MEET_SEQ"	value="<c:out value="${INIT_DATA.MEET_SEQ}"/>"/>
			<input type="hidden" name="MEET_DTL_SEQ"	id="MEET_DTL_SEQ"	value=""/>
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
									<select name="SCH_DES_YN" id="SCH_DES_YN" style="width: 70px;">
										<option value="">전체</option>
										<option value="Y" <c:if test="${INIT_DATA.SCH_DES_YN eq 'Y'}">selected="selected"</c:if>>입금완료</option>
										<option value="N" <c:if test="${INIT_DATA.SCH_DES_YN eq 'N'}">selected="selected"</c:if>>미입금</option>
									</select>&nbsp;
									<input type="text" name="SCH_WORD" id="SCH_WORD" title="검색어" value="${INIT_DATA.SCH_WORD}" maxlength="30" class="form-control" placeholder="신청자 or 입금자명" />
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
					</colgroup>
					<thead>
						<tr>
							<th>신청자</th>
							<th>대상인원</th>
							<th>입금금액</th>
							<th>입금여부</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${INIT_DATA.resultList }" var="item" varStatus="rowStatus">
						<tr>
							<td><a href="javascript:fnWrite('<c:out value="${item.MEET_DTL_SEQ}" />');"><c:out value="${item.NICK }"/></a></td>
							<td><a href="javascript:fnWrite('<c:out value="${item.MEET_DTL_SEQ}" />');"><c:out value="${item.TARGET_CNT }"/>명</a></td>
							<td><a href="javascript:fnWrite('<c:out value="${item.MEET_DTL_SEQ}" />');"><c:out value="${item.DES_PLAN_AMT }"/>원</a></td>
							<td>
								<a href="javascript:fnWrite('<c:out value="${item.MEET_DTL_SEQ}" />');">
									<c:if test="${item.DES_YN eq 'Y'}">
										<span style="color:#843817;"><c:out value="${item.DES_YN_NM}" /></span> 
									</c:if>
									<c:if test="${item.DES_YN eq 'N'}">
										<span style="color:red;"><c:out value="${item.DES_YN_NM}" /></span> 
									</c:if>
								</a>
							</td>
						</tr>
					</c:forEach>
					<c:if test="${empty INIT_DATA.resultList }">
						<tr>
							<td colspan="4">조회된 자료가 없습니다.</td>
						</tr>
					</c:if>
					</tbody>
				</table>
			</div>
			<div class="list-btn">
				<ul>
					<li><a href="javascript:fnWrite();" class="btn-add">등록</a></li>
					<li><a href="javascript:fnList();" class="btn-common">목록</a></li>
				</ul>
			</div>
<!-- 			<dl class="list-title-btn"> -->
<!-- 				<dd><a href="javascript:fnWrite();" class="btn btn-secondary w150"><i class="fa fa-pencil-square-o" aria-hidden="true"></i> 등록</a></dd> -->
<!-- 			</dl> -->
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
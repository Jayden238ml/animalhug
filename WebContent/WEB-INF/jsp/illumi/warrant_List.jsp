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
		if("${INIT_DATA.SCH_DANZI}" != ""){
			fnGetDongData("${INIT_DATA.SCH_DANZI}");
		}
		var filter = "win16|win32|win64|mac";
		if(navigator.platform){
			if(0 > filter.indexOf(navigator.platform.toLowerCase())){
				$('#EXBTN').hide();
				$('#LMSEXBTN').hide();
			}else{
				$('#EXBTN').show();
				$('#LMSEXBTN').show();
			}
		}

	});
	
	//페이징
	var page_List = function(pageNo) {
	    $("#CURR_PAGE").val(pageNo);        
	    $('#ListFrm').submit();
	};
	
	function fnSearch(){
		 $("#CURR_PAGE").val("1");     
		$('#ListFrm').attr("action", "/illumi/warrant_List.do").submit();	
	}
	
	function fnBoardWrite(){
		alert("아직 안만들었어요 ㅠㅠ");
		
	}
	
	function fnGetDongData(val){
		if(val == "1"){
			$("select#SCH_DONG option").remove();
			$("#SCH_DONG").append("<option value=''>전체</option>");
			for(var i = 1; i < 8; i ++){
				$("#SCH_DONG").append("<option value='10"+i+"'>10"+i+"동</option>");
			}
		}else if(val == "2"){
			$("select#SCH_DONG option").remove();
			$("#SCH_DONG").append("<option value=''>전체</option>");
			for(var i = 1; i < 5; i ++){
				$("#SCH_DONG").append("<option value='20"+i+"'>20"+i+"동</option>");
			}
		}else if(val == "3"){
			$("select#SCH_DONG option").remove();
			$("#SCH_DONG").append("<option value=''>전체</option>");
			for(var i = 1; i < 8; i ++){
				$("#SCH_DONG").append("<option value='30"+i+"'>30"+i+"동</option>");
			}
		}else if(val == "4"){
			$("select#SCH_DONG option").remove();
			$("#SCH_DONG").append("<option value=''>전체</option>");
			for(var i = 1; i < 20; i ++){
				if(i > 9){
					$("#SCH_DONG").append("<option value='4"+i+"'>4"+i+"동</option>");
				}else{
					$("#SCH_DONG").append("<option value='40"+i+"'>40"+i+"동</option>");
				}
			}
		}
		
		if("${INIT_DATA.SCH_DONG}" != ""){
			$("#SCH_DONG").val("${INIT_DATA.SCH_DONG}");
		}
	}
	
	function fnDetail(seq){
		$('#WARRANT_SEQ').val(seq);
		$('#ListFrm').attr("action", "/illumi/detailView.do").submit();
	}
	
	// 엑셀 다운로드
	function fnExcel(){
		$('#ListFrm').attr("target", "_self");
		$('#ListFrm').attr("action", "/illumi/ExcelDown.do");
		$('#ListFrm').submit();
	}
	
	function fnLmsExcel(){
		$('#ListFrm').attr("target", "_self");
		$('#ListFrm').attr("action", "/illumi/LmsExcelDown.do");
		$('#ListFrm').submit();
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
			<form name="ListFrm" id="ListFrm" method="post" action="/illumi/warrant_List.do">
			<input type="hidden" name="CURR_PAGE"	id="CURR_PAGE"		value="<c:out value="${INIT_DATA.CURR_PAGE}"/>"/>
			<input type="hidden" name="PAGE_SIZE"	id="PAGE_SIZE"		value="<c:out value="${INIT_DATA.PAGE_SIZE}"/>"/>
			<input type="hidden" name="TOTAL_CNT"	id="TOTAL_CNT"		value="<c:out value="${INIT_DATA.TOTAL_CNT}"/>"/>
			<input type="hidden" name="WARRANT_SEQ"	id="WARRANT_SEQ"	value=""/>
			<br/>
			<dl class="list-title-btn">
			</dl>
			<br/><br/><br/><br/><br/>
			<!-- 리스트 - 정보/버튼 -->
			<fieldset>
				<legend>검색영역</legend>
				<div class="searchTableLot">
					<div class="schInfo">
						<table summary="검색테이블">
							<caption>검색테이블</caption>
							<colgroup>
								<col width="9%" class="th-width" />
								<col width="*" class="td-width" />
							</colgroup>
							<tbody>
								<tr>
									<th><label for="SCH_DANZI">단지별 검색</label></th>
									<td>
										<select name="SCH_DANZI" id="SCH_DANZI" onchange="fnGetDongData(this.value);" >
											<option value="">전체</option>
											<option value="1" <c:if test="${INIT_DATA.SCH_DANZI eq '1'}">selected="selected"</c:if> >1단지</option>
											<option value="2" <c:if test="${INIT_DATA.SCH_DANZI eq '2'}">selected="selected"</c:if>>2단지</option>
											<option value="3" <c:if test="${INIT_DATA.SCH_DANZI eq '3'}">selected="selected"</c:if>>3단지</option>
											<option value="4" <c:if test="${INIT_DATA.SCH_DANZI eq '4'}">selected="selected"</c:if>>4단지</option>
										</select>&nbsp;
										<select name="SCH_DONG" id="SCH_DONG" >
											<option value="">전체</option>
										</select>						
									</td>
								</tr>
								<tr>
									<th><label for="SCH_LEVEL">회원등급</label></th>
									<td>
										<select name="SCH_LEVEL" id="SCH_LEVEL" >
											<option value="">전체</option>
											<option value="Y" <c:if test="${INIT_DATA.SCH_LEVEL eq 'Y'}">selected="selected"</c:if> >위임장 제출</option>
											<option value="N" <c:if test="${INIT_DATA.SCH_LEVEL eq 'N'}">selected="selected"</c:if>>위임장 미제출</option>
										</select>&nbsp;
										<select name="SCH_AMT_YN" id="SCH_AMT_YN" >
											<option value="">전체</option>
											<option value="Y" <c:if test="${INIT_DATA.SCH_AMT_YN eq 'Y'}">selected="selected"</c:if> >회비납부</option>
											<option value="N" <c:if test="${INIT_DATA.SCH_AMT_YN eq 'N'}">selected="selected"</c:if>>회비 미납부</option>
										</select>	
										&nbsp;
										<input type="text" value="${INIT_DATA.SCH_WORD }" title="이름 / 닉네임 / 호수" name="SCH_WORD" id="SCH_WORD" class="schBox" placeholder="이름 / 닉네임 / 호수" style="height: 40px !important" />
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="sch-btn"><a href="#" onclick="fnSearch();" class="schBtn">검색</a></div>
				</div>
			</fieldset>
			<c:if test="${INIT_DATA.DEVICE_TYPE eq 'P'}">
				<a href="javascript:fnExcel();" class="btn btn-success" id="EXBTN"><i class="fa fa-file-excel-o" aria-hidden="true"></i> 엑셀다운로드</a>
				<a href="javascript:fnLmsExcel();" class="btn btn-success" id="LMSEXBTN"><i class="fa fa-file-excel-o" aria-hidden="true"></i>LMS발신용 다운로드</a>
			</c:if>
			<br/><br/>
			<!-- 리스트 - 정보/버튼 끝 -->
			<!-- 리스트 -->
			<p class="list-total">
				전체 <strong><c:out value='${INIT_DATA.TOTAL_CNT}'/></strong>건 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
			</p>
			<p class="list-total">
				전체 수급률 : <span style="color:red;"><strong><c:out value='${INIT_DATA.TOTAL_AVG}'/> %</strong></span> &nbsp;&nbsp;&nbsp;
				임대/보류지 제외 수급률 : <span style="color:red;"><strong><c:out value='${INIT_DATA.TOTAL_AVG2}'/> %</strong></span>
			</p>
			<!-- 리스트 시작 -->
			<div class="tableList tableTR">
				<table summary="교육과정 목록">
					<caption>교육과정 목록</caption>
					<colgroup>
						<col width="9%" />
						<col width="24%" />
						<col width="*" />
						<col width="10%" />
						<col width="7%" />
						<col width="5%" />
					</colgroup>
					<thead>
						<tr>
							<th>동/호수</th>
							<th>성명</th>
							<th>연락처</th>
							<th>위임장<br/>제출여부</th>
							<th>회비<br/>납부</th>
							<th>등급</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${INIT_DATA.resultList }" var="item" varStatus="rowStatus">
						<tr>
							<td><a href="javascript:fnDetail('<c:out value="${item.WARRANT_SEQ}" />');"><c:out value="${item.DONG }"/>동/<c:out value="${item.HOSU }"/>호</a></td>
							<td>
								<a href="javascript:fnDetail('<c:out value="${item.WARRANT_SEQ}" />');">
									<c:out value="${item.USER_NM }"/>
									<c:if test="${item.NICK ne ''}">
										(<c:out value="${item.NICK }"/>)
									</c:if>
								</a>
							</td>
							<td><c:out value="${item.HP }"/></td>
							<td>
							<a href="javascript:fnDetail('<c:out value="${item.WARRANT_SEQ}" />');">
								<c:if test="${item.WARRANT_YN eq 'N'}">
									<span style="color:#ff3366;"><c:out value="${item.WARRANT_YN_NM }"/></span>
								</c:if>
								<c:if test="${item.WARRANT_YN eq 'Y'}">
									<c:out value="${item.WARRANT_YN_NM }"/>
								</c:if>
							</a></td>
							<td>
								<c:if test="${item.AMT_YN eq 'Y'}">
									O
								</c:if>
								<c:if test="${item.AMT_YN eq 'N'}">
									<span style="color:#ff3366;">X</span>
								</c:if>
							</td>
							<td>
<%-- 								<c:if test="${item.GRADE eq 'G'}"><img src="/static_root/images/common/gold.png" alt="골드" title="골드" width="100%" height="45%"/></c:if> --%>
<%-- 								<c:if test="${item.GRADE eq 'S'}"><img src="/static_root/images/common/silver.png" alt="실버" title="실버" width="100%" height="35%" /></c:if> --%>
								<c:if test="${item.GRADE eq 'G'}"><span style="color:#be9629">골드</span></c:if>
								<c:if test="${item.GRADE eq 'S'}"><span style="color:#6d7b83">실버</span></c:if>
								<c:if test="${item.GRADE eq 'I'}"><span style="color:red">인증</span></c:if>
							</td>
						</tr>
					</c:forEach>
					<c:if test="${empty INIT_DATA.resultList }">
						<tr>
							<td colspan="6">조회된 자료가 없습니다.</td>
						</tr>
					</c:if>
					</tbody>
				</table>
			</div>
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
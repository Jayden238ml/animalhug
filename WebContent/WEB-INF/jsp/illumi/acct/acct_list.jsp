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
			}else{
				$('#EXBTN').show();
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
		$('#ListFrm').attr("action", "/illumi/acct_list.do").submit();	
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
		
	}
	
	function fnLmsExcel(){
		
	}
	
	function fn_viewCal(seq){
// 		$("#viewCal"+seq).slideToggle( "slow" );
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
			<form name="ListFrm" id="ListFrm" method="post" action="/illumi/acct_list.do">
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
<!-- 				<div class="searchTableLot"> -->
<!-- 					<div class="schInfo"> -->
<!-- 						<table summary="검색테이블"> -->
<%-- 							<caption>검색테이블</caption> --%>
<%-- 							<colgroup> --%>
<%-- 								<col width="9%" class="th-width" /> --%>
<%-- 								<col width="*" class="td-width" /> --%>
<%-- 							</colgroup> --%>
<!-- 							<tbody> -->
<!-- 								<tr> -->
<!-- 									<th><label for="SCH_DANZI">단지별 검색</label></th> -->
<!-- 									<td> -->
<!-- 										<select name="SCH_DANZI" id="SCH_DANZI" onchange="fnGetDongData(this.value);" > -->
<!-- 											<option value="">전체</option> -->
<%-- 											<option value="1" <c:if test="${INIT_DATA.SCH_DANZI eq '1'}">selected="selected"</c:if> >1단지</option> --%>
<%-- 											<option value="2" <c:if test="${INIT_DATA.SCH_DANZI eq '2'}">selected="selected"</c:if>>2단지</option> --%>
<%-- 											<option value="3" <c:if test="${INIT_DATA.SCH_DANZI eq '3'}">selected="selected"</c:if>>3단지</option> --%>
<%-- 											<option value="4" <c:if test="${INIT_DATA.SCH_DANZI eq '4'}">selected="selected"</c:if>>4단지</option> --%>
<!-- 										</select>&nbsp; -->
<!-- 										<select name="SCH_DONG" id="SCH_DONG" > -->
<!-- 											<option value="">전체</option> -->
<!-- 										</select>						 -->
<!-- 									</td> -->
<!-- 								</tr> -->
<!-- 								<tr> -->
<!-- 									<th><label for="SCH_LEVEL">회원등급</label></th> -->
<!-- 									<td> -->
<!-- 										<select name="SCH_LEVEL" id="SCH_LEVEL" > -->
<!-- 											<option value="">전체</option> -->
<%-- 											<option value="Y" <c:if test="${INIT_DATA.SCH_LEVEL eq 'Y'}">selected="selected"</c:if> >위임장 제출</option> --%>
<%-- 											<option value="N" <c:if test="${INIT_DATA.SCH_LEVEL eq 'N'}">selected="selected"</c:if>>위임장 미제출</option> --%>
<!-- 										</select>&nbsp; -->
<!-- 										<select name="SCH_AMT_YN" id="SCH_AMT_YN" > -->
<!-- 											<option value="">전체</option> -->
<%-- 											<option value="Y" <c:if test="${INIT_DATA.SCH_AMT_YN eq 'Y'}">selected="selected"</c:if> >회비납부</option> --%>
<%-- 											<option value="N" <c:if test="${INIT_DATA.SCH_AMT_YN eq 'N'}">selected="selected"</c:if>>회비 미납부</option> --%>
<!-- 										</select>	 -->
<!-- 										&nbsp; -->
<%-- 										<input type="text" value="${INIT_DATA.SCH_WORD }" title="이름 / 닉네임 / 호수" name="SCH_WORD" id="SCH_WORD" class="schBox" placeholder="이름 / 닉네임 / 호수" style="height: 40px !important" /> --%>
<!-- 									</td> -->
<!-- 								</tr> -->
<!-- 							</tbody> -->
<!-- 						</table> -->
<!-- 					</div> -->
<!-- 					<div class="sch-btn"><a href="#" onclick="fnSearch();" class="schBtn">검색</a></div> -->
<!-- 				</div> -->
			</fieldset>
			<a href="javascript:fnExcel();" class="btn btn-success" id="EXBTN"><i class="fa fa-file-excel-o" aria-hidden="true"></i> 입금내역업로드</a>
<!-- 			<a href="javascript:fnLmsExcel();" class="btn btn-success" id="LMSEXBTN"><i class="fa fa-file-excel-o" aria-hidden="true"></i>지출내역 업로드</a> -->
			<br/><br/>
			<!-- 리스트 - 정보/버튼 끝 -->
			<!-- 리스트 -->
			<div class="tableView">
				<table summary="교육정보 조회">
					<caption>교육정보 조회</caption>
					<colgroup>
						<col width="25%">
						<col width="*">
					</colgroup>
					<tbody>
						<tr>
							<th>총 입금액</th>
							<td><span style="color:red;"><b><c:out value="${INIT_DATA.TOTAL_AMT}" /></b></span></td>
						</tr>
					</tbody>
				</table>
			</div>
			<br/>  
			<span style="color:red;">* 현재까지 입예협 통장에 입금된 내역이며 운영진 및 콩순이 / 쭌 / S 님 금액 미포함 (금액확정 후 적용예정)</span>  
			<br/> 
			<br/> 
			<p class="list-total">
				전체 <strong><c:out value='${INIT_DATA.TOTAL_CNT}'/></strong>건 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
			</p>
			<!-- 리스트 시작 -->
			<div class="tableList tableTR">
				<table summary="교육과정 목록">
					<caption>교육과정 목록</caption>
					<colgroup>
						<col width="23%" />
						<col width="23%" />
						<col width="*" /> 
					</colgroup>
					<thead>
						<tr>
							<th>일자</th>
							<th>입금액</th>
							<th>입금자명</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${INIT_DATA.resultList }" var="item" varStatus="rowStatus">
						<tr>
							<a href="#" onclick="fn_viewCal('<c:out value="${item.ACCT_MSTR_SEQ}"/>');">
							<td>
								<a href="#" onclick="fn_viewCal('<c:out value="${item.ACCT_MSTR_SEQ}"/>');">
									<c:out value="${item.ACCT_DATE }"/>
								</a>
							</td>
							<td><c:out value="${item.IN_AMT }"/></td>
							<td><c:out value="${item.CONT }"/></td>
						</tr>
						<tr>
							<div id="viewCal<c:out value="${item.ACCT_MSTR_SEQ}"/>"  style="display:none; padding:20px 25px; border-top:1px dashed #e5e5e5; background:#fff;" >
								<p class="calPlace">
<!-- 									<div > -->
<!-- 										<table summary="교육정보 조회"> -->
<%-- 											<caption>교육정보 조회</caption> --%>
<%-- 											<colgroup> --%>
<%-- 												<col width="20%"> --%>
<%-- 												<col width="30%"> --%>
<%-- 												<col width="20%"> --%>
<%-- 												<col width="30%"> --%>
<%-- 											</colgroup> --%>
<!-- 											<tbody> -->
<!-- 												<tr>  -->
<!-- 													<th>입금액</th> -->
<%-- 													<td><c:out value="${item.IN_AMT }"/></td> --%>
<!-- 													<th>출금액</th> -->
<%-- 													<td><c:out value="${item.OUT_AMT }"/></td> --%>
<!-- 												</tr> -->
<!-- 											</tbody> -->
<!-- 										</table> -->
<!-- 									</div> -->
								</p>
							</div>
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
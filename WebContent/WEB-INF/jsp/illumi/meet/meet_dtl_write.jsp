<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt"        prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"        prefix="fmt" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<!--<meta property="og:image" content="/static_root/images/common/meta_img.jpg">-->
	<%@ include file="/static_root/inc/illumi_head.jsp" %>
<script type="text/javascript">
	var msg = "수정";
	$(document).ready(function(){
		$(window).resize(function() { 
			fnAutoResize();
		});
		if("${INIT_DATA.MEET_DTL_SEQ}" == ""){
			$('#SBTN').text("등록");
			msg = "등록";
			$('#DBTN').hide();
		}
	});
	
	window.onload = function () {
		fnAutoResize();
	}
	
	function fnAutoResize(){
		var windowWidth = $( window ).width();	
		$('.va-content img').each(function() {
			if($('.va-content').width() < this.naturalWidth){
				$(this).css("width", "100%");
				$(this).css("height", "auto");
			}else{
				$(this).css("width", this.naturalWidth);
				$(this).css("height", "auto");
			}
		});
	}
	
	
	function fnList(){
		$('#dtlFrm').attr("action", "/illumi/meetReqList.do").submit();
	}
	
	function fnModify(){
		if(confirm(msg + "하시겠습니까?")){
			$.ajax({
				 type		: "POST"
				,url		: "/illumi/insertMeetDtlData.do"
				,dataType	: "json"
				,data: $("#dtlFrm").serialize()
				,success : function(transport) {
					if(transport.ERROR_CD == '999'){
						alert(msg + " 중 에러가 발생 하였습니다.");	
						return;
					}else{
						if(confirm(msg + "완료 되었습니당.")){
							fnList();
						}
					}
				}
			});
		}
	}
	
	function fnDel(){
		if(confirm("삭제 하시겠습니까?")){
			$.ajax({
				 type		: "POST"
				,url		: "/illumi/DeleteMeetDtlData.do"
				,dataType	: "json"
				,data: $("#dtlFrm").serialize()
				,success : function(transport) {
					if(transport.ERROR_CD == '999'){
						alert("삭제 중 에러가 발생 하였습니다.");	
						return;
					}else{
						if(confirm("삭제 완료 되었습니당.")){
							fnList();
						}
					}
				}
			});
		}
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
			<form name="dtlFrm" id="dtlFrm" method="post" action="#" class="form-inline">
<%-- 				<input type="hidden" name="CURR_PAGE"	id="CURR_PAGE"		value="<c:out value="${INIT_DATA.CURR_PAGE}"/>"/> --%>
				<input type="hidden" name="PAGE_SIZE"	id="PAGE_SIZE"		value="<c:out value="${INIT_DATA.PAGE_SIZE}"/>"/>
				<input type="hidden" name="TOTAL_CNT"	id="TOTAL_CNT"		value="<c:out value="${INIT_DATA.TOTAL_CNT}"/>"/>
				<input type="hidden" name="SCH_WORD"	id="SCH_WORD"	value="<c:out value="${INIT_DATA.SCH_WORD}"/>"/>
				<input type="hidden" name="MEET_DTL_SEQ"	id="MEET_DTL_SEQ"	value="<c:out value="${INIT_DATA.MEET_DTL_SEQ}"/>"/>
				<input type="hidden" name="MEET_SEQ"	id="MEET_SEQ"	value="<c:out value="${INIT_DATA.MEET_SEQ}"/>"/>
				<!-- 타이틀 -->
				<div class="sub-visual">
					
				</div>
				<br/>
				<!-- 타이틀 끝 -->
				<div class="tableView">
					<table summary="교육정보 조회">
						<caption>교육정보 조회</caption>
						<colgroup>
							<col width="20%">
							<col width="*">
						</colgroup>
						<tbody>
							<tr>
								<th>신청자명(닉네임)</th>
								<td>
									<input type="text" name="NICK" id="NICK" title="성명" value="<c:out value='${INIT_DATA.detail.NICK}'/>" maxlength="" class="form-control w100p" placeholder="신청자명(닉네임)" />
								</td>
							</tr>
							<tr>
								<th>성인인원</th>
								<td>
									<input type="text" name="ADULT_CNT" id="ADULT_CNT" title="성인인원" value="<c:out value='${INIT_DATA.detail.ADULT_CNT}'/>" maxlength="" class="form-control w100p" placeholder="성인인원(숫자만입력)" />
								</td>
							</tr>
							<tr>
								<th>초등학생인원</th>
								<td>
									<input type="text" name="ELE_CNT" id="ELE_CNT" title="초등학생인원" value="<c:out value='${INIT_DATA.detail.ELE_CNT}'/>" maxlength="" class="form-control w100p" placeholder="초등학생인원(숫자만입력)" />
								</td>
							</tr>
							<tr>
								<th>영유아 인원</th>
								<td>
									<input type="text" name="INF_CNT" id="INF_CNT" title="영유아 인원" value="<c:out value='${INIT_DATA.detail.INF_CNT}'/>" maxlength="" class="form-control w100p" placeholder="영유아 인원(숫자만입력)" />
								</td>
							</tr>
							<tr>
								<th>대상 인원</th>
								<td>
									<input type="text" name="TARGET_CNT" id="TARGET_CNT" title="대상 인원" value="<c:out value='${INIT_DATA.detail.TARGET_CNT}'/>" maxlength="" class="form-control w100p" placeholder="대상 인원(숫자만입력)" />
								</td>
							</tr>
							<tr>
								<th>예상입금액</th>
								<td>
									<input type="text" name="DES_PLAN_AMT" id="DES_PLAN_AMT" title="예상입금액" value="<c:out value='${INIT_DATA.detail.DES_PLAN_AMT}'/>" maxlength="" class="form-control w100p" placeholder="예상입금액(숫자만입력)" />
								</td>
							</tr>
							<tr>
								<th>입금자명</th>
								<td>
									<input type="text" name="DES_NM" id="DES_NM" title="입금자명" value="<c:out value='${INIT_DATA.detail.DES_NM}'/>" maxlength="" class="form-control w100p" placeholder="입금자명" />
								</td>
							</tr>
							<tr>
								<th>입금금액</th>
								<td>
									<input type="text" name="DES_AMT" id="DES_AMT" title="입금금액" value="<c:out value='${INIT_DATA.detail.DES_AMT}'/>" maxlength="" class="form-control w100p" placeholder="입금금액(숫자만입력)" />
								</td>
							</tr>
							<tr>
								<th>입금일자</th>
								<td>
									<input type="text" name="DES_DATE" id="DES_DATE" title="입금일자" value="<c:out value='${INIT_DATA.detail.DES_DATE}'/>" maxlength="" class="form-control w100p" placeholder="입금일자(yyyy-mm-dd)" />
								</td>
							</tr>
							<tr>
								<th>입금여부</th>
								<td>
									<input type="radio" name="DES_YN" id="DES_YN1" value="Y" title="입금"   <c:if test="${INIT_DATA.detail.DES_YN eq 'Y' }">checked="checked"</c:if> /><label for="DES_YN1"><span></span> 입금</label>&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="radio" name="DES_YN" id="DES_YN1" value="N" title="미입금"  <c:if test="${INIT_DATA.detail.DES_YN eq 'N' or INIT_DATA.detail.DES_YN eq '' }">checked="checked"</c:if> /><label for="DES_YN2"><span></span> 미입금</label>
								</td>
							</tr>
							<tr>
								<th>환불일자</th>
								<td>
									<input type="text" name="REFUND_DATE" id="REFUND_DATE" title="환불일자" value="<c:out value='${INIT_DATA.detail.REFUND_DATE}'/>" maxlength="" class="form-control w100p" placeholder="환불일자(yyyy-mm-dd)" />
								</td>
							</tr>
							<tr>
								<th>환불여부</th>
								<td>
									<input type="radio" name="REFUND_YN" id="REFUND_YN1" value="Y" title="환불"   <c:if test="${INIT_DATA.detail.REFUND_YN eq 'Y'}">checked="checked"</c:if> /><label for="REFUND_YN1"><span></span> 환불</label>&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="radio" name="REFUND_YN" id="REFUND_YN1" value="N" title="미환불"  <c:if test="${INIT_DATA.detail.REFUND_YN eq 'N' or INIT_DATA.detail.REFUND_YN eq ''}">checked="checked"</c:if> /><label for="REFUND_YN2"><span></span> 미환불</label>
								</td>
							</tr>
							<tr>
								<th>특이사항</th>
								<td>
									<input type="text" name="ETC" id="ETC" title="특이사항" value="<c:out value='${INIT_DATA.detail.ETC}'/>" maxlength="" class="form-control w100p" placeholder="특이사항" />
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="list-btn">
					<ul>
						<li><a href="javascript:fnModify();" class="btn-add" id="SBTN">수정</a></li>
						<li><a href="javascript:fnDel();" class="btn-delete" id="DBTN">삭제</a></li>
						<li><a href="javascript:fnList();" class="btn-common">목록</a></li>
					</ul>
				</div>
			</form>
			</div>
		<!-- 본문영역 끝 -->
			<br/><br/>
		<!-- 하단영역 -->
		<%@ include file="/static_root/inc/illumi_footer.jsp" %>
		<!-- 하단영역 끝 -->
	</div>
</body>
</html>
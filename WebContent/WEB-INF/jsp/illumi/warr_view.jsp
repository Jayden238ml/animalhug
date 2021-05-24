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
	
	$(document).ready(function(){
		$(window).resize(function() { 
			fnAutoResize();
		});
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
		$('#dtlFrm').attr("action", "/illumi/warrant_List.do").submit();
	}
	
	function fnModify(){
		if(confirm("수정하시겠습니까?")){
			$.ajax({
				 type		: "POST"
				,url		: "/illumi/updateWerr.do"
				,dataType	: "json"
				,data: $("#dtlFrm").serialize()
				,success : function(transport) {
					if(transport.ERROR_CD == '999'){
						alert("수정 중 에러가 발생 하였습니다.");	
						return;
					}else{
						if(confirm("저장완료 ! 목록으로 가실거에요?")){
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
				<input type="hidden" name="SCH_DANZI"	id="SCH_DANZI"	value="<c:out value="${INIT_DATA.SCH_DANZI}"/>"/>
				<input type="hidden" name="SCH_DONG"	id="SCH_DONG"	value="<c:out value="${INIT_DATA.SCH_DONG}"/>"/>
				<input type="hidden" name="SCH_LEVEL"	id="SCH_LEVEL"	value="<c:out value="${INIT_DATA.SCH_LEVEL}"/>"/>
				<input type="hidden" name="SCH_AMT_YN"	id="SCH_AMT_YN"	value="<c:out value="${INIT_DATA.SCH_AMT_YN}"/>"/>
				<input type="hidden" name="SCH_WORD"	id="SCH_WORD"	value="<c:out value="${INIT_DATA.SCH_WORD}"/>"/>
				<input type="hidden" name="WARRANT_SEQ"	id="WARRANT_SEQ"	value="<c:out value="${INIT_DATA.WARRANT_SEQ}"/>"/>
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
								<th>동 / 호수</th>
								<td><c:out value="${INIT_DATA.detail.DONG }" /> 동   <c:out value="${INIT_DATA.detail.HOSU }" /> 호</td>
							</tr>
							<tr>
								<th>성명</th>
								<td>
									<input type="text" name="USER_NM" id="USER_NM" title="성명" value="<c:out value='${INIT_DATA.detail.USER_NM}'/>" maxlength="" class="form-control w100p" placeholder="성명" />
								</td>
							</tr>
							<tr>
								<th>성명2 </th>
								<td>
									<input type="text" name="USER_NM2" id="USER_NM2" title="성명" value="<c:out value='${INIT_DATA.detail.USER_NM2}'/>" maxlength="" class="form-control w100p" placeholder="공명자" />
								</td>
							</tr>
							<tr>
								<th>연락처</th>
								<td>
									<input type="text" name="HP" id="HP" title="연락처" value="<c:out value='${INIT_DATA.detail.HP}'/>" maxlength="" class="form-control w100p" placeholder="연락처" />
								</td>
							</tr>
							<tr>
								<th>연락처2</th>
								<td>
									<input type="text" name="HP2" id="HP2" title="연락처" value="<c:out value='${INIT_DATA.detail.HP2}'/>" maxlength="" class="form-control w100p" placeholder="공동명의자 연락처" />
								</td>
							</tr>
							<tr>
								<th>닉네임</th>
								<td>
									<input type="text" name="NICK" id="NICK" title="닉네임" value="<c:out value='${INIT_DATA.detail.NICK}'/>" maxlength="" class="form-control w100p" placeholder="닉네임" />
								</td>
							</tr>
							<tr>
								<th>주소</th>
								<td>
									<input type="text" name="ADDR" id="ADDR" title="주소" value="<c:out value='${INIT_DATA.detail.ADDR}'/>" maxlength="" class="form-control w100p" placeholder="주소" />
								</td>
							</tr>
							<tr>
								<th>위임장</th>
								<td>
									<input type="radio" name="WARRANT_YN" id="WARRANT_YN1" value="Y" title="제출"   <c:if test="${INIT_DATA.detail.WARRANT_YN eq 'Y'}">checked="checked"</c:if> /><label for="WARRANT_YN1"><span></span> 제출</label>&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="radio" name="WARRANT_YN" id="WARRANT_YN2" value="N" title="미제출"  <c:if test="${INIT_DATA.detail.WARRANT_YN eq 'N'}">checked="checked"</c:if> /><label for="WARRANT_YN2"><span></span> 미제출</label>
								</td>
							</tr>
							<tr>
								<th>회비</th>
								<td>
									<input type="radio" name="AMT_YN" id="AMT_YN1" value="Y" title="납부"   <c:if test="${INIT_DATA.detail.AMT_YN eq 'Y'}">checked="checked"</c:if> /><label for="AMT_YN1"><span></span> 납부</label>&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="radio" name="AMT_YN" id="AMT_YN2" value="N" title="미납부"  <c:if test="${INIT_DATA.detail.AMT_YN eq 'N'}">checked="checked"</c:if> /><label for="AMT_YN2"><span></span> 미납부</label>
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
						<li><a href="javascript:fnModify();" class="btn-add">수정</a></li>
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
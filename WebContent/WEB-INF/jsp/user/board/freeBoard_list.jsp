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
<meta name="title" content="자유게시판" />
<meta name="description" content="커뮤니티 자유게시판" />
<meta name="keywords" content="animalhug,애니멀허그,유기견,유기견입양,커뮤니티" />
<meta name="robots" content="index, follow">
<link rel="canonical" href="http://www.animalhug.co.kr">
<meta property="og:type" content="article" />
<meta property="og:site_name" content="애니멀허그">
<meta property="og:type" content="article">
<meta property="og:url" content="http://www.animalhug.co.kr">
<meta property="og:title" content="유기동물 | 커뮤니티 | 애니멀허그">
<meta property="og:image" content="/static_root/images/common/meta_img.jpg">
<meta property="og:description" content="자유게시판 " />

<title>애니멀허그 | 커뮤니티 | 자유게시판</title>
<%@ include file="/static_root/inc/head.jsp" %>
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
		$('#ListFrm').attr("action", "/user/Board/findBoard.do").submit();	
	}
	
	function fnBoardWrite(){
		if("${INIT_DATA.SESSION_USR_ID}" == ""){
			if(confirm("로그인 후 작성 가능합니다.\n로그인 하시겠습니까?")){
				$('#ListFrm').attr("action", "/member/member_login.do").submit();
			}
		}else{
			$('#ListFrm').attr("action", "/user/Board/boardWrite.do").submit();	
		}
		
	}
	
	function fnDetail(seq){
		$('#BOARD_SEQ').val(seq);
		$('#ListFrm').attr("action", "/user/Board/boardView.do").submit();
	}
</script>
</head>
<body>
	<div id="wrap">
		<!-- 상단영역 -->
		<%@ include file="/static_root/inc/header.jsp" %>
		<!-- 상단영역 끝 -->

		<!-- 본문영역 -->
		<div id="content">
			<div id="rightCnt">
				<form name="ListFrm" id="ListFrm" method="post" action="/user/Board/freeNoteBoard.do">
				<input type="hidden" name="CURR_PAGE"	id="CURR_PAGE"		value="<c:out value="${INIT_DATA.CURR_PAGE}"/>"/>
				<input type="hidden" name="PAGE_SIZE"	id="PAGE_SIZE"		value="<c:out value="${INIT_DATA.PAGE_SIZE}"/>"/>
				<input type="hidden" name="TOTAL_CNT"	id="TOTAL_CNT"		value="<c:out value="${INIT_DATA.TOTAL_CNT}"/>"/>
				<input type="hidden" name="BOARD_SEQ"	id="BOARD_SEQ"	value=""/>
				<%@ include file="/static_root/inc/mid.jsp" %>
				<br/>
				<div class="searchList">
					<div class="searchArea">
						<select name="SCH_TYPE" id="SCH_TYPE" style="width: 70px;">
							<option value="">전체</option> 
							<option value="01" <c:if test="${INIT_DATA.SCH_TYPE eq '01'}">selected="selected"</c:if>>제목</option>
							<option value="02" <c:if test="${INIT_DATA.SCH_TYPE eq '02'}">selected="selected"</c:if> >내용</option>
							<option value="03" <c:if test="${INIT_DATA.SCH_TYPE eq '03'}">selected="selected"</c:if>>작성자</option>
						</select>&nbsp;
						<input type="text" name="SCH_WORD" id="SCH_WORD" title="검색어" value="${INIT_DATA.SCH_WORD}" maxlength="30" class="form-control" placeholder="검색어를 입력하세요." />
						<a href="#" onclick="fnSearch();" class="schBtn" style="height:40px;">검색</a>
					</div>
				</div>
				</form>
				<p class="list-total">
					전체 <strong><c:out value='${INIT_DATA.TOTAL_CNT}'/></strong>건 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
				</p>
				<div class="tableList tableTR">
					<table summary="자유게시판 목록">
						<caption>자유게시판 목록</caption>
						<colgroup>
							<col width="*" />
							<col width="20%" />
							<col width="10%" />
<%-- 							<col width="15%" /> --%>
						</colgroup>
						<thead>
							<tr>
								<th>제목</th>
								<th>작성자</th>
								<th>조회수</th>
<!-- 								<th>등록일</th> -->
							</tr>
						</thead>
						<tbody> 
							<c:if test="${not empty INIT_DATA.boardList }">
								<c:forEach items="${INIT_DATA.boardList }" var="item" varStatus="rowStatus">
									<tr>
										<td style="text-align:left;">
											<a href="javascript:fnDetail('<c:out value="${item.BOARD_SEQ}" />');"><c:out value="${item.TITLE }"/>&nbsp;&nbsp;</a>
											<c:if test="${item.ATTACH_YN eq 'Y'}">
												<img alt="" src="/static_root/images/fileIcn/img_icon.png">
											</c:if>
											<c:if test="${item.R_CNT ne 0 and item.R_CNT ne ''}">
												<span style="color:#843817;">[<c:out value="${item.R_CNT}" />]</span>
											</c:if>
										</td>
										<td><c:out value="${item.REG_NICK }"/></td>
										<td><c:out value="${item.VIEW_CNT }"/></td>
<%-- 										<td><c:out value="${item.REGDATE }"/></td> --%>
									</tr>
								</c:forEach>
							</c:if>
							<c:if test="${empty INIT_DATA.boardList }">
								<tr>
									<td colspan="3">조회된 자료가 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>
				<div class="list-btn">
					<ul>
						<li><a href="javascript:fnBoardWrite();" class="btn-add">등록</a></li> 
					</ul>
				</div>
			</div>
			<div class="list-paging pt30 pb100">
				<dd id="paging_bar">
				</dd>
			</div>
		
		</div>
		<!-- 본문영역 끝 -->
		<!-- 하단영역 -->
		<%@ include file="/static_root/inc/footer.jsp" %>
		<!-- 하단영역 끝 -->
	</div>
</body>
</html>
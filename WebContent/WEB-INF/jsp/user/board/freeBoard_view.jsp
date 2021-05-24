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
	<meta name="title" content="자유게시판" />
	<meta name="description" content="커뮤니티 자유게시판" />
	<meta name="title" content="보호중동물 조회" />
	<meta name="description" content="유기동물 보호중동물 조회" />
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
		$('#boardFrm').attr("action", "/user/Board/freeNoteBoard.do").submit();
	}
	
	function fnAddRip(){
		if("${INIT_DATA.SESSION_USR_ID}" == ""){
			if(confirm("로그인 후 작성 가능합니다.\n로그인 하시겠습니까?")){
				$('#boardFrm').attr("action", "/member/member_login.do").submit();
			}else{
				return;
			}
		}else{
			if($('#RIP_COMMENT').val() == ""){
				alert("내용을 입력해 주세요.");
				$('#RIP_COMMENT').focus();
				return;
			}
			$.ajax({
				 type		: "POST"
				,url		: "/user/Board/rippleWrite.do"
				,dataType	: "json"
				,data: $("#boardFrm").serialize()
				,success : function(transport) {
					if(transport.ERROR_CD == '999'){
						alert("처리중 오류가 발생 하였습니다.");	
						return;
					}else{
						$('#boardFrm').attr("action", "/user/Board/boardView.do").submit();	
					}
				}
			});
		}
	}
	
	function fnmodify(){
		$('#boardFrm').attr("action", "/user/Board/boardWrite.do").submit();	
	}
	
	// 게시판 글 삭제
	function fnDelete(){
		if(confirm("삭제하시겠습니까?")){
			$.ajax({
				 type		: "POST"
				,url		: "/user/Board/boardDelete.do"
				,dataType	: "json"
				,data: $("#boardFrm").serialize()
				,success : function(transport) {
					if(transport.ERROR_CD == '999'){
						alert("처리중 오류가 발생 하였습니다.");	
						return;
					}else{
						fnList();
					}
				}
			});
		}
	}
	
	// 댓글 삭제
	function fnRiDelete(r_seq, rr_seq,  sort){
		
		$('#R_SEQ').val(r_seq);
		$('#RR_SEQ').val(rr_seq);
		$('#SORT').val(sort);
		
		if(confirm("삭제하시겠습니까?")){
			$.ajax({
				 type		: "POST"
				,url		: "/user/Board/boardRipDelete.do"
				,dataType	: "json"
				,data: $("#boardFrm").serialize()
				,success : function(transport) {
					if(transport.ERROR_CD == '999'){
						alert("처리중 오류가 발생 하였습니다.");	
						return;
					}else{
						$('#boardFrm').attr("action", "/user/Board/boardView.do").submit();	
					}
				}
			});
		}
	}
	
	function fnViewBox(r_seq, rr_seq, idx, sort){
		$('#repW'+idx).show();
		
		if($('#B_IDX').val() != ""){
			$('#repW'+$('#B_IDX').val()).hide();
			$('#RIP_COMMENT'+$('#B_IDX').val()).val("");
		}
		$('#B_IDX').val(idx);
		$('#R_SEQ').val(r_seq);
		$('#RR_SEQ').val(rr_seq);
		$('#SORT').val(Number(sort) + 1);
	}
	
	function fnAddRip_2(idx){
		if("${INIT_DATA.SESSION_USR_ID}" == ""){
			if(confirm("로그인 후 작성 가능합니다.\n로그인 하시겠습니까?")){
				$('#boardFrm').attr("action", "/member/member_login.do").submit();
			}else{
				return;
			}
		}else{
			if($('#RIP_COMMENT'+idx).val() == ""){
				alert("내용을 입력해 주세요.");
				$('#RIP_COMMENT'+idx).focus();
				return;
			}
			$('#RIP_COMMENT_2').val($('#RIP_COMMENT'+idx).val());
			$.ajax({
				 type		: "POST"
				,url		: "/user/Board/rippleWrite.do"
				,dataType	: "json"
				,data: $("#boardFrm").serialize()
				,success : function(transport) {
					if(transport.ERROR_CD == '999'){
						alert("처리중 오류가 발생 하였습니다.");	
						return;
					}else{
						$('#boardFrm').attr("action", "/user/Board/boardView.do").submit();	
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
		<%@ include file="/static_root/inc/header.jsp" %>
		<!-- 상단영역 끝 -->

		<!-- 본문영역 -->
		<div id="content">
						
			<form name="boardFrm" id="boardFrm" method="post" action="#" class="form-inline">
				<input type="hidden" name="BOARD_SEQ" id="BOARD_SEQ" value="<c:out value='${INIT_DATA.detail.BOARD_SEQ}' />" />
				<input type="hidden" name="B_IDX" id="B_IDX" value="" />
				<input type="hidden" name="R_SEQ" id="R_SEQ" value="" />
				<input type="hidden" name="RR_SEQ" id="RR_SEQ" value="" />
				<input type="hidden" name="SORT" id="SORT" value="" />
				<input type="hidden" name="RIP_COMMENT_2" id="RIP_COMMENT_2" value="" />
				<!-- 타이틀 -->
				<%@ include file="/static_root/inc/mid.jsp" %>
				<br/>
				<!-- 타이틀 끝 -->
				<div class="view-area">
					<div class="va-title">
						<h2>${INIT_DATA.detail.TITLE }</h2>
						<h3>${INIT_DATA.detail.REGDATE } &nbsp; | &nbsp; ${INIT_DATA.detail.REG_NICK }</h3>				
					</div>
					<div class="va-content" style="word-break: break-all;">
						${fn:replace(INIT_DATA.CONTENT, newLineChar, '<br />')}
					</div>
					<div class="commentlistbox">
						<c:if test="${not empty INIT_DATA.RipList}">
							<c:forEach var="item" items="${ INIT_DATA.RipList }" varStatus="status">
								<ul class="baseiclist" >
									<c:if test="${item.REP_YN eq 'Y'}">
										<li class="re">
									</c:if>
									<c:if test="${item.REP_YN ne 'Y'}">
										<li>
									</c:if>
										<dl>
											<dt> 
												<span class="name"><c:out value="${item.REG_NICK}" /></span>
												<span class="date"><c:out value="${item.REGDATE}" /></span>
												<span class="link" onclick="fnViewBox('${item.RIP_SEQ}', '${item.RIP_RIP_SEQ}','${status.index}', '${item.SORT}');" style="cursor:pointer;">답글</span>
												<c:if test="${item.REGID eq INIT_DATA.SESSION_USR_ID}">
													<span class="link" onclick="fnRiDelete('${item.RIP_SEQ}', '${item.RIP_RIP_SEQ}', '${item.SORT}');" style="cursor:pointer;">|&nbsp;삭제</span>
												</c:if>
											</dt>
											<dd>
												${fn:replace(item.RIP_COMMENT, newLineChar, '<br />')}
											</dd>
											<span style="display:none; width:100%;" id="repW${status.index}" >
												<table width="100%">
													<colgroup>
														<col width="90%">
														<col width="10%">
													</colgroup>
													<tr>
														<td><textarea name="RIP_COMMENT${status.index}" id="RIP_COMMENT${status.index}" rows="" cols="" title="내용" class="form-control" maxlength="2000" style="width:98%; height:100px;" placeholder="댓글작성"></textarea> </td>
														<td><a href="javascript:fnAddRip_2('${status.index}');" class="btn btn-secondary btn-lg w70"> 등록</a></td>
													</tr>
												</table>
											</span>
										</dl>
									</li>
								</ul>
							</c:forEach>
						</c:if>
					</div>
					<div class="commentlistbox">
						<ul class="baseiclist">
							<li>
								<table width="100%">
									<colgroup>
										<col width="90%">
										<col width="10%">
									</colgroup>
									<tr>
										<td><textarea name="RIP_COMMENT" id="RIP_COMMENT" rows="" cols="" title="내용" class="form-control" maxlength="2000" style="width:98%; height:100px;" placeholder="댓글작성"></textarea></td>
										<td><a href="javascript:fnAddRip();" class="btn btn-secondary btn-lg w70"> 등록</a></td>
									</tr>
								</table>
							</li>
						</ul>
					</div>
					<div class="va-btn">
						<a href="javascript:fnList();">목록보기 &nbsp;<i class="fa fa-angle-right" aria-hidden="true"></i></a>
					</div>
					<br/>
					<c:if test="${INIT_DATA.SESSION_USR_ID eq INIT_DATA.detail.REGID}">
						<div style="margin-top:5px; text-align:center;">
							<p>
								<a href="javascript:fnmodify();" class="btn btn-danger btn-lg w70">수정</a> &nbsp; &nbsp;
								<a href="javascript:fnDelete();" class="btn btn-secondary btn-lg w70">삭제</a>
							</p>
						</div>
					</c:if>
				</div>
			</form>
		<!-- 본문영역 끝 -->

		<!-- 하단영역 -->
		<%@ include file="/static_root/inc/footer.jsp" %>
		<!-- 하단영역 끝 -->
	</div>
</body>
</html>
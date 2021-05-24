<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/static_root/inc/admin_head.jsp" %>
<jsp:useBean id="now" class="java.util.Date"/>
<fmt:formatDate value="${now}" pattern="yyyy.MM.dd" var="todaydate"/>
		
<script language="javascript">

	function fnAddFindAnimal(type){
		$('#TYPE').val(type);
		$.ajax({
			 type		: "POST"
			,url		: "/Sa/animal/findAnimal.do"
			,dataType	: "json"
			,data: $("#frm").serialize()
			,success : function(transport) {
				alert(transport.CNT + "건 저장됨 !");
			}
		});
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
				<dt></dt>
				<dd>
					
				</dd>
			</dl>
			<!-- 타이틀/네비 -->
		
			<form name="frm"  id="frm" method="post" action="">
			<input type="hidden" name="TYPE" id="TYPE" value=""/>
			<!-- 본문영역 ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
			<div>
				<select name="UP_KIND_CD" id="UP_KIND_CD">
					<option value="417000">개</option>
					<option value="422400">고양이</option>
					<option value="429900">기타</option>
				</select>
				<a href="javascript:fnAddFindAnimal('1');" class="btn btn-danger" data-toggle="modal"><i class="fa fa-list-alt" aria-hidden="true"></i>유기동물 저장</a>
				<a href="javascript:fnAddFindAnimal('2');" class="btn btn-warning" data-toggle="modal"><i class="fa fa-list-alt" aria-hidden="true"></i>입양동물 저장</a>
			</div>
			</form>
		</div>
		
		<!-- 하단영역 -->
		<%@ include file="/static_root/inc/admin_footer.jsp" %>
		<!-- 하단영역 끝 -->
	</div>
</body>
</html>
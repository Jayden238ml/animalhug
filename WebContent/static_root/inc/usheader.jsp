<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt"        prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"        prefix="fmt" %>
<!-- 상단영역 -->
<div id="header">
	<dl>
		<dt><a href="/main.do"><img src="/static_root/images/common/uslogo2.png" alt="animalHug 로고" title="animalHug 로고" /></a></dt>
		<dd>
			<ul id="menuArea">
<!-- 				<li><a href="/user/animal/findAnimal.do">유기동물</a></li> -->
				<li><a href="javascript:fn_moveMenu('1');">notice board</a></li>
			</ul>
		</dd>
		<dt style="padding-top:2%;">
			<c:if test="${empty INIT_DATA.SESSION_USR_ID}">
				<div>
<!-- 					<a href="/member/member_login.do">로그인</a> -->
				</div>
			</c:if>
			<c:if test="${not empty INIT_DATA.SESSION_USR_ID }">
				<h1><span>${INIT_DATA.SESSION_USR_NICK}</span> 님 반갑습니다.</h1>
				<div>
					<a href="/member/member_View.do">나의정보</a>
					<a href="/logOut.do">로그아웃</a>
				</div>
			</c:if>
		</dt>
	</dl>

	<div id="subMenuArea">
		<ul>
<!-- 			<li> -->
<!-- 				<h1>유기동물</h1> -->
<!-- 				<ul> -->
<!-- 					<li><a href="/user/animal/findAnimal.do">유기동물조회</a></li> -->
<!-- 					<li><a href="/user/animal/adoptAnimal.do">입양가능동물조회</a></li> -->
<!-- 					<li><a href="/user/animal/adoptContent.do">입양안내</a></li> -->
<!-- 				</ul> -->
<!-- 			</li> -->
			<li>
				<h1><a href="javascript:fn_moveMenu('1');">notice board</a></h1>
				<ul>
					<li><a href="javascript:fn_moveMenu('1');">notice board</a></li>
<!-- 					<li><a href="javascript:fn_moveMenu('/user/Board/freeNoteBoard.do');">자유게시판</a></li> -->
<!-- 					<li><a href="javascript:fn_moveMenu('/user/Board/story.do');">반려동물 이야기</a></li> -->
				</ul>
			</li>
		</ul>
	</div>
</div>
<!-- 상단영역 끝 -->


<!-- 상단영역 - 모바일 -->
<div id="header-mobile">
	<dl class="hm-menu">
		<dt><i class="fa fa-bars" aria-hidden="true" id="mobileLnbOpen"></i></dt>
		<dd><a href="/main.do"><img src="/static_root/images/common/uslogo2.png" height="30" alt="animalHug 로고" title="animalHug 로고" /></a></dd>
		<c:if test="${not empty INIT_DATA.SESSION_USR_ID}">
			<dt><a href='/member/member_View.do'><i class="fa fa-pencil-square-o" aria-hidden="true" id="mobileSearchOpen"></i></a></dt>
		</c:if>
	</dl>
	<div class="hm-total">
		<dl>
			<dt>MENU</dt>
			<dd><i id="mobileLnbClose" class="fa fa-times" aria-hidden="true"></i></dd>
		</dl>
		<p>
			<c:if test="${empty INIT_DATA.SESSION_USR_ID}">
<!-- 				<a href="/member/member_login.do" class="btn btn-secondary btn-lg w50p">로그인</a> -->
			</c:if>
			<c:if test="${INIT_DATA.SESSION_USR_ID ne ''}">
				<a href="/member/member_View.do">
					나의정보
					<img alt="나의정보" src="/static_root/images/btnIcn/icn_writer.png">
				</a>
				<a href="/logOut.do">로그아웃</a>
			</c:if>
		</p>
		<div id="cssmenu">
			<ul>
<!-- 				<li class='has-sub'><a href='/user/animal/findAnimal.do'><i class="fa fa-newspaper-o" aria-hidden="true"></i><span>유기동물</span></a> -->
<!-- 					<ul> -->
<!-- 						<li><a href='/user/animal/findAnimal.do'><i></i> <span>유기동물조회</span></a></li> -->
<!-- 						<li><a href='/user/animal/adoptAnimal.do'><i></i> <span>입양가능동물조회</span></a></li> -->
<!-- 						<li><a href='/user/animal/adoptContent.do'><i></i> <span>입양안내</span></a></li> -->
<!-- 					</ul> -->
<!-- 				</li> -->
				<li class='has-sub'><a href='#'><i class="fa fa-book" aria-hidden="true"></i><span>notice board</span></a>
					<ul>
						<li><a href="javascript:fn_moveMenu('1');"><i></i> <span>notice board</span></a></li>
<!-- 						<li><a href="javascript:fn_moveMenu('/user/Board/freeNoteBoard.do');"><i></i> <span>자유게시판</span></a></li> -->
<!-- 						<li><a href="javascript:fn_moveMenu('/user/Board/story.do');"><i></i> <span>반려동물 이야기</span></a></li> -->
					</ul>
				</li>
			</ul>
		</div>
	</div>
</div>
<!-- 상단영역 - 모바일 끝 -->


<<script type="text/javascript">
	function fn_moveMenu(url){
		if(url == "1"){
			alert("Development in progress...")
			return;
		}
// 		$('#H_URL').val(url);
// 		$('#hfrm').attr("action", "/common/goMenu.do").submit();
	}
</script>

<form name="hfrm"  id="hfrm" method="post" action="#">
<input type="hidden" name="H_URL" id="H_URL" value="">
</form>

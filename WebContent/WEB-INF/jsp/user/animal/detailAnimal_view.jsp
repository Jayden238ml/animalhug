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
	<meta name="title" content="유기동물" />
	<meta name="description" content="유기동물" />
	<meta name="title" content="보호중동물 조회" />
	<meta name="description" content="유기동물 보호중동물 조회" />
	<meta name="keywords" content="animalhug,애니멀허그,유기견,유기견입양,커뮤니티" />
	<meta name="robots" content="index, follow">
	<link rel="canonical" href="http://www.animalhug.co.kr">
	<meta property="og:type" content="article" />
	<meta property="og:site_name" content="애니멀허그">
	<meta property="og:type" content="article">
	<meta property="og:url" content="http://www.animalhug.co.kr">
	<meta property="og:title" content="유기동물 | 애니멀허그">
	<!--<meta property="og:image" content="/static_root/images/common/meta_img.jpg">-->
	<meta property="og:image" content="${INIT_DATA.detail.FILENAME }">
	<meta property="og:description" content="${INIT_DATA.detail.NOTICENO } " />
	
	<title>애니멀허그 | 유기동물 </title>
	<%@ include file="/static_root/inc/head.jsp" %>
	<script type="text/JavaScript" src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>	
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
		$('.tableView img').each(function() {
			if($('.tableView').width() < this.naturalWidth){
				$(this).css("width", "100%");
				$(this).css("height", "auto");
			}else{
				$(this).css("width", this.naturalWidth);
				$(this).css("height", "auto");
			}
		});
	}
	
	
	function fnList(){
		var url2 = $('#RTN_URL').val();
		if(url2 == "" || url2 == null){
			$('#CURR_PAGE').val("1");
			$('#PAGE_SIZE').val("10");
			url2 = "/user/animal/adoptAnimal.do";
		}else if($('#CURR_PAGE').val() == ""){
			$('#CURR_PAGE').val("1");
			$('#PAGE_SIZE').val("10");
		}
		$('#dtlFrm').attr("action", url2).submit();
	}
	
	function fnViewDataInsert(type){
		$.ajax({
			 type		: "POST"
			,url		: "/user/Animal/CopyData.do"
			,dataType	: "json"
			,data: $("#dtlFrm").serialize()
			,success : function(transport) {
				if(transport.ERROR_CD == '999'){
					alert("주소 복사에 실패 하였습니다.");	
					return;
				}else{
					fnCopyUrl(type);
				}
			}
		});
	}
	
	function fnCopyUrl(type){
		var str = "http://www.animalhug.co.kr/user/Animal/detailAnimal.do?DESERTIONNO=" + $('#DESERTIONNO').val();
		var url = "";
	    if(type == "F"){
	    	url = "https://www.facebook.com/sharer/sharer.php?u="+ str;
	    }else if(type == "T"){
	    	url = "https://twitter.com/intent/tweet?via=애니멀허그&text=&url=" + url;
	    }else if(type == "K"){
			shareKakaotalk();
			return;
		}
	    location.href = url;

	}
	

	function shareKakaotalk() {
		var kind_nm = $('#KIND_NM').val();
		var age = $('#AGE').val();
		var weight = $('#WEIGHT').val();
		var tit = kind_nm + " | " + age + " | " + weight
		var img = "${INIT_DATA.detail.POPFILE }";
        Kakao.init("709c40315079132e50e64ff31f511a13");      
        Kakao.Link.sendDefault({
              objectType:"feed"
            , content : {
                  title:"유기견,유기묘 입양은 애니멀허그"   // 콘텐츠의 타이틀
                , description:tit  // 콘텐츠 상세설명
                , imageUrl: img  // 썸네일 이미지
                , link : {
                      mobileWebUrl:"http://www.animalhug.co.kr/user/Animal/detailAnimal.do?DESERTIONNO=" + $('#DESERTIONNO').val()   // 모바일 카카오톡에서 사용하는 웹 링크 URL
                    , webUrl:"http://www.animalhug.co.kr/user/Animal/detailAnimal.do?DESERTIONNO=" + $('#DESERTIONNO').val() // PC버전 카카오톡에서 사용하는 웹 링크 URL
                }
            }
            , social : {
                  likeCount:0       // LIKE 개수
                , commentCount:0    // 댓글 개수
                , sharedCount:0     // 공유 회수
            }
            , buttons : [
                {
                      title:"자세히 보기"    // 버튼 제목
                    , link : {
                        mobileWebUrl:"http://www.animalhug.co.kr/user/Animal/detailAnimal.do?DESERTIONNO=" + $('#DESERTIONNO').val()   // 모바일 카카오톡에서 사용하는 웹 링크 URL
                      , webUrl:"http://www.animalhug.co.kr/user/Animal/detailAnimal.do?DESERTIONNO=" + $('#DESERTIONNO').val() // PC버전 카카오톡에서 사용하는 웹 링크 URL
                    }
                }
            ]
        });
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
				<form name="dtlFrm" id="dtlFrm" method="post" action="#" class="form-inline">
				<input type="hidden" name="CURR_PAGE"	id="CURR_PAGE"		value="<c:out value="${INIT_DATA.CURR_PAGE}"/>"/>
				<input type="hidden" name="PAGE_SIZE"	id="PAGE_SIZE"		value="<c:out value="${INIT_DATA.PAGE_SIZE}"/>"/>
				<input type="hidden" name="TOTAL_CNT"	id="TOTAL_CNT"		value="<c:out value="${INIT_DATA.TOTAL_CNT}"/>"/>
				<input type="hidden" name="DESERTIONNO"	id="DESERTIONNO"	value="<c:out value="${INIT_DATA.DESERTIONNO}"/>"/>
				<input type="hidden" name="RTN_URL"		id="RTN_URL"	value="<c:out value="${INIT_DATA.RTN_URL}"/>"/>
				<input type="hidden" name="PAGE_TYPE"	id="PAGE_TYPE"	value="<c:out value="${INIT_DATA.PAGE_TYPE}"/>"/>
				<input type="hidden" name="UPR_CD"		id="UPR_CD"	value="<c:out value="${INIT_DATA.UPR_CD}"/>"/>
				<input type="hidden" name="ORG_CD"		id="ORG_CD"	value="<c:out value="${INIT_DATA.ORG_CD}"/>"/>
				<input type="hidden" name="UP_KIND_CD"	id="UP_KIND_CD"	value="<c:out value="${INIT_DATA.UP_KIND_CD}"/>"/>
				<input type="hidden" name="KIND_CD"		id="KIND_CD"	value="<c:out value="${INIT_DATA.KIND_CD}"/>"/>
				<!-- 타이틀 -->
				<div class="sub-visual">
					
				</div>
				<br/>
				<div class="tableView">
					<table summary="교육정보 조회">
						<caption>교육정보 조회</caption>
						<colgroup>
							<col width="35%">
							<col width="*">
						</colgroup>
						<tbody>
							<tr>
								<th colspan="2" style="text-align:center;">
									공고번호 : <c:out value='${INIT_DATA.detail.NOTICENO}'/>
								</th>
							</tr>
							<tr>
								<td colspan="2">
									<img alt="" src="${INIT_DATA.detail.POPFILE }" />
								</td>
							</tr>
							<tr>
								<th>접수일</th>
								<td>
									<c:out value='${INIT_DATA.detail.HAPPENDT}'/>
								</td>
							</tr>
							<tr>
								<th>발견장소</th>
								<td>${INIT_DATA.detail.HAPPENPLACE }</td>
							</tr>
							<tr>
								<th>품종</th>
								<td>${INIT_DATA.detail.KINDCD }</td>
								<input type="hidden" name="KIND_NM"	id="KIND_NM" value="<c:out value="${INIT_DATA.detail.KINDCD}"/>"/>
								<input type="hidden" name="AGE" id="AGE" value="<c:out value="${INIT_DATA.detail.AGE }"/>"/>
								<input type="hidden" name="WEIGHT" id="WEIGHT" value="<c:out value="${INIT_DATA.detail.WEIGHT }"/>"/>
								<input type="hidden" name="IMG_FILE" id="IMG_FILE" value="<c:out value="${INIT_DATA.detail.POPFILE }"/>"/>
							</tr>
							<tr>
								<th>나이 / 체중</th>
								<td>${INIT_DATA.detail.AGE } / ${INIT_DATA.detail.WEIGHT }</td>
							</tr>
							<tr>
								<th>성별</th>
								<td>${INIT_DATA.detail.SEXCD }</td>
							</tr>
							<tr>
								<th>중성화여부</th>
								<td>${INIT_DATA.detail.NEUTERYN }</td>
							</tr>
							<tr>
								<th>특징</th>
								<td>${INIT_DATA.detail.SPECIALMARK }</td>
							</tr>
							<tr>
								<th>보호소이름</th>
								<td>${INIT_DATA.detail.CARENM }</td>
							</tr>
							<tr>
								<th>보호소연락처</th>
								<td>${INIT_DATA.detail.CARETEL }</td>
							</tr>
							<tr>
								<th>보호장소</th>
								<td>${INIT_DATA.detail.CAREADDR }</td>
							</tr>
							<tr>
								<th>관할기관</th>
								<td>${INIT_DATA.detail.ORGNM }</td>
							</tr>
							<tr>
								<th>담당자</th>
								<td>${INIT_DATA.detail.CHARGENM }</td>
							</tr>
							<tr>
								<th>담당자 연락처</th>
								<td>${INIT_DATA.detail.OFFICETEL }</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="list-btn">
					<ul>
						<li><a href="javascript:fnList();" class="btn-add">목록보기</a></li>
					</ul>
				</div>
			</div>			
				<!-- 타이틀 끝 -->
<!-- 				<div class="view-area"> -->
<!-- 					<div class="va-title"> -->
<%-- 						<h2>공고번호 : ${INIT_DATA.detail.NOTICENO }</h2> --%>
<!-- 					</div> -->
<!-- 					<div class="va-content" style="word-break: break-all;"> -->
<%-- 						<img alt="" src="${INIT_DATA.detail.POPFILE }" /> --%>
<!-- 						<br/><br/> -->
<!-- 						<div> -->
<!-- 							<ul class="baseiclist"> -->
<!-- 								<li> -->
<!-- 									<table width="100%" style="border-top:#838383 1px solid; border-left:#e4e4e4 1px solid;"> -->
<%-- 										<colgroup> --%>
<%-- 											<col width="25%"> --%>
<%-- 											<col width="*"> --%>
<%-- 										</colgroup> --%>
<!-- 										<tr> -->
<!-- 											<th class="animalTh">접수일</th> -->
<%-- 											<td class="animalTd">${INIT_DATA.detail.HAPPENDT }</td> --%>
<!-- 										</tr> -->
<!-- 										<tr> -->
<!-- 											<th class="animalTh">발견장소</th> -->
<%-- 											<td class="animalTd">${INIT_DATA.detail.HAPPENPLACE }</td> --%>
<!-- 										</tr> -->
<!-- 										<tr> -->
<!-- 											<th class="animalTh">품종</th> -->
<%-- 											<td class="animalTd">${INIT_DATA.detail.KINDCD }</td> --%>
<%-- 											<input type="hidden" name="KIND_NM"	id="KIND_NM" value="<c:out value="${INIT_DATA.detail.KINDCD}"/>"/> --%>
<%-- 											<input type="hidden" name="AGE" id="AGE" value="<c:out value="${INIT_DATA.detail.AGE }"/>"/> --%>
<%-- 											<input type="hidden" name="WEIGHT" id="WEIGHT" value="<c:out value="${INIT_DATA.detail.WEIGHT }"/>"/> --%>
<%-- 											<input type="hidden" name="IMG_FILE" id="IMG_FILE" value="<c:out value="${INIT_DATA.detail.POPFILE }"/>"/> --%>
<!-- 										</tr> -->
<!-- 										<tr> -->
<!-- 											<th class="animalTh">나이 / 체중</th> -->
<%-- 											<td class="animalTd">${INIT_DATA.detail.AGE } / ${INIT_DATA.detail.WEIGHT }</td> --%>
<!-- 										</tr> -->
<!-- 										<tr> -->
<!-- 											<th class="animalTh">성별</th> -->
<%-- 											<td class="animalTd">${INIT_DATA.detail.SEXCD }</td> --%>
<!-- 										</tr> -->
<!-- 										<tr> -->
<!-- 											<th class="animalTh">중성화여부</th> -->
<%-- 											<td class="animalTd">${INIT_DATA.detail.NEUTERYN }</td> --%>
<!-- 										</tr> -->
<!-- 										<tr> -->
<!-- 											<th class="animalTh">특징</th> -->
<%-- 											<td class="animalTd">${INIT_DATA.detail.SPECIALMARK }</td> --%>
<!-- 										</tr> -->
<!-- 										<tr> -->
<!-- 											<th class="animalTh">보호소이름</th> -->
<%-- 											<td class="animalTd">${INIT_DATA.detail.CARENM }</td> --%>
<!-- 										</tr> -->
<!-- 										<tr> -->
<!-- 											<th class="animalTh">보호소연락처</th> -->
<%-- 											<td class="animalTd">${INIT_DATA.detail.CARETEL }</td> --%>
<!-- 										</tr> -->
<!-- 										<tr> -->
<!-- 											<th class="animalTh">보호장소</th> -->
<%-- 											<td class="animalTd">${INIT_DATA.detail.CAREADDR }</td> --%>
<!-- 										</tr> -->
<!-- 										<tr> -->
<!-- 											<th class="animalTh">관할기관</th> -->
<%-- 											<td class="animalTd">${INIT_DATA.detail.ORGNM }</td> --%>
<!-- 										</tr> -->
<!-- 										<tr> -->
<!-- 											<th class="animalTh">담당자</th> -->
<%-- 											<td class="animalTd">${INIT_DATA.detail.CHARGENM }</td> --%>
<!-- 										</tr> -->
<!-- 										<tr> -->
<!-- 											<th class="animalTh">담당자 연락처</th> -->
<%-- 											<td class="animalTd">${INIT_DATA.detail.OFFICETEL }</td> --%>
<!-- 										</tr> -->
<!-- 									</table> -->
<!-- 								</li> -->
<!-- 							</ul> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					<br/> -->
<!-- 					<a href="javascript:fnViewDataInsert('F');"><img src="/static_root/images/btnIcn/facebook.png" alt="페이스북" title="페이스북" style="width:53px;height:auto;" /></a> -->
<!-- 					<a href="javascript:fnViewDataInsert('T');"><img src="/static_root/images/btnIcn/twitter.jpg" alt="트위터" title="트위터" style="width:53px;height:auto;"  /></a> -->
<!-- 					<a href="javascript:fnViewDataInsert('K');"><img src="/static_root/images/btnIcn/kakao.png" alt="카카오" title="카카오" style="width:53px;height:auto;"  /></a> -->
<!-- 					<br/><br/> -->
<!-- 					<div style="margin-top:5px; text-align:center;"> -->
<!-- 						<p> -->
<!-- 							<a href="javascript:fnList();" class="btn btn-secondary btn-lg w150">목록보기</a> &nbsp; &nbsp; -->
<!-- 						</p> -->
<!-- 					</div> -->
<!-- 				</div> -->
			</form>
		<!-- 본문영역 끝 -->

		<!-- 하단영역 -->
		<%@ include file="/static_root/inc/footer.jsp" %>
		<!-- 하단영역 끝 -->
	</div>
</body>
</html>
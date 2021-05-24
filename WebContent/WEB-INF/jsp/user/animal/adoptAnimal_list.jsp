<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<%@ taglib uri="http://java.sun.com/jstl/core_rt"        prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"        prefix="fmt" %>
<jsp:useBean id="now" class="java.util.Date"/>
<fmt:formatDate value="${now}" pattern="yyyy.MM.dd" var="todaydate"/>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1" />
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
<meta property="og:description" content="보호중동물 조회 " />

<title>애니멀허그 | 유기동물 | 보호중동물 조회</title>
<%@ include file="/static_root/inc/head.jsp" %>
<script language="javascript">
var PAGE_SIZE = '10';
$(document).ready(function(){
	var TOTAL_PAGE = Math.ceil('${INIT_DATA.TOTAL_CNT}'/'${INIT_DATA.PAGE_SIZE}');
	$("#SCH_TYPE").val('${INIT_DATA.SCH_TYPE}');
	$("#SCH_WORD").val('${INIT_DATA.SCH_WORD}');
	fncMakePageBody('${INIT_DATA.TOTAL_CNT}','${INIT_DATA.CURR_PAGE}');
	
	$("#frm").find("input").each(function(e){
        $(this).bind("keyup",function(){
                if(event.keyCode == 13){
                	fnSearch();
                }
        });
    });
	
	if("${INIT_DATA.UPR_CD}" != ""){
		fnGetOrgData("${INIT_DATA.UPR_CD}");
	}
	if("${INIT_DATA.UP_KIND_CD}" != ""){
		fnGetKindData("${INIT_DATA.UP_KIND_CD}");
	}
	
});

//페이징
var page_List = function(pageNo) {
	$("#SCH_WORD").val('${INIT_DATA.SCH_WORD}');
    $("#CURR_PAGE").val(pageNo);        
    $('#frm').submit();
};

//조회
function fnSearch(){
	$("#CURR_PAGE").val('1');
	$('#frm').submit();
}


function fnGetOrgData(val){
	$.ajax({
		 type		: "POST"
		,url		: "/user/animal/getOrgCdData.do"
		,dataType	: "json"
		,data		: {
			"UPR_CD" : val
		}
		,success : function(transport) {
			var orgList = transport.resultList;
			setData(orgList);
		}
	});
}

function setData(orgList){
	if(orgList.length > 0){
		$("select#ORG_CD option").remove();
		$("#ORG_CD").append("<option value=''>시군구 조회</option>");
		$.each(orgList,function(key,json){
			$("#ORG_CD").append("<option value='"+ json.orgCd +"'>"+ json.orgdownNm +"</option>");
		});
		
		if("${INIT_DATA.ORG_CD}" != ""){
			$("#ORG_CD").val("${INIT_DATA.ORG_CD}");
		}
	}
}

function fnGetKindData(val){
	$.ajax({
		 type		: "POST"
		,url		: "/user/animal/getkindCdData.do"
		,dataType	: "json"
		,data		: {
			"UP_KIND_CD" : val
		}
		,success : function(transport) {
			var orgList = transport.resultList;
			setKindData(orgList);
		}
	});
}

function setKindData(kindList){
	if(kindList.length > 0){
		$("select#KIND_CD option").remove();
		$("#KIND_CD").append("<option value=''>품종 조회</option>");
		$.each(kindList,function(key,json){
			$("#KIND_CD").append("<option value='"+ json.kindCd +"'>"+ json.KNm +"</option>");
		});
		
		if("${INIT_DATA.KIND_CD}" != ""){
			$("#KIND_CD").val("${INIT_DATA.KIND_CD}");
		}
	}
}

function fnDetail(d_no){
	$('#DESERTIONNO').val(d_no);
	$('#frm').attr("action", "/user/Animal/detailAnimal.do").submit();
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
				
				
				
				<!-- 비주얼 -->
				<%@ include file="/static_root/inc/mid.jsp" %>
				<br/>
				<!-- 비주얼 끝 -->
				
				<form name="frm"  id="frm" method="post" action="/user/animal/adoptAnimal.do">
				<input type="hidden" name="CURR_PAGE"	id="CURR_PAGE"		value="<c:out value="${INIT_DATA.CURR_PAGE}"/>"/>
				<input type="hidden" name="PAGE_SIZE"	id="PAGE_SIZE"		value="<c:out value="${INIT_DATA.PAGE_SIZE}"/>"/>
				<input type="hidden" name="TOTAL_CNT"	id="TOTAL_CNT"		value="<c:out value="${INIT_DATA.TOTAL_CNT}"/>"/>
				<input type="hidden" name="DESERTIONNO"	id="DESERTIONNO"	value=""/>
				<input type="hidden" name="RTN_URL"		id="RTN_URL"	value="/user/animal/adoptAnimal.do"/>
				
				<!-- 검색 -->
					<div class="list-search">
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
											<th><label for="UPR_CD">지역검색</label></th>
											<td>
												<select name="UPR_CD" id="UPR_CD" onchange="fnGetOrgData(this.value);" >
													<option value="">전체</option>
													<option value="6110000" <c:if test="${INIT_DATA.UPR_CD eq '6110000'}">selected="selected"</c:if> >서울특별시</option>
													<option value="6260000" <c:if test="${INIT_DATA.UPR_CD eq '6260000'}">selected="selected"</c:if>>부산광역시</option>
													<option value="6270000" <c:if test="${INIT_DATA.UPR_CD eq '6270000'}">selected="selected"</c:if>>대구광역시</option>
													<option value="6280000" <c:if test="${INIT_DATA.UPR_CD eq '6280000'}">selected="selected"</c:if>>인천광역시</option>
													<option value="6290000" <c:if test="${INIT_DATA.UPR_CD eq '6290000'}">selected="selected"</c:if>>광주광역시</option>
													<option value="5690000" <c:if test="${INIT_DATA.UPR_CD eq '5690000'}">selected="selected"</c:if>>세종특별자치시</option>
													<option value="6300000" <c:if test="${INIT_DATA.UPR_CD eq '6300000'}">selected="selected"</c:if>>대전광역시</option>
													<option value="6310000" <c:if test="${INIT_DATA.UPR_CD eq '6310000'}">selected="selected"</c:if>>울산광역시</option>
													<option value="6410000" <c:if test="${INIT_DATA.UPR_CD eq '6410000'}">selected="selected"</c:if>>경기도</option>
													<option value="6420000" <c:if test="${INIT_DATA.UPR_CD eq '6420000'}">selected="selected"</c:if>>강원도</option>
													<option value="6430000" <c:if test="${INIT_DATA.UPR_CD eq '6430000'}">selected="selected"</c:if>>충청북도</option>
													<option value="6440000" <c:if test="${INIT_DATA.UPR_CD eq '6440000'}">selected="selected"</c:if>>충청남도</option>
													<option value="6450000" <c:if test="${INIT_DATA.UPR_CD eq '6450000'}">selected="selected"</c:if>>전라북도</option>
													<option value="6460000" <c:if test="${INIT_DATA.UPR_CD eq '6460000'}">selected="selected"</c:if>>전라남도</option>
													<option value="6470000" <c:if test="${INIT_DATA.UPR_CD eq '6470000'}">selected="selected"</c:if>>경상북도</option>
													<option value="6480000" <c:if test="${INIT_DATA.UPR_CD eq '6480000'}">selected="selected"</c:if>>경상남도</option>
													<option value="6500000" <c:if test="${INIT_DATA.UPR_CD eq '6500000'}">selected="selected"</c:if>>제주특별자치도</option>
												</select>	
												<select name="ORG_CD" id="ORG_CD" >
													<option value="">전체</option>
												</select>						
											</td>
										</tr>
										<tr>
											<th><label for="UP_KIND_CD">축종/품종</label></th>
											<td>
												<select name="UP_KIND_CD" id="UP_KIND_CD" onchange="fnGetKindData(this.value);" >
													<option value="">전체</option>
													<option value="417000" <c:if test="${INIT_DATA.UP_KIND_CD eq '417000'}">selected="selected"</c:if> >강아지</option>
													<option value="422400" <c:if test="${INIT_DATA.UP_KIND_CD eq '422400'}">selected="selected"</c:if>>고양이</option>
													<option value="429900" <c:if test="${INIT_DATA.UP_KIND_CD eq '429900'}">selected="selected"</c:if>>기타</option>
												</select>	
												<select name="KIND_CD" id="KIND_CD" >
													<option value="">전체</option>
												</select>					
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="sch-btn"><a href="#" onclick="fnSearch();" class="schBtn">검색</a></div>
						</div>
					</fieldset>
				</div>
				<!-- 검색 끝 -->
				<!-- 리스트 -->
				<div class="insight-list">
					<p class="list-total">※ 조회되는 데이터는 <span style="color:red">동물보호시스템</span>에서 제공받은 데이터 이며 
					상태는 <span style="color:red">보호중(입양가능)</span>인 데이터만 조회 됩니다.</p>
					<br/>
					<div class="videoList">
						<ul>
							<c:if test="${not empty INIT_DATA.resultList}">
								<c:forEach items="${INIT_DATA.resultList}" var="item" varStatus="rowStatus">
									<li>
										<div class="videoArea">
											<p>
												<a href="javascript:fnDetail(<c:out value='${item.desertionNo}' />);">
												<img alt="" src="${item.popfile}" width="100%" />
												</a>
											</p>
											<div class="videoInfo">
												<h5><a href="javascript:fnDetail(<c:out value='${item.desertionNo}' />);"><c:out value='${item.noticeNo}' /></a></h5>
												<dl>
													<dt> 
														<span style="color:#843817;"><c:out value="${item.kindCd}" /></span> / 
														<span style="color:black;">
															<c:if test="${item.sexCd eq 'M'}">수컷</c:if>
															<c:if test="${item.sexCd eq 'F'}">암컷</c:if>
															<c:if test="${item.sexCd eq 'Q'}">미상</c:if>
														</span>
													</dt>
												</dl>										
												<dl>
													<dt>  
														<span style="color:black;"><c:out value="${item.orgNm}" /></span>
													</dt>
												</dl>										
											</div>
										</div>
									</li>
								</c:forEach>
							</c:if>
							<c:if test="${empty INIT_DATA.resultList}">
								<div class="list-no">
									<p><img src="/static_root/images/btnIcn/icn_list_no.png" alt="" title="" /></p>
									<h1>목록이 없습니다.</h1>
								</div>
							</c:if>
						</ul>
					</div>
				</div>
				<!-- 리스트 끝 -->


				<!-- 페이징 -->
				<div class="list-paging pb70">
					<dd id="paging_bar">
					</dd>
				</div>
				<!-- 페이징 끝 -->

			
				</form>
			</div>
			<!-- 본문영역 끝 -->
			<!-- 하단영역 -->
			<%@ include file="/static_root/inc/footer.jsp" %>
			<!-- 하단영역 끝 -->
		</div>
	</body>
</html>
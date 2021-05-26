<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/static_root/inc/apt_top.jsp" %>
</head>
<body id="user">
	<div id="wrap">
		<!-- 상단영역 -->
		<%@ include file="/static_root/inc/apt_header.jsp" %>
		<!-- 상단영역 끝 -->

		<ul id="content">
			<li id="right">
				<!-- 타이틀/네비 -->
				<div class="titleNaviNew">
					<h3 class="subTitle">[부천 일루미스테이트]&nbsp;입주자 관리</h3>
				</div>
				<!-- 타이틀/네비 끝 -->

				<!-- 본문내용 //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
				<div id="cont">
					<section class="sect_area sect_first_area">
						<!-- 검색 -->
						<form name="frm" id="frm" method="post" action="#">
							<input type="hidden" name="CURR_PAGE" id="CURR_PAGE" value="${INIT_DATA.CURR_PAGE}" />
							<input type="hidden" id="TOTAL_CNT"  name="TOTAL_CNT" value="${INIT_DATA.TOTAL_CNT}"/>
							<fieldset>
								<div class="searchUser">
									<ul>
										<li class="scharea3">
											<ul>
												<li>
													<label for="SCH_CO">단지</label>
													<select name="SCH_CO" id="SCH_CO" class="select" title="기업구분">
														<option value="">전체</option>
														<option value="10" <c:if test="${INIT_DATA.SCH_CO eq '10'}">selected="selected"</c:if> >1단지</option>
													</select>
												</li>
												<li>
													<label for="SCH_TYPE">동</label>
													<select name="SCH_TYPE" id="SCH_TYPE" class="select" title="고용형태">
														<option value="">전체</option>
														<option value="10" <c:if test="${INIT_DATA.SCH_TYPE eq '10'}">selected="selected"</c:if> >101동</option>
													</select>
												</li>
												<li>
													<label for="SCH_CAREER">위임장납부</label>
													<select name="SCH_CAREER" id="SCH_CAREER" class="select" title="경력">
														<option value="">전체</option>
														<option value="10" <c:if test="${INIT_DATA.SCH_CAREER eq '10'}">selected="selected"</c:if> >납부</option>
														<option value="10" <c:if test="${INIT_DATA.SCH_CAREER eq '10'}">selected="selected"</c:if> >미납부</option>
													</select>
												</li>
											</ul>
										</li>
										<li class="scharea1">
											<label for="SCH_WORD">동/호수</label>
											<input type="text" maxlength="50" name="SCH_WORD" id="SCH_WORD" class="input" value="${INIT_DATA.SCH_WORD}" onkeyup="if(event.keyCode==13){fnSearch();}" placeholder="동/호수" />
										</li>
									</ul>
									<div><a href="#" onclick="fnSearch(); return false;">SEARCH</a></div>
								</div>
							</fieldset>
						</form>
						<!-- 검색 끝 -->
						<dl class="titleEaB">
							<dt>총 <strong><c:out value="2"/></strong> 건</dt>
							<dd>
								<a href="#" class="mBtn3">명단 업로드</a>
								<a href="#" class="mBtn4">명단다운로드</a>
								<a href="#" class="mBtn5">SMS다운로드</a>
							</dd>
						</dl>
						<!-- 리스트 -->
						<div class="bbsJobList">
							<table summary="청년강소기업체험">
								<caption>청년강소기업체험</caption>
								<colgroup>
									<col width="*" />
									<col width="18%" />
									<col width="12%" />
									<col width="20%" />		
									<col width="15%" />
									<col width="11%" />	
								</colgroup>
								<thead>
									<tr>
										<th>동</th>
										<th>호수</th>
										<th>성명</th>
										<th>연락처</th>
										<th>위임장제출여부</th>
										<th>회비납부</th>
										<th>등급</th>							
									</tr>
								</thead>
								<tbody>
									<tr>
										<td><strong class="tb_hide">동</strong>102동</td>
										<td><strong class="tb_hide">호수</strong>1102호</td>
										<td><strong class="tb_hide">성명</strong>최숙*</td>
										<td><strong class="tb_hide">성명</strong>-</td>
										<td><strong class="tb_hide">위임장제출여부</strong>미제출</td>
										<td><strong class="tb_hide">회비납부</strong>미납부</td>
										<td><strong class="tb_hide">등급</strong>비인증회원</td>
									</tr>
									<tr>
										<td><strong class="tb_hide">동</strong>104동</td>
										<td><strong class="tb_hide">호수</strong>1402호</td>
										<td><strong class="tb_hide">성명</strong>정재*</td>
										<td><strong class="tb_hide">성명</strong>010-1234-5678</td>
										<td><strong class="tb_hide">위임장제출여부</strong>제출</td>
										<td><strong class="tb_hide">회비납부</strong>납부</td>
										<td><strong class="tb_hide">등급</strong>인증회원</td>
									</tr>
<%-- 									<c:if test="${not empty INIT_DATA.resultList}"> --%>
<%-- 										<c:forEach items="${INIT_DATA.resultList}" var="item" varStatus="status"> --%>
<!-- 											<tr> -->
<%-- 												<th class="jobtit">${item.empWantedTitle}</th> --%>
<%-- 												<td><strong class="tb_hide">채용업체명</strong> ${item.empBusiNm}</td> --%>
<%-- 												<td><strong class="tb_hide">기업구분명</strong> ${item.coClcdNm }</td> --%>
<%-- 												<td><strong class="tb_hide">채용기간</strong> ${item.empWantedStdt} ~ ${item.empWantedEndt}</td> --%>
<%-- 												<td><strong class="tb_hide">고용형태</strong> ${item.empWantedTypeNm}</td> --%>
<%-- 												<td class="jobbtn"><a href="javascript:fnDetail('${item.empWantedHomepgDetail}');"  class="btn7 w50">보기</a></td> --%>
<!-- 											</tr> -->
<%-- 										</c:forEach> --%>
<%-- 									</c:if> --%>
<%-- 									<c:if test="${empty INIT_DATA.resultList}"> --%>
<!-- 										<tr> -->
<!-- 											<td class="no-list" colspan="6">검색결과가 없습니다.</td> -->
<!-- 										</tr> -->
<%-- 									</c:if> --%>
								</tbody>
							</table>
						</div>
						<!-- 리스트 끝 -->
						
						<!-- 페이징 -->
						<div class="listPaging mt30" id="paging_bar"></div>
						<!-- 페이징 끝 -->
					</section>
				</div>
				<!-- 본문내용 끝 //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
			</li>
		</ul>

		<!-- 하단영역 -->
		<%@ include file="/static_root/inc/apt_footer.jsp" %>
		<!-- 하단영역 끝 -->
	</div>
</body>
</html>
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
					<h3 class="subTitle">공지사항</h3>
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
										<li class="scharea2">
											<ul>
												<li>
													<select name="SCH_CAREER" id="SCH_CAREER" class="select" title="경력">
														<option value="">전체</option>
														<option value="10" <c:if test="${INIT_DATA.SCH_CAREER eq '10'}">selected="selected"</c:if> >제목</option>
														<option value="10" <c:if test="${INIT_DATA.SCH_CAREER eq '10'}">selected="selected"</c:if> >내용</option>
														<option value="10" <c:if test="${INIT_DATA.SCH_CAREER eq '10'}">selected="selected"</c:if> >제목+내용</option>
														<option value="10" <c:if test="${INIT_DATA.SCH_CAREER eq '10'}">selected="selected"</c:if> >작성자</option>
													</select>
												</li>
												<li> 
													<input type="text" maxlength="50" name="SCH_WORD" id="SCH_WORD" class="input" value="${INIT_DATA.SCH_WORD}" onkeyup="if(event.keyCode==13){fnSearch();}" placeholder="제목/내용" />
												</li>
											</ul>
										</li>
									</ul>
									<div><a href="#" onclick="fnSearch(); return false;">SEARCH</a></div>
								</div>
							</fieldset>
						</form>
						<!-- 검색 끝 -->
						
						<!-- 리스트 -->
						<div class="bbsJobList">
							<table summary="청년강소기업체험">
								<caption>청년강소기업체험</caption>
								<colgroup>
									<col width="6%" />
									<col width="*" />
									<col width="20%" />
									<col width="20%" />		
									<col width="6%" />		
								</colgroup>
								<thead>
									<tr>
										<th>번호</th>
										<th>제목</th>
										<th>작성자</th>
										<th>작성일</th>
										<th>조회수</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td><strong class="tb_hide">번호</strong>3</td>
										<td><strong class="tb_hide">제목</strong>부천 일루미스테이트 입주예정자분들 환영합니다.</td>
										<td><strong class="tb_hide">작성자</strong>관리자</td>
										<td><strong class="tb_hide">작성일</strong>2021-05-24</td>
										<td><strong class="tb_hide">조회수</strong>26</td>
									</tr>
									<tr>
										<td><strong class="tb_hide">번호</strong>2</td>
										<td><strong class="tb_hide">제목</strong>한화포레나 수원장인 입주예정자분들 환영합니다.</td>
										<td><strong class="tb_hide">작성자</strong>관리자</td>
										<td><strong class="tb_hide">작성일</strong>2021-05-22</td>
										<td><strong class="tb_hide">조회수</strong>50</td>
									</tr>
									<tr>
										<td><strong class="tb_hide">번호</strong>1</td>
										<td><strong class="tb_hide">제목</strong>올마이티ㅋㅋㅋ퍼니 설립</td>
										<td><strong class="tb_hide">작성자</strong>관리자</td>
										<td><strong class="tb_hide">작성일</strong>2021-05-19</td>
										<td><strong class="tb_hide">조회수</strong>68</td>
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
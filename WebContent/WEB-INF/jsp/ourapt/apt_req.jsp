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
					<h3 class="subTitle">견적요청</h3>
				</div>
				<!-- 타이틀/네비 끝 -->

				<!-- 본문내용 //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
				<div id="cont" class="seoil_core">
					<section class="sect_area sect_first_area">
						<h4 class="title1">상담내용을 적어서 보내주시면 빠른시일내에 답변 드리겠습니다.</h4>
						<br/>
							<div class="bbsView" >
								<table summary="학적정보">
									<caption>학적정보</caption>
									<colgroup>
										<col width="20%" />
										<col width="*" />
									</colgroup>
									<tbody>
										<tr>
											<th>성명</th>
											<td>
												<input type="text" name="" id="" title="" class="input w99p" value="" maxlength="50"  />
											</td>
										</tr>
										<tr>
											<th>기관명</th>
											<td>
												<input type="text" name="" id="" title="" class="input w99p" value="" maxlength="50"  />
											</td>
										</tr>
										<tr>
											<th>답변받을 연락처</th>
											<td>
												<input type="text" name="" id="" title="" class="input w99p" value="" maxlength="50"  />
											</td>
										</tr>
										<tr>
											<th>이메일</th>
											<td>
												<input type="text" name="" id="" title="" class="input w99p" value="" maxlength="50"  />
											</td>
										</tr>
										<tr>
											<th>내용</th>
											<td>
												<textarea name="" id="" rows="" cols="" title="문의내용" style="width:99%; height:150px; letter-spacing:-0.5px; word-spacing:2px; line-height:24px;" class="input" maxlength="2000" placeholder="문의 내용"></textarea>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						<div class="core_btn">
							<a href="/apt_main.do" class="mt30" style="background-color:#ff9900;">견적요청</a>
							<a href="/apt_main.do" class="mt30">메인으로</a>
						</div>
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
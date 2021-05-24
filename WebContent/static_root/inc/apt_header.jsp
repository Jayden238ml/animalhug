		<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
		<script language="javascript">
			var usrType = '${INIT_DATA.SESSION_USER_TY_CD}';
			var usrAuth = '${INIT_DATA.SESSION_AUTH}';
			function fnMain(){
 				location.href = "/main.do";
			}
			
			function logout(){
// 				fnPortalLogOut();
				location.href="/logOut.do";
			}
			
			function openLogin(type){
				gfnOpenLayerPopup('/common/index.do?jpath=/common/pop_login&TYPE='+ type);
			}
			
			// 외부상담사 로그인 팝업
			function openConsultLogin(){
				gfnOpenLayerPopup('/common/index.do?jpath=/common/consultLogin');
			}
						
			$(document).ready(function() {
				// 메뉴드롭다운
				$(".tmd").hover(
					function() {
						$(".subGnb").css("display", "block");
						
						var TOPMENU = $(this).parent().find('[name=topmenu]').val();
						var resultHtml = "";
						
						$.ajax({ 
							 type : "post"
							,url  : "/topMenu.do"
							,data : {
								"MENU_LEVL"  	: "2"
							}
							,dataType : "json"
							,success : function(transport) {
								
								var TOP_MENU_LINE = 0;
								var tamp_menu_code = "";
								var cur_menu_code = "";
								
								$.each(transport.menuList, function (index) {
									
									cur_menu_code = this.TOP_MENU_CODE;
									
									if(cur_menu_code != tamp_menu_code){
										$(".sub_depth_line" + TOP_MENU_LINE).html(resultHtml);
										resultHtml = "";
										
										++ TOP_MENU_LINE;
										tamp_menu_code = this.TOP_MENU_CODE;
									}
									
									var html = "";
									html += "<li class="+TOP_MENU_LINE+">";
									html += '	<a href="javascript:fncLeftMenuMoveForHeader(\''+this.MENU_CODE+'\',\''+this.MENU_URL+'\',\''+this.TARGET_LOCT+'\',\''+this.TOP_MENU_CODE+'\');">'+this.MENUNM+'</a>';
									html += "</li>";
									resultHtml += html;
									
								});
								
								$(".sub_depth_line" + TOP_MENU_LINE).html(resultHtml);
							}
						});
						
					}
				);
				
 				$(".subGnb").hover(
						function() {
							$(".subGnb").css("display", "block");
						},
						function() {
							$(".subGnb").css("display", "none");
						}
				);
				
				$(".sub_depth2 > li > a").hover(
						function() {
							$(".sub_depth3 > ul").css("display", "block");
						}
				);
			});		
			
			 $(document).ready(function() {
					 // 서일대 사이트맵
					$('#SLSiteMapOpen').click(function(){ 
						$('#sitemapSL').show();
					});
					$('#SLSiteMapClose').click(function(){
						$('#sitemapSL').hide();
					});
				 
					// 모바일 전체메뉴 //
					var mobileLnbChk = 0;
					$('#mobileLnbOpen').click(function(){ 
						if (mobileLnbChk == 0) {
							$('#header-mobile .hm-total').animate({ marginRight : '0' }, 350, 'easeOutQuad');
							//$(this).removeClass('ion-android-menu').addClass('ion-android-close');
							mobileLnbChk = 1;
						} else {
							$('#header-mobile .hm-total').animate({ marginRight : '-100%' }, 350, 'easeOutQuad');
							//$(this).removeClass('ion-android-close').addClass('ion-android-menu');
							mobileLnbChk = 0;
						}
					});
					$('#mobileLnbClose').click(function(){ 
						$('#header-mobile .hm-total').animate({ marginRight : '-100%' }, 350, 'easeOutQuad');
						//$('.ion-android-close').removeClass('ion-android-close').addClass('ion-android-menu');
						mobileLnbChk = 0;
					});	
					$('#mobileLogin').click(function(){ 
						$('#header-mobile .hm-total').animate({ marginRight : '-100%' }, 350, 'easeOutQuad');
						//$('.ion-android-close').removeClass('ion-android-close').addClass('ion-android-menu');
						mobileLnbChk = 0;
					});	
					
					$('.total-list li.hm-sub>a').on('click', function(){
						$(this).removeAttr('href');
						var element = $(this).parent('li');
						if (element.hasClass('open')) {
							element.removeClass('open');
							element.find('li').removeClass('open');
							element.find('ul').slideUp();
						}
						else {
							element.addClass('open');
							element.children('ul').slideDown();
							element.siblings('li').children('ul').slideUp();
							element.siblings('li').removeClass('open');
							element.siblings('li').find('li').removeClass('open');
							element.siblings('li').find('ul').slideUp();
						}
					});
					
					//팝업창
					$('#header-mobile > .hm-top > li:nth-child(2)').click(function(){
						$('.total-bg').show();
					});
					$('#header-mobile > .hm-total > ul > li:nth-child(2)').click(function(){
						$('.total-bg').hide();
					});	
			
				});		
			 
			 function fnSaMove(){
				 $.ajax({ 
					 type : "post"
					,url  : "/SaIpCheck.do"
					,data : {}
					,dataType : "json"
					,success : function(transport) {
						if(transport.IP_CHK == "N"){
							alert("허용된 IP가 아닙니다. 관리자에게 문의 하세요.");
							return;
						}else{
							var headerfrm  = document.headerfrm;
							headerfrm.action= "/adnMain.do";
							headerfrm.submit();
						}
					}
				});
			 }
			 
			 function fnStuMove(){
				var headerfrm  = document.headerfrm;
				headerfrm.action= "/user/My/MySt011L.do?CURRENT_MENU_CODE=MENU0062&TOP_MENU_CODE=MENU0008";
				headerfrm.submit();
			 }
		</script>
		
		<form name="headerfrm" id="headerfrm" method="post">
			<input type="hidden" name="TOP_MENU_CODE" id="TOP_MENU_CODE" value="${sessionScope.TOP_MENU_CODE}" />
		</form>
		
		<!-- 스킵메뉴 -->
		<div class="accessibility">
			<a href="#main-menu">주메뉴 바로가기</a>
			<a href="#cont">본문 바로가기</a>
		</div>
		<!-- 스킵메뉴 끝 -->
		
		<!-- 상단영역 -->
		<header id="header">
			<div class="gnbArea">
				<div class="clearfix">
					<h1><a href="javascript:fnMain();"><img src="/static_root/images/common/apt_logo.jpg" alt="서일대학교 학생성공관리시스템" title="서일대학교 학생성공관리시스템" /></a></h1>
					<ul class="gnbNavi clearfix">
						<c:if test="${INIT_DATA.SESSION_USR_NM ne ''}">
							<li><span>${INIT_DATA.SESSION_USR_NM}</span> 님</li>
						</c:if>
						<li class="login-out">
							<c:if test="${INIT_DATA.SESSION_USR_NM eq ''}">
								<a href="javascript:openLogin('P');">로그인</a>	
							</c:if>
							<c:if test="${INIT_DATA.SESSION_USR_NM ne ''}">
								<a href="javascript:logout();">로그아웃</a> 
							</c:if>
						</li>
					</ul>
				</div>
			</div>
			<div class="menuArea" id="main-menu">
				<ul class="mainMenu">
				</ul>
			</div>
		</header>
		<!-- 상단영역 끝 -->
		
		
		<!-- 모바일상단 영역 -->
		<div id="header-mobile">
			<ul class="hm-top">
				<li>
					<h1><a href="javascript:fnMain();"><img src="/static_root/images/common/apt_logo.jpg" height="32" alt="서일대학교 학생성공관리시스템" title="서일대학교 학생성공관리시스템" /></a></h1>
				</li>
				<li><i class="ion-android-menu" aria-hidden="true" id="mobileLnbOpen"></i></li>
			</ul>
			
			<div class="total-bg">&nbsp;</div>
			
 			<div class="hm-total">
				<ul class="total-tit">
					<li><img src="/static_root/images/common/apt_logo.jpg" height="30" alt="서일대학교 학생성공관리시스템" title="서일대학교 학생성공관리시스템" /></li>
					<li><i id="mobileLnbClose" class="ion-close" aria-hidden="true"></i></li>
				</ul>
				<ul class="total-btn">
					<li>
						<c:if test="${INIT_DATA.SESSION_USR_NM eq ''}">
							<a href="javascript:openLogin('M');" id="mobileLogin">로그인</a>	
						</c:if>
						<c:if test="${INIT_DATA.SESSION_USR_NM ne ''}">
							<a href="javascript:logout();">로그아웃</a> 
						</c:if>
					</li>
					<li><a href="http://hm.seoil.ac.kr/?kr" target="_blank">서일대학교</a></li>
				</ul>
				<div class="total-list">
					<ul class="hm-menu">
						<li class="hm-sub sub-depth1"><a href="#"><span>커뮤니티</span> <i class="ion-android-add" aria-hidden="true"></i></a>
							<ul>
								<li class="sub-depth2"><a href="/user/Bd/BdCm010L.do?BD_NO=1&CURRENT_MENU_CODE=MENU0059&TOP_MENU_CODE=MENU0007"><span>공지사항</span></a></li>
								<li class="sub-depth2"><a href="/user/Bd/BdCm010L.do?BD_NO=2&CURRENT_MENU_CODE=MENU0060&TOP_MENU_CODE=MENU0007"><span>자료실</span></a></li>
								<li class="sub-depth2"><a href="/user/Bd/BdCm010L.do?BD_NO=3&CURRENT_MENU_CODE=MENU0061&TOP_MENU_CODE=MENU0007"><span>FAQ</span></a></li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<!-- 모바일상단 영역 끝 -->
		
		<!-- 서브비주얼 -->
 		<%
			if(request.getRequestURI().indexOf("/main.jsp") < 0){ 
		%>
		<div id="subVisual" class="bg${sessionScope.TOP_MENU_CODE }">
			<div>
				<c:if test="${not empty INIT_DATA.USER_TOP_MENU }">
					<c:forEach var="item" items="${INIT_DATA.USER_TOP_MENU }">
						<c:if test="${item.MENU_CODE eq sessionScope.TOP_MENU_CODE}">
							<h1>${item.MENUNM}</h1>
						</c:if>
					</c:forEach>
				</c:if>
				<h2>서일에서 내일로!</h2>
			</div>
		</div>
		<%
			}
		%>
		<!-- 서브비주얼 끝 -->
		
		
		<!-- 사이트맵 -->
		<nav id="sitemapSL">
			<div class="site_map_wrap">
				<div class="site_map_title">
					<h2>사이트맵</h2>
					<span><i id="SLSiteMapClose" class="ion-close" aria-hidden="true"></i></span>
				</div>
				<div class="site_map_area">
					<div class="site_map_list">
						<h3>핵심역량 소개</h3>
						<ul>
							<li><a href="javascript:fncHeaderMenuMove('MENU0010','/user/Ex/ExCt010L.do','MENU0001');">핵심역량 소개</a></li>
							<li><a href="javascript:fncHeaderMenuMove('MENU0012','/user/Ex/ExCt020L.do','MENU0001');">서일 인증제 소개</a></li>
						</ul>
					</div>			
				</div>
			</div>
		</nav>
		<!-- 사이트맵 끝 -->
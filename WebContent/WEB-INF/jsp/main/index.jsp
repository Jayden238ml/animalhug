<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<meta name="title" content="애니멀허그" />
	<meta name="description" content="유기견조회, 입양가능동물 조회, 자유게시판, 찾아주세요, 건의사항" />
	<meta name="keywords" content="animalhug,애니멀허그,유기견,유기견입양,커뮤니티" />
	<meta name="robots" content="index, follow">
	<link rel="canonical" href="http://www.animalhug.co.kr">
	<meta property="og:type" content="article" />
	<meta property="og:site_name" content="애니멀허그">
	<meta property="og:type" content="article">
	<meta property="og:url" content="http://www.animalhug.co.kr">
	<meta property="og:title" content="유기동물 | 커뮤니티 | 애니멀허그">
	<meta property="og:image" content="/static_root/images/common/meta_img.jpg">
	<meta property="og:description" content="애니멀허그 " />

	<title>애니멀허그</title>
	<%@ include file="/static_root/inc/head.jsp" %>
<script type="text/javascript">

//상세
function fnDetail(bdNo, bbsNo){
	$('#BD_NO').val(bdNo);
	$('#BBS_NO').val(bbsNo);
	$('#frm').attr("action", "/user/Board/comm_notice_view.do").submit();
}

function fnRecurit(seq){
	if(seq == '1'){
		window.open ('/static_root/event/recruit_list.html','english2','left=5,top=112,width=710,height=940,scrollbars=yes,toolbars=no,status=no,resizable=0,menubar=no');   
	}else if(seq == '2'){
		window.open ('/static_root/event/recruit_1903.html','english','left=5,top=112,width=710,height=940,scrollbars=yes,toolbars=no,status=no,resizable=0,menubar=no');
	}else{
		$('#frm').attr("action", "/common/index.do?jpath=/kor/offering/erp").submit();
	}
}
</script>
	</head>
	<body>
	<div id="wrap">
			<!-- 상단영역 -->
		<%@ include file="/static_root/inc/header.jsp" %>
		<!-- 상단영역 끝 -->
<div class="gpe_allcon_wrap0">
<div class="contents_area_wrap0">
	<div class="gpe_contents_box">
		<div class="gpe_pm_conban">
			<div class="gpe_pm_ban_imgbox" style="overflow: hidden; position: relative; display: block;">
				<div class="slides_control" style="position: relative; width: 2370px; height: 120px; left: -790px;">
					<a href="https://gxeshop.ivyro.net/gdesign_sub_store" target="_blank" style="position: absolute; top: 0px; left: 790px; z-index: 0; display: none;">
					<img src="https://simpleeye.ivyro.net/xe1710/files/attach/images/7486/032a10322a14d0515a0be12a8fa5da50.png?1719814089159" alt="롤링배너1번"></a>
					<a href="https://gxeshop.ivyro.net/gdesign_sub_store" target="_blank" style="position: absolute; top: 0px; left: 790px; z-index: 5; display: block;">
					<img src="https://simpleeye.ivyro.net/xe1710/files/attach/images/7486/434fdc7649abd38bdf5b76deee3f1f96.png" alt="롤링배너2번"></a>
				</div>
			</div>
				<span class="gpe_prev"></span>
				<span class="gpe_next"></span>
		<ul class="gpe_pagination"><li class=""><a href="#0">1</a></li><li class="current"><a href="#1">2</a></li></ul></div>
		
		
		<div class="gpe_contents">
			<div class="gpe_contents_xecon">
<!-- 	============================================================ 조회수 베스트 START-->			
				<div class="xe-widget-wrapper " style="float: left; width: 388px; border-width: 0px; border-style: solid; border-color: rgb(0, 0, 0) rgb(255, 255, 255) rgb(0, 0, 0) rgb(0, 0, 0); margin: 10px 15px 0px 0px; background-color: transparent; background-image: none; background-repeat: repeat; background-position: 0% 0%;">
					<div style="*zoom:1;padding:0px 0px 0px 0px !important;">
						<div class="gpe_wgPopularT2 b">
							<h3 class="wgP_title">조회수베스트<a href="11111" class="popu_more"></a></h3><!--타이틀+더보기-->
							<ul class="wgP_contents">
								<li class="popu_li">
									<span class="Ncolor wgp_num01  ">1<span class="wgp_numR">위</span></span>
									<a onclick="window.open('https://simpleeye.ivyro.net/xe1710/4106','_self')" href="https://simpleeye.ivyro.net/xe1710/4106" class="min481">2014년 샘플그룹 경력사원 모집공고</a>
									<a onclick="window.open('https://simpleeye.ivyro.net/xe1710/4106','_self')" href="https://simpleeye.ivyro.net/xe1710/4106" class="max480">2014년 샘플그룹 경력사원 모집공고</a>
									<a onclick="window.open('https://simpleeye.ivyro.net/xe1710/4106','_self')" href="https://simpleeye.ivyro.net/xe1710/4106" class="max320">2014년 샘플그룹 경력사원 모집공고</a>
									<span class="wgPdate">2014-07-24</span>			
									<span class="wgPicon jo"></span>
									<span class="wgPiconTxt jo"></span>
								</li>
								<li class="popu_li">
									<span class="Ncolor  wgp_num02 ">2<span class="wgp_numR">위</span></span>
									<a onclick="window.open('https://simpleeye.ivyro.net/xe1710/4130','_self')" href="https://simpleeye.ivyro.net/xe1710/4130" class="min481">기업 갤러리이미지 샘플</a>
									<a onclick="window.open('https://simpleeye.ivyro.net/xe1710/4130','_self')" href="https://simpleeye.ivyro.net/xe1710/4130" class="max480">기업 갤러리이미지 샘플</a>
									<a onclick="window.open('https://simpleeye.ivyro.net/xe1710/4130','_self')" href="https://simpleeye.ivyro.net/xe1710/4130" class="max320">기업 갤러리이미지 샘플</a>
									<a href="https://simpleeye.ivyro.net/xe1710/4130#comment" class="reNum">+2</a>			<span class="wgPdate">2014-07-25</span>			<span class="wgPicon jo"></span>
									<span class="wgPiconTxt jo"></span>
								</li>
								<li class="popu_li">
									<span class="Ncolor   wgp_num03">3<span class="wgp_numR">위</span></span>
									<a onclick="window.open('https://simpleeye.ivyro.net/xe1710/4167','_self')" href="https://simpleeye.ivyro.net/xe1710/4167" class="min481">네이버 개발자 지원 프로그램 네이버 개발...</a>
									<a onclick="window.open('https://simpleeye.ivyro.net/xe1710/4167','_self')" href="https://simpleeye.ivyro.net/xe1710/4167" class="max480">네이버 개발자 지원 프로그램 네이버 개발...</a>
									<a onclick="window.open('https://simpleeye.ivyro.net/xe1710/4167','_self')" href="https://simpleeye.ivyro.net/xe1710/4167" class="max320">네이버 개발자 지원 프로그램 네...</a>
									<span class="wgPdate">2014-07-26</span>			<span class="wgPicon jo"></span>
									<span class="wgPiconTxt jo"></span>
								</li>
								<li class="popu_li">
									<span class="Ncolor   ">4<span class="wgp_numR">위</span></span>
									<a onclick="window.open('https://simpleeye.ivyro.net/xe1710/2491','_self')" href="https://simpleeye.ivyro.net/xe1710/2491" class="min481">LG 류현택이 후배들에게 고마운 마음 전합...</a>
									<a onclick="window.open('https://simpleeye.ivyro.net/xe1710/2491','_self')" href="https://simpleeye.ivyro.net/xe1710/2491" class="max480">LG 류현택이 후배들에게 고마운 마음 전합...</a>
									<a onclick="window.open('https://simpleeye.ivyro.net/xe1710/2491','_self')" href="https://simpleeye.ivyro.net/xe1710/2491" class="max320">LG 류현택이 후배들에게 고마운 ...</a>
									<a href="https://simpleeye.ivyro.net/xe1710/2491#comment" class="reNum">+2</a>			<span class="wgPdate">2014-02-21</span>			<span class="wgPicon jo"></span>
									<span class="wgPiconTxt jo"></span>
								</li>
								<li class="popu_li">
									<span class="Ncolor   ">5<span class="wgp_numR">위</span></span>
									<a onclick="window.open('https://simpleeye.ivyro.net/xe1710/2489','_self')" href="https://simpleeye.ivyro.net/xe1710/2489" class="min481">술 취한 언니 집에 와서는, 대박독하고 도...</a>
									<a onclick="window.open('https://simpleeye.ivyro.net/xe1710/2489','_self')" href="https://simpleeye.ivyro.net/xe1710/2489" class="max480">술 취한 언니 집에 와서는, 대박독하고 도...</a>
									<a onclick="window.open('https://simpleeye.ivyro.net/xe1710/2489','_self')" href="https://simpleeye.ivyro.net/xe1710/2489" class="max320">술 취한 언니 집에 와서는, 대박...</a>
									<a href="https://simpleeye.ivyro.net/xe1710/2489#comment" class="reNum">+2</a>			<span class="wgPdate">2014-02-21</span>			<span class="wgPicon jo"></span>
									<span class="wgPiconTxt jo"></span>
								</li>
							</ul>	
						</div>
					</div>
				</div>
<!-- 	============================================================ 조회수 베스트 END-->				
<!-- 	============================================================ 추천수 베스트 START-->
				<div class="xe-widget-wrapper " style="float: left; width: 389px; border-width: 0px; border-style: solid; border-color: rgb(0, 0, 0); margin: 10px 0px 0px; background-color: transparent; background-image: none; background-repeat: repeat; background-position: 0% 0%;">
					<div style="*zoom:1;padding:0px 0px 0px 0px !important;">
						<div class="gpe_wgPopularT2 gn">
							<h3 class="wgP_title">추천수베스트<a href="11111" class="popu_more"></a></h3><!--타이틀+더보기-->
							<ul class="wgP_contents">
								<li class="popu_li">
									<span class="Ncolor wgp_num01 wgp_num01M480  ">1<span class="wgp_numR">위</span></span>
									<a onclick="window.open('https://simpleeye.ivyro.net/xe1710/7433','_self')" href="https://simpleeye.ivyro.net/xe1710/7433" class="min481">공짜 지폐를 본 노숙자와 명품가방녀 공짜 ...</a>
									<a onclick="window.open('https://simpleeye.ivyro.net/xe1710/7433','_self')" href="https://simpleeye.ivyro.net/xe1710/7433" class="max480">공짜 지폐를 본 노숙자와 명품가방녀 공짜 ...</a>
									<a onclick="window.open('https://simpleeye.ivyro.net/xe1710/7433','_self')" href="https://simpleeye.ivyro.net/xe1710/7433" class="max320">공짜 지폐를 본 노숙자와 명품가...</a>
									<a href="https://simpleeye.ivyro.net/xe1710/7433#comment" class="reNum">+2</a>			<span class="wgPdate">2015-12-23</span>			<span class="wgPicon chu"></span>
									<span class="wgPiconTxt chu"></span>
								</li>
								<li class="popu_li">
									<span class="Ncolor  wgp_num02 ">2<span class="wgp_numR">위</span></span>
									<a onclick="window.open('https://simpleeye.ivyro.net/xe1710/7432','_self')" href="https://simpleeye.ivyro.net/xe1710/7432" class="min481">바나나 발음이 어려운 외국인</a>
									<a onclick="window.open('https://simpleeye.ivyro.net/xe1710/7432','_self')" href="https://simpleeye.ivyro.net/xe1710/7432" class="max480">바나나 발음이 어려운 외국인</a>
									<a onclick="window.open('https://simpleeye.ivyro.net/xe1710/7432','_self')" href="https://simpleeye.ivyro.net/xe1710/7432" class="max320">바나나 발음이 어려운 외국인</a>
									<a href="https://simpleeye.ivyro.net/xe1710/7432#comment" class="reNum">+2</a>			<span class="wgPdate">2015-12-23</span>			<span class="wgPicon chu"></span>
									<span class="wgPiconTxt chu"></span>
								</li>
								<li class="popu_li">
									<span class="Ncolor   wgp_num03">3<span class="wgp_numR">위</span></span>
									<a onclick="window.open('https://simpleeye.ivyro.net/xe1710/11369','_self')" href="https://simpleeye.ivyro.net/xe1710/11369" class="min481">LG 류현택이 후배들에게 고마운 마음 전합...</a>
									<a onclick="window.open('https://simpleeye.ivyro.net/xe1710/11369','_self')" href="https://simpleeye.ivyro.net/xe1710/11369" class="max480">LG 류현택이 후배들에게 고마운 마음 전합...</a>
									<a onclick="window.open('https://simpleeye.ivyro.net/xe1710/11369','_self')" href="https://simpleeye.ivyro.net/xe1710/11369" class="max320">LG 류현택이 후배들에게 고마운 ...</a>
									<a href="https://simpleeye.ivyro.net/xe1710/11369#comment" class="reNum">+2</a>			<span class="wgPdate">2016-01-25</span>			<span class="wgPicon chu"></span>
									<span class="wgPiconTxt chu"></span>
								</li>
								<li class="popu_li">
									<span class="Ncolor   ">4<span class="wgp_numR">위</span></span>
									<a onclick="window.open('https://simpleeye.ivyro.net/xe1710/11358','_self')" href="https://simpleeye.ivyro.net/xe1710/11358" class="min481">LG 류현택이 후배들에게 고마운 마음 전합...</a>
									<a onclick="window.open('https://simpleeye.ivyro.net/xe1710/11358','_self')" href="https://simpleeye.ivyro.net/xe1710/11358" class="max480">LG 류현택이 후배들에게 고마운 마음 전합...</a>
									<a onclick="window.open('https://simpleeye.ivyro.net/xe1710/11358','_self')" href="https://simpleeye.ivyro.net/xe1710/11358" class="max320">LG 류현택이 후배들에게 고마운 ...</a>
									<a href="https://simpleeye.ivyro.net/xe1710/11358#comment" class="reNum">+3</a>			<span class="wgPdate">2016-01-25</span>			<span class="wgPicon chu"></span>
									<span class="wgPiconTxt chu"></span>
								</li>
								<li class="popu_li">
									<span class="Ncolor   ">5<span class="wgp_numR">위</span></span>
									<a onclick="window.open('https://simpleeye.ivyro.net/xe1710/11353','_self')" href="https://simpleeye.ivyro.net/xe1710/11353" class="min481">LG 류현택이 후배들에게 고마운 마음 전합...</a>
									<a onclick="window.open('https://simpleeye.ivyro.net/xe1710/11353','_self')" href="https://simpleeye.ivyro.net/xe1710/11353" class="max480">LG 류현택이 후배들에게 고마운 마음 전합...</a>
									<a onclick="window.open('https://simpleeye.ivyro.net/xe1710/11353','_self')" href="https://simpleeye.ivyro.net/xe1710/11353" class="max320">LG 류현택이 후배들에게 고마운 ...</a>
									<a href="https://simpleeye.ivyro.net/xe1710/11353#comment" class="reNum">+1</a>			<span class="wgPdate">2016-01-25</span>			<span class="wgPicon chu"></span>
									<span class="wgPiconTxt chu"></span>
								</li>
							</ul>	
						</div>
					</div>
				</div>
<!-- 	============================================================ 추천수 베스트 END-->
<!-- 	============================================================ 캠핑장 둘러보기 START-->
				<div class="xe-widget-wrapper " style="float: left; width: 100%; border-width: 0px; border-style: solid; border-color: rgb(0, 0, 0); margin: 2px 0px 0px; background-color: transparent; background-image: none; background-repeat: repeat; background-position: 0% 0%;">
					<div class="gpe_WS_box"> 
    					<div class="gpe_WS_h2box" style="margin-bottom:px;">
							<h2 class="gpe_contents_wsTitle" style="color:#007bd3;">캠핑장 둘러보기</h2>
						</div>
						<a href="http://1111" class="widgetMoreLink"></a>
		    			<div style="*zoom:1;padding:0px 0px 0px 0px !important; unicode-bidi:isolate;">
		    				<div class="widgetNOVAContainer">
		                		<div class="gpe_wgGalleryADIV" style="unicode-bidi:isolate;">
									<ul class="gpe_wgGalleryA">
		        						<li style="width:175px; margin-bottom:px; margin-right:30px;">
											<a href="https://simpleeye.ivyro.net/xe1710/6345" class="thumb" style="width:175px;height:175px">
												<img src="https://simpleeye.ivyro.net/xe1710/files/thumbnails/345/006/175x175.crop.jpg" style="width:175px; height:175px" alt="thumbnail">
											</a>
											<a href="https://simpleeye.ivyro.net/xe1710/6345" class="title min481" style="width:177px;">설연휴때입을 신상여자니트</a>
											<a href="https://simpleeye.ivyro.net/xe1710/6345" class="title max480" style="width:177px;">설연휴때입을 신상여자...</a>
											<a href="https://simpleeye.ivyro.net/xe1710/6345" class="title max320" style="width:177px;">설연휴때입을 신상...</a>
											<a href="#" onclick="return false;" class="author member_4"><img src="https://simpleeye.ivyro.net/xe1710/modules/point/icons/GPE_icon/18.gif" alt="[레벨:18]" title="포인트:29162point (0%), 레벨:18/30" class="xe_point_level_icon" style="vertical-align:middle;margin-right:3px;">심플아이</a>
											<a href="https://simpleeye.ivyro.net/xe1710/6345#comment" class="gpe_wgGalleryA_retip0"><span class="retip0_icon"></span>2</a>
		        						</li>
										<li style="width:175px; margin-bottom:px; margin-right:30px;">
											<a href="https://simpleeye.ivyro.net/xe1710/6343" class="thumb" style="width:175px;height:175px">
												<img src="https://simpleeye.ivyro.net/xe1710/files/thumbnails/343/006/175x175.crop.jpg" style="width:175px; height:175px" alt="thumbnail">
											</a>
											<a href="https://simpleeye.ivyro.net/xe1710/6343" class="title min481" style="width:177px;">급매 새상품 신상아디다스</a>
											<a href="https://simpleeye.ivyro.net/xe1710/6343" class="title max480" style="width:177px;">급매 새상품 신상아디다스</a>
											<a href="https://simpleeye.ivyro.net/xe1710/6343" class="title max320" style="width:177px;">급매 새상품 신상아...</a>
											<a href="#" onclick="return false;" class="author member_4"><img src="https://simpleeye.ivyro.net/xe1710/modules/point/icons/GPE_icon/18.gif" alt="[레벨:18]" title="포인트:29162point (0%), 레벨:18/30" class="xe_point_level_icon" style="vertical-align:middle;margin-right:3px;">심플아이</a>
											<span class="gpe_wgGalleryA_retip0"><span class="retip0_icon"></span>0</span>
																	
		        						</li>
		            					<li style="width:175px; margin-bottom:px; margin-right:30px;">
											<a href="https://simpleeye.ivyro.net/xe1710/6341" class="thumb" style="width:175px;height:175px">
												<img src="https://simpleeye.ivyro.net/xe1710/files/thumbnails/341/006/175x175.crop.jpg" style="width:175px; height:175px" alt="thumbnail">
											</a>
											<a href="https://simpleeye.ivyro.net/xe1710/6341" class="title min481" style="width:177px;">스프라이트셔츠 특가로 팝니다</a>
											<a href="https://simpleeye.ivyro.net/xe1710/6341" class="title max480" style="width:177px;">스프라이트셔츠 특가로...</a>
											<a href="https://simpleeye.ivyro.net/xe1710/6341" class="title max320" style="width:177px;">스프라이트셔츠 특...</a>
											<a href="#" onclick="return false;" class="author member_4"><img src="https://simpleeye.ivyro.net/xe1710/modules/point/icons/GPE_icon/18.gif" alt="[레벨:18]" title="포인트:29162point (0%), 레벨:18/30" class="xe_point_level_icon" style="vertical-align:middle;margin-right:3px;">심플아이</a>
											<a href="https://simpleeye.ivyro.net/xe1710/6341#comment" class="gpe_wgGalleryA_retip0"><span class="retip0_icon"></span>3</a>
		        						</li>
		            					<li style="width:175px; margin-bottom:px; margin-right:30px;">
											<a href="https://simpleeye.ivyro.net/xe1710/6339" class="thumb" style="width:175px;height:175px">
												<img src="https://simpleeye.ivyro.net/xe1710/files/thumbnails/339/006/175x175.crop.jpg" style="width:175px; height:175px" alt="thumbnail">
											</a>
											<a href="https://simpleeye.ivyro.net/xe1710/6339" class="title min481" style="width:177px;">1일전에 구입한 한과세트 한과</a>
											<a href="https://simpleeye.ivyro.net/xe1710/6339" class="title max480" style="width:177px;">1일전에 구입한 한과세...</a>
											<a href="https://simpleeye.ivyro.net/xe1710/6339" class="title max320" style="width:177px;">1일전에 구입한 한...</a>
											<a href="#" onclick="return false;" class="author member_4"><img src="https://simpleeye.ivyro.net/xe1710/modules/point/icons/GPE_icon/18.gif" alt="[레벨:18]" title="포인트:29162point (0%), 레벨:18/30" class="xe_point_level_icon" style="vertical-align:middle;margin-right:3px;">심플아이</a>
											<span class="gpe_wgGalleryA_retip0"><span class="retip0_icon"></span>0</span>
		        						</li>
		        					</ul>
								</div>
	    					</div>
	    				</div>
    				</div>
    			</div>
<!-- 	============================================================ 캠핑장 둘러보기 END-->
			</div>
		</div>
	</div>
</div>
</div>




		<!-- 하단영역 -->
		<%@ include file="/static_root/inc/footer.jsp" %>
		<!-- 하단영역 끝 -->
	</div>
</body>
</html>
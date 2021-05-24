<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt"        prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"        prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1" />

<%@ include file="/static_root/inc/illumi_head.jsp" %>
<link rel='stylesheet' href='/static_root/chart/Nwagon.css' type='text/css'>
<script src='/static_root/chart/Nwagon_no_vml.js'></script>
<script type="text/javascript">
	$(document).ready(function(){

	});
	
	
	function fnSearch(){
		$('#ListFrm').attr("action", "/illumi/warrant_Avg.do").submit();	
	}
	
	
</script>
</head>
<body>
	<div id="wrap">
		<!-- 상단영역 -->
		<%@ include file="/static_root/inc/illumi_header.jsp" %>
		<!-- 상단영역 끝 -->

		<!-- 본문영역 -->
		<div id="content">
			<div id="rightCnt">
				<form name="ListFrm" id="ListFrm" method="post" action="/illumi/warrant_Avg.do">
				<br/>
				<dl class="list-title-btn">
				</dl>
				<br/><br/><br/><br/><br/>
				<!-- 리스트 - 정보/버튼 -->
				<fieldset>
					<legend>검색영역</legend>
					<div class="list-search2">
						<dl>
							<dd>
								<fieldset>
									<legend>검색</legend>
									<dl>
										<dt>
											<select name="SCH_TYPE" id="SCH_TYPE" style="width: 100px;" onchange="fnSearch();">
												<option value="">전체</option>
												<option value="1" <c:if test="${INIT_DATA.SCH_TYPE eq '1'}">selected="selected"</c:if>>1단지</option>
												<option value="2" <c:if test="${INIT_DATA.SCH_TYPE eq '2'}">selected="selected"</c:if> >2단지</option>
												<option value="3" <c:if test="${INIT_DATA.SCH_TYPE eq '3'}">selected="selected"</c:if>>3단지</option>
												<option value="4" <c:if test="${INIT_DATA.SCH_TYPE eq '4'}">selected="selected"</c:if>>4단지</option>
											</select>&nbsp;
										</dt>
										<dd><a href="#" onClick="javascript:fnSearch();"><i class="xi-search"></i></a></dd>
									</dl>
								</fieldset>
							</dd>
						</dl>
					</div>
				</fieldset>
				</form>
				<br/><br/>
				<div class="tableList tableTR">
					<div id="chart">
						<script>
							var v_info = [], name_info = [] , maxVal = [] , maxValPer = [];
							var title = '';
							var windowWidth2 = $( window ).width();	
							var height2 = 500;
							if(windowWidth2 > 1000){
								windowWidth2 = 1000;
							}
							if(windowWidth2 < 500){
								height2 = 250;
							}
							var aJsonArray = new Array();
								<c:forEach var="item" items="${INIT_DATA.resultList }" varStatus="status">
									var aJson = new Object();
									aJson.fir = '${item.HOSU_CNT}';
									aJson.sec = '${item.WARRANT_CNT}';
									aJsonArray.push(aJson);
									
									name_info.push('${item.DANZI}');
								</c:forEach>
								
								title = '위임장 수급 현황';
								
								var maxValue = 10, increment = 1, gab = 0;
								
								var jsonList = JSON.stringify(aJsonArray);
								$.each(aJsonArray,function(key,json){
									var eachArr = new Array();
									var maxhArr = new Array();
									var maxPerArr = new Array();
									eachArr.push(json.fir);
									eachArr.push(json.sec);
									maxhArr.push(json.fir);
									maxPerArr.push(json.sec);
									maxVal.push(maxhArr);
									maxValPer.push(maxPerArr);
									v_info.push(eachArr);
									
								}); 
								
								var max = Math.max.apply(null, maxVal)
								var max2 = Math.max.apply(null, maxValPer)
								if(max < max2){
									max = max2;
								}
								if((max + '').length < 3){
									gab = 10;
								}else{
									gab = 100;
								}
								increment = Math.ceil(max / 10);
								if(v_info != ""){
									var options = {
											'legend':{
												names: name_info,
												hrefs: []
											},
											'dataset':{
												title:title,
												values : v_info,
												colorset: ['#4F364C' , '#ff99ff'],
												fields : ["세대 수" , "위임장 수급"]
											},
											'chartDiv' : 'chart',
											'chartType' : 'multi_column',
											'chartSize' : {width:windowWidth2, height:height2},
											'minValue' : 0,
											'maxValue' : max,
											'increment' : increment
										};
									Nwagon.chart(options);
								}
						</script>
					</div>
				</div>
				
			</div>
		</div>
		<!-- 본문영역 끝 -->
		<!-- 하단영역 -->
		<%@ include file="/static_root/inc/illumi_footer.jsp" %>
		<!-- 하단영역 끝 -->
	</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
if("HTTP/1.1".equals(request.getProtocol())) {
	response.setHeader ("Cache-Control", "no-cache, no-store, must-revalidate");
} else {
	response.setHeader ("Pragma", "no-cache");
}
response.setDateHeader ("Expires", 0);
%>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta name="title" content="애니멀허그 - 관리자" />
<meta name="description" content="애니멀허그 - 관리자 설명" />
<meta name="keywords" content="애니멀허그 - 관리자 키워드" />
<meta name="robots" content="index, follow">
<link rel="canonical" href="http://www.miracom.co.kr">
<meta property="og:type" content="article" />
<meta property="og:site_name" content="애니멀허그 - 관리자">
<meta property="og:type" content="article">
<meta property="og:url" content="http://www.miracom.co.kr">
<meta property="og:title" content="애니멀허그 - 관리자">
<meta property="og:image" content="/static_root/images/common/meta_img.jpg">
<meta property="og:description" content="애니멀허그 - 관리자 설명" />
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
<title>애니멀허그 - 관리자</title>
<link href="/static_root/css/admin.css" rel="stylesheet">
<link href="/static_root/css/development.css" rel="stylesheet">
<link rel="shortcut icon" href="/static_root/images/common/favicon.ico">
<!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->

<%@ taglib uri="http://java.sun.com/jstl/core_rt"        prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"        prefix="fmt" %>
<%@ taglib tagdir="/WEB-INF/tags" 						 prefix="uTld" %>


<script src="/static_root/js/jquery-1.12.3.js"></script>
<script src="/static_root/js/jquery-ui.js"></script>
<script src="/static_root/js/jquery-ui-timepicker.js"></script>
<script src="/static_root/js/jqueryPaging.js"></script>
<script src="/static_root/js/datepicker-ko.js"></script>
<script src="/static_root/js/bootstrap.js"></script>
<script src="/static_root/js/easing.js"></script>
<script src="/static_root/js/cssmenu.js"></script>

<script src="/static_root/js/admin.js"></script>
<script src="/static_root/js/slick.js"></script>
<script src="/static_root/js/common.js"></script>
<script src="/static_root/js/crosscover.js"></script>


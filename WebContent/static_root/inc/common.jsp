<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt"        prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"        prefix="fmt" %>
<%@ taglib tagdir="/WEB-INF/tags" 						 prefix="uTld" %>
<%@ page import="animal.framework.util.MessageUtil" %>
<%
	String COMMON_JS_CONF = MessageUtil.getMessage("COMMON_JS_CONF");						// 사용자 JS 경로
	
	String COMMON_IMAGES_CONF = MessageUtil.getMessage("COMMON_IMAGES_CONF");				// 사용자 이미지 경로
	String COMMON_CSS_CONF = MessageUtil.getMessage("COMMON_CSS_CONF");				// 사용자 CSS 경로
	String COMMON_INC_CONF = MessageUtil.getMessage("COMMON_INC_CONF");						// 사용자 공통 JSP 경로
	String UPLOAD_FILE = MessageUtil.getMessage("UPLOAD.FILE");				// 에디터 경로

	String STATIC_ROOT = MessageUtil.getMessage("STATIC.ROOT");				// STATIC_ROOT 경로
	System.out.print(STATIC_ROOT);
 %>
 <c:set var="COMMON_JS_CONF" value="<%=COMMON_JS_CONF %>" />
 	
<c:set var="COMMON_IMAGES_CONF" value="<%=COMMON_IMAGES_CONF %>" />
<c:set var="COMMON_CSS_CONF" value="<%=COMMON_CSS_CONF %>" />
<c:set var="COMMON_INC_CONF" value="<%=COMMON_INC_CONF %>" />
<c:set var="UPLOAD_FILE" value="<%=UPLOAD_FILE %>" />

<c:set var="STATIC_ROOT" value="<%=STATIC_ROOT %>" />
<script language="javascript">
var COMMON_JS_CONF = "<%=COMMON_JS_CONF%>";						// 사용자 JS 경로

var COMMON_IMAGES_CONF = "<%=COMMON_IMAGES_CONF%>";				// 사용자 이미지 경로 
var COMMON_CSS_CONF = "<%=COMMON_CSS_CONF%>";						// 사용자 CSS 경로  
var COMMON_INC_CONF = "<%=COMMON_INC_CONF%>";						// 사용자 공통 JSP 경로
var UPLOAD_FILE = "<%=UPLOAD_FILE%>";			// 에디터 경로

var STATIC_ROOT = "<%=STATIC_ROOT%>";			// STATIC_ROOT 경로
</script>
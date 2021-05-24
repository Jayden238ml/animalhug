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
	<meta name="title" content="건의사항" />
	<meta name="description" content="커뮤니티 건의사항" />
	<meta name="keywords" content="animalhug,애니멀허그,유기견,유기견입양,커뮤니티" />
	<meta name="robots" content="index, follow">
	<link rel="canonical" href="http://www.animalhug.co.kr">
	<meta property="og:type" content="article" />
	<meta property="og:site_name" content="애니멀허그">
	<meta property="og:type" content="article">
	<meta property="og:url" content="http://www.animalhug.co.kr">
	<meta property="og:title" content="유기동물 | 커뮤니티 | 애니멀허그">
	<meta property="og:image" content="/static_root/images/common/meta_img.jpg">
	<meta property="og:description" content="건의사항 " />
	
<title>애니멀허그 | 커뮤니티 | 건의사항</title>
	<%@ include file="/static_root/inc/head.jsp" %>
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
	<!-- include summernote css/js-->
	<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.2/summernote.css" rel="stylesheet">
	<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.2/summernote.js"></script>
	
	<script src="/static_root/dist/lang/summernote-ko-KR.js"></script>
<script type="text/javascript">
	
	$(document).ready(function(){
		$('#summernote').summernote({
            height: 300,                 
            minHeight: null,             
            maxHeight: null,             
            focus: true ,                
            lang:'ko-KR',
            toolbar: [
                      // [groupName, [list of button]]
                      ['Font Style', ['fontname']],
                      ['style', ['bold', 'italic', 'underline']],
                      ['color', ['color']],
                      ['font', ['strikethrough']],
                      ['fontsize', ['fontsize']],
                      ['para', ['paragraph']],
                      ['height', ['height']],
                      ['Insert', ['picture']],
                      ['Insert', ['link']]
//                       ['Misc', ['fullscreen']]
                   ],
            callbacks: {
                onImageUpload: function(files, editor, welEditable) {
                  for (var i = files.length - 1; i >= 0; i--) {
                    sendFile(files[i], this);
                  }
                }
              }
    	});
	});
	
	function sendFile(file, el) {
	      var form_data = new FormData();
	      form_data.append('file', file);
	      $.ajax({
	        data: form_data,
	        type: "POST",
	        url: '/common/swfUpload.do',
	        cache: false,
	        contentType: false,
	        enctype: 'multipart/form-data',
	        processData: false,
	        success: function(transport) {
	        	var obj = transport.jobj
	        	var url = "";
	        	if(obj != null){
	        		$.each(obj,function(key,value) {
		        		if(key == "url"){
		        			url = value;
		        		}
		        	});
		          $(el).summernote('editor.insertImage', url);
	        	}
	        }
	      });
	      $('#ATTACH_YN').val("Y");
	    }
	
	function fnList(){
		$('#boardFrm').attr("action", "/user/Board/story.do").submit();
	}
	
	function fnReg(msg){
		
		if(confirm(msg + "하시겠습니까?")){
			$.ajax({
				 type		: "POST"
				,url		: "/user/qnaBoardInsert.do"
				,dataType	: "json"
				,data		: $("#boardFrm").serialize()
				,success : function(transport) {
					
					if(transport.ERROR_CD == "999"){
						alert(msg + " 중 에러가 발생하였습니다. 관리자에게 문의 바랍니다.");
						return;
					}else{
						alert(msg + "되었습니다.");
						$('#boardFrm').attr("action", "/user/Board/story.do").submit();
					}
				}
			});
		}
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
						
			<!-- 로그인 정보등록 -->
			<form name="boardFrm" id="boardFrm" role="form" method="post" action="#" >
			<input type="hidden" name="ATTACH_YN" id="ATTACH_YN" value="">
			<input type="hidden" name="QNA_SEQ" id="QNA_SEQ" value="<c:out value='${INIT_DATA.QNA_SEQ}' />">
			<%@ include file="/static_root/inc/mid.jsp" %>
			<br/>
				<fieldset>
<!-- 						<legend>게시판</legend> -->
					<div class="member-write">
						<ul>
							<li>
								<div><input type="text" name="TITLE" id="TITLE" title="제목" maxlength="100" class="form-control w100p" placeholder="제목" value="<c:out value='${INIT_DATA.detail.TITLE}' />"/></div>
							</li>
							<li>
								<div>
									<textarea class="form-control" id="summernote" name="CONTENTS" placeholder="content" maxlength="140" rows="7">${fn:replace(INIT_DATA.CONTENT, newLineChar, '<br />')}</textarea>
								</div>
							</li>
						</ul>
						<p>
							<c:if test="${INIT_DATA.QNA_SEQ eq ''}">
								<a href="javascript:fnReg('등록');" class="btn btn-danger btn-lg w200"><i class="fa fa-address-card-o" aria-hidden="true"></i> 등록</a> &nbsp; &nbsp;								
							</c:if>
							<c:if test="${INIT_DATA.QNA_SEQ ne ''}">
								<a href="javascript:fnReg('수정');" class="btn btn-danger btn-lg w200"><i class="fa fa-address-card-o" aria-hidden="true"></i> 수정</a> &nbsp; &nbsp;								
							</c:if>
							<a href="javascript:fnList();" class="btn btn-secondary btn-lg w200"><i class="fa fa-ban" aria-hidden="true"></i> 취소</a>
						</p>
					</div>
				</fieldset>
			</form>
			<!-- 로그인 정보등록 끝 -->
		</div>
		<!-- 본문영역 끝 -->

		<!-- 하단영역 -->
		<%@ include file="/static_root/inc/footer.jsp" %>
		<!-- 하단영역 끝 -->
	</div>
</body>
</html>
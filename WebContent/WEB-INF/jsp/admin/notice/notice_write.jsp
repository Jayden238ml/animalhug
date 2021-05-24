<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/static_root/inc/admin_head.jsp" %>

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.2/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.2/summernote.js"></script>
<script src="/static_root/dist/lang/summernote-ko-KR.js"></script>
		
<script type="text/javascript">
	var idx = 0;
	var bd_no = "";
	$(document).ready(function(){
		$('#summernote').summernote({
			placeholder: '',
			height: 300,                 
            minHeight: null,             
            maxHeight: null,             
            focus: true ,                
            lang:'ko-KR',
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
	     	var url = transport.FILE_PATH + transport.TRANS_FILE_NM;
	        $(el).summernote('editor.insertImage', url);
//	          $('#imageBoard > ul').append('<li><img src="'+url+'" width="480" height="auto"/></li>');
	      }
	      });
	}
	
	function fnReg(){
		$('textarea[name="CONTENTS"]').val($('#summernote').summernote('code'));
		if(confirm("저장할거임 ?")){
			$.ajax({
				 type		: "POST"
				,url		: "/admin/notice/notice_inserte.do"
				,dataType	: "json"
				,data		: $("#frm").serialize()
				,success : function(transport) {
					if(transport.ERROR_CD == "999"){
						alert("에러났음");
						return;
					}else{
						alert("OK");
						fnReturn();
					}
					
				}
			});
		}
	}
	
	function fnReturn(){
		$('#frm').attr("action", "/admin/Bd/saBdList.do");
		$('#frm').submit();
	}
	
</script>
</head>
	<body>
		<div id="wrap">
			
		<!-- 상단영역 -->
		<%@ include file="/static_root/inc/admin_header.jsp" %>
		<!-- 상단영역 끝 -->


		<!-- 좌측영역 -->
		<%@ include file="/static_root/inc/admin_lnb.jsp" %>
		<!-- 좌측영역 끝 -->


		<!-- 본문영역 -->
		<div id="content">
		
		<!-- 타이틀/네비 -->
		<dl class="title-navi">
			<dt>공지사항 등록</dt>
			<dd>
				<i class="fa fa-home" aria-hidden="true"></i></i> 홈 > 관리자 > <span>공지사항등록</span>
			</dd>
		</dl>
		<!-- 타이틀/네비 -->
		
		<form name="frm"  id="frm" method="post" action="">
			
		<!-- 본문영역 ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
			<div>
			
				<!-- 등록 -->
				<fieldset>
					<legend>게시물 등록</legend>
					<div class="write-table-box">
						<table cellpadding="0" cellspacing="0" summary="게시물 등록">
							<caption>게시물 등록</caption>
							<colgroup>
								<col width="15%" />
								<col width="*" />
							</colgroup>
							<tbody>
								<tr>
									<th>제목</th>
									<td>
										<input type="text" name="TITLE" title="제목" class="form-control w100p" value="" placeholder="제목을 입력하세요." required/>
									</td>
								</tr>
								<tr>
									<th>게시판타입</th>
									<td>
										<select name="BOARD_TYPE" id="BOARD_TYPE">
											<option value="1">자유게시판</option>
											<option value="2">찾아주세요</option>
										</select>
									</td>
								</tr>
								<tr>
									<th>게시여부</th>
									<td>
										<select name="OPEN_YN" id="OPEN_YN">
											<option value="Y">게시</option>
											<option value="N">미게시</option>
										</select>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<textarea name="CONTENTS" id="CONTENTS" value="" style="display:none;" ></textarea>
										<div id="summernote"></div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="text-center mt30">
						<a href="javascript:fnReg();" class="btn btn-danger w150"><i class="fa fa-pencil-square-o" aria-hidden="true"></i> 등록</a>
						<a href="javascript:fnReturn();" class="btn btn-secondary w150"><i class="fa fa-list-ul" aria-hidden="true"></i> 목록</a>
					</div>
				</fieldset>
				<!-- 등록 끝 -->
			
			</div>
		<!-- 본문영역 끝 ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
		</form>
			<!-- 본문영역 끝 -->
			
		</div>
		
		<!-- 하단영역 -->
		<%@ include file="/static_root/inc/admin_footer.jsp" %>
		<!-- 하단영역 끝 -->
		</div>
	</body>
</html>
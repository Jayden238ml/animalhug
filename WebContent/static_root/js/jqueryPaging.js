(function($) {

    $.fn.magefister4jPaging = function(options) {
    	
    	var opts = $.extend({},$.fn.magefister4jPaging.defaults,options);

        var original = this;

        var action = {

            init : function() {
        	
            	var firstClass 	= '1';
	        	var backClass 	= '2';
	        	var nextClass 	= '3';
	        	var endClass 	= '4';	
	        	
	        	var totalPage     = Math.ceil(opts.totalSize/opts.pageSize);

                var startPageList  = 1;
                var finishPageList = opts.pageListSize;
                
                var prePage  = ((opts.pageNo - 1) > 1 )?(opts.pageNo - 1):1;
                var nextPage = ((parseInt(opts.pageNo)+1) < totalPage )?(parseInt(opts.pageNo)+1):totalPage;
                
                var innerHTML = "";
                
                //innerHTML += action.getPageItemLink(1, '<img src="'+COMMON_IMAGES_CONF+'/btnIcn/btn_prev10.gif" alt="이전10페이지" title="이전10페이지" />', firstClass);
                
                if(prePage == opts.pageNo){
                	innerHTML += '<a href="javascript:;"><i class="ion-arrow-left-b"></i></a>\n';
                }else{
                	innerHTML += action.getPageItemLink(prePage, '<i class="ion-arrow-left-b"></i>', backClass);
                }
                
                
                if(opts.pageNo > finishPageList){                	
                	startPageList  = opts.pageListSize*(Math.floor((opts.pageNo-1)/opts.pageListSize))+1;
                	finishPageList = parseInt(startPageList) + parseInt(finishPageList) -1;
                }
                
                if(finishPageList > totalPage){
                	finishPageList = totalPage;
                }               
               
                if(finishPageList ==0) {
                	finishPageList =1;
                }
                for (var i = startPageList; i <= finishPageList; i++) {
                    innerHTML += action.getNumberLink(i, null, finishPageList );
                }
                
                //innerHTML += action.getPageItemLink(nextPage, '<i class="ion-arrow-right-b"></i>', nextClass);
                //innerHTML += action.getPageItemLink(totalPage, '<img src="'+COMMON_IMAGES_CONF+'/btnIcn/btn_next10.gif" alt="이전10페이지" title="이전10페이지" />', endClass);
                
                if(nextPage == opts.pageNo){
                	innerHTML += '<a href="javascript:;"><i class="ion-arrow-right-b"></i></a>\n';
                }else{
                	innerHTML += action.getPageItemLink(nextPage, '<i class="ion-arrow-right-b"></i>', nextClass);
                }

                $(original).html(innerHTML);

                if(opts.countTextObj != 'undefined' && opts.countTextObj != ''){
					$('#' + opts.countTextObj).html(action.getPageCount(totalPage));
				}
            },

            getNumberLink : function(pageNo, text, finishPageList) {
            	var returnTxt = "";
            	
            	if(pageNo == opts.pageNo){
            		returnTxt = '<a href="javascript:'+opts.pageClickFunctionName+'(' + pageNo + ')" class="active">' +         			
        			((text != null && text != '')? text: pageNo) + 
        			'</a>\n';            		
            	}else{
            		returnTxt = '<a href="javascript:'+opts.pageClickFunctionName+'(' + pageNo + ')">' + 
        			((text != null && text != '')? text: pageNo) + 
        			'</a>\n';            		
            	}
            	
            	//if(pageNo !=  finishPageList) returnTxt += " / ";
            	
            	return  returnTxt;
            },

            getPageItemLink : function(pageNo, text, className) {
            	var rtnHtml =  '<a href="javascript:'+opts.pageClickFunctionName+'(' + pageNo + ')">' +
                    	((text != null && text != '')? text: pageNo) +
                    	'</a>\n';
            	//if(className == "1") rtnHtml += "&nbsp;";
            	//if(className == "2") rtnHtml += "&nbsp;&nbsp;&nbsp;&nbsp;";
            	//if(className == "3") rtnHtml = "&nbsp;" + rtnHtml;
            	//if(className == "4") rtnHtml = "&nbsp;" + rtnHtml;
            	return rtnHtml;
            },

            getPageCount : function(totalPage) {
            	var rtnHtml = '';
            	if(opts.countTextFormat != 'undefined' && opts.countTextFormat != ''){
            		try{
						rtnHtml = opts.countTextFormat;
		
						rtnHtml = rtnHtml.replace('#TC#' , opts.totalSize);
						rtnHtml = rtnHtml.replace('#CP#' , opts.pageNo);
						rtnHtml = rtnHtml.replace('#PC#' , totalPage);
            		}catch(e){}
            	}

				return rtnHtml;
			}

        };
        
        action.init();
    };

    $.fn.magefister4jPaging.defaults = {
        totalSize    : 0,      // total size
        pageNo       : 1,      // current page No
        pageSize     : 10,     // list per page count
        pageListSize : 10,     // page bar count 1 2 3 4 5
        pageClickFunctionName : 'page_click',
        showUnlinkedSymbols   : true
    };
    
    $.fn.magefister4jPagingM = function(options) {
    	var opts = $.extend({},$.fn.magefister4jPaging.defaults,options);

        var original = this;

        var action = {

            init : function() {
        	
	        	var firstClass 	= 'btn_first';
	        	var backClass 	= 'btn_prev';
	        	var nextClass 	= 'btn_next';
	        	var endClass 	= 'btn_last';	
	        	
	        	var totalPage     = Math.ceil(opts.totalSize/opts.pageSize);
	        	
	        	var backimage 	= '<img src="/static_root/images/btnIcn/btn_prev.gif" alt="이전"  />';
	        	var nextimage 	= '<img src="/static_root/images/btnIcn/btn_next.gif" alt="다음" />';
	        	var backimage10 	= '<img src="/static_root/images/btnIcn/btn_prev10.gif" alt="이전10"  />';
	        	var nextimage10 	= '<img src="/static_root/images/btnIcn/btn_next10.gif" alt="다음10" />';

                var startPageList  = 1;
                var finishPageList = opts.pageListSize;
                
                var prePage  = ((opts.pageNo - 1) > 1 )?(opts.pageNo - 1):1;
                var nextPage = ((parseInt(opts.pageNo)+1) < totalPage )?(parseInt(opts.pageNo)+1):totalPage;
                
                var innerHTML = "";
                
                innerHTML += action.getPageItemLink(1, backimage10, firstClass);
                innerHTML += action.getPageItemLink(prePage, backimage, backClass);
                
                if(opts.pageNo > finishPageList){                	
                	startPageList  = opts.pageListSize*(Math.floor((opts.pageNo-1)/opts.pageListSize))+1;
                	finishPageList = parseInt(startPageList) + parseInt(finishPageList) -1;
                }
                
                if(finishPageList > totalPage){
                	finishPageList = totalPage;
                }               
               
                
                for (var i = startPageList; i <= finishPageList; i++) {
                    innerHTML += action.getNumberLink(i, null, finishPageList );
                }
                
                innerHTML += action.getPageItemLink(nextPage, nextimage, nextClass);
                innerHTML += action.getPageItemLink(totalPage, nextimage10, endClass);
                
                $(original).html(innerHTML);
            },

            getNumberLink : function(pageNo, text, finishPageList) {
            	var returnTxt = "";
            	if(pageNo == opts.pageNo){
            		returnTxt = '<a href="javascript:'+opts.pageClickFunctionName+'(' + pageNo + ')"><span class="on">' +         			
        			((text != null && text != '')? text: pageNo) + 
        			'</span></a>';            		
            	}else{
            		returnTxt = '<a href="javascript:'+opts.pageClickFunctionName+'(' + pageNo + ')"><span>' + 
        			((text != null && text != '')? text: pageNo) + 
        			'</span></a>';            		
            	}
            	
            	return  returnTxt;
            },

            getPageItemLink : function(pageNo, text, className) {
            	return  '<a class="'+className+'" href="javascript:'+opts.pageClickFunctionName+'(' + pageNo + ')">' +
                    	((text != null && text != '')? text: pageNo) +
                    	'</a>';
            }

        };
        
        action.init();
    };
    
    $.fn.magefister4jPagingM.defaults = {
        totalSize    : 0,      // total size
        pageNo       : 1,      // current page No
        pageSize     : 5,     // list per page count
        pageListSize : 5,     // page bar count 1 2 3 4 5
        pageClickFunctionName : 'page_click',
        showUnlinkedSymbols   : true
    };

})(jQuery);

//페이징
function fncMakePageBody(total_size,cur_page_no,page_list_Size){
	if(page_list_Size == null && page_list_Size == ""){
		page_list_Size = 10;
	}

	var pagingParam = {
	    'totalSize'   : total_size, 
	    'pageNo'      : cur_page_no,
	    'pageSize'    : PAGE_SIZE,
	    'pageListSize': page_list_Size, 
	    'pageClickFunctionName': 'page_List',
	    'showUnlinkedSymbols' : false,
	    'countTextObj' : 'totalCnt',
        'countTextFormat' : '총 <strong>#TC#</strong> 개 / &nbsp;현재페이지 : <strong>[#CP#/#PC#]</strong>'
	};
	
	$(document).ready(function(){ 			
		$("#paging_bar").magefister4jPaging(pagingParam);
	});
}

function fncMakePageBody2(total_size,cur_page_no,page_list_Size){
	if(page_list_Size == null && page_list_Size == ""){
		page_list_Size = 10;
	}

	var pagingParam = {
	    'totalSize'   : total_size, 
	    'pageNo'      : cur_page_no,
	    'pageSize'    : PAGE_SIZE,
	    'pageListSize': page_list_Size, 
	    'pageClickFunctionName': 'page_List2',
	    'showUnlinkedSymbols' : false,
	    'countTextObj' : 'totalCnt',
        'countTextFormat' : '총 <strong>#TC#</strong> 개 / &nbsp;현재페이지 : <strong>[#CP#/#PC#]</strong>'
	};
	
	$(document).ready(function(){ 			
		$("#paging_bar2").magefister4jPaging(pagingParam);
	});
}

function fncMakePageBody3(total_size,cur_page_no,page_list_Size){
	if(page_list_Size == null && page_list_Size == ""){
		page_list_Size = 10;
	}

	var pagingParam = {
	    'totalSize'   : total_size, 
	    'pageNo'      : cur_page_no,
	    'pageSize'    : PAGE_SIZE,
	    'pageListSize': page_list_Size, 
	    'pageClickFunctionName': 'page_List3',
	    'showUnlinkedSymbols' : false,
	    'countTextObj' : 'totalCnt',
        'countTextFormat' : '총 <strong>#TC#</strong> 개 / &nbsp;현재페이지 : <strong>[#CP#/#PC#]</strong>'
	};
	
	$(document).ready(function(){ 			
		$("#paging_bar3").magefister4jPaging(pagingParam);
	});
}

//페이징
function fncMakePageBodyM(total_size,cur_page_no){
	var pagingParam = {
	    'totalSize'   : total_size, 
	    'pageNo'      : cur_page_no,
	    'pageSize'    : PAGE_SIZE,
	    'pageListSize': PAGE_SIZE, 
	    'pageClickFunctionName': 'page_List',
	    'showUnlinkedSymbols' : false
	};
	
	$(document).ready(function(){ 			
		$("#paging_bar").magefister4jPagingM(pagingParam);
	});
}	

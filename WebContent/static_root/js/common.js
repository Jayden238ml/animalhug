$(document).ready(function() {
	// 상단서브메뉴 //
	$('#menuArea').mouseenter(function(){ 
		$('#subMenuArea').css('display','block');
	});
	$('#subMenuArea').mouseleave(function(){ 
		$('#subMenuArea').css('display','none');
	});


	// 모바일 전체메뉴 //
	var mobileLnbChk = 0;
	$('#mobileLnbOpen').click(function(){ 
		if (mobileLnbChk == 0) {
			$('#header-mobile .hm-total').animate({ marginLeft : '0' }, 350, 'easeOutQuad');
			//$(this).removeClass('ion-android-menu').addClass('ion-android-close');
			mobileLnbChk = 1;
		} else {
			$('#header-mobile .hm-total').animate({ marginLeft : '-100%' }, 350, 'easeOutQuad');
			//$(this).removeClass('ion-android-close').addClass('ion-android-menu');
			mobileLnbChk = 0;
		}
	});
	$('#mobileLnbClose').click(function(){ 
		$('#header-mobile .hm-total').animate({ marginLeft : '-100%' }, 350, 'easeOutQuad');
		//$('.ion-android-close').removeClass('ion-android-close').addClass('ion-android-menu');
		mobileLnbChk = 0;
	});


	// 상단 - 언어변경 //
	$('#flagChk').click(function(){ 
		$('#flagSelect').slideDown(400, 'easeOutQuad');
	});
	$('#flagSelect').mouseleave(function() { 
		$('#flagSelect').slideUp(200, 'easeOutQuad');
	}); 


	 // 메인 비주얼 //
	/*
	$('.main-visual .crosscover').crosscover({
		controller: true,
		dotNav: true
	});
	*/

	// 메인 아래로 이동버튼 //
	/*
	$('.crosscover-island > p').click(function(){ 
		$('html, body').animate({ scrollTop : $(window).height()-270 }, 900, 'easeOutQuad');
	});
	*/
	
	
	// 메인 - 비주얼 //
	$('.main-visual-slick').slick({
		infinite: true,
		slidesToShow: 1,
		adaptiveHeight: true,
		autoplay: true,
		autoplaySpeed: 5000,
		prevArrow: '<button class="slick-prev" aria-label="Previous" type="button"><i class="xi-angle-left-thin"></i></button>',
		nextArrow: '<button class="slick-next" aria-label="Next" type="button"><i class="xi-angle-right-thin"></i></button>'
	});


	// 메인 - 사업영역 //
	$('.main-business li').hover(function (event) {
		$(this).find('p img').stop().animate({ width : '105%', margin : '-2.5% 0 0 -2.5%', opacity: '0.3' }, 300, 'easeOutQuad');
		$(this).find('a').stop().animate({ opacity: '1.0' }, 300, 'easeOutQuad');
	}, function (event) {
		$(this).find('p img').stop().animate({ width : '100%', margin : '0', opacity: '1.0' }, 300, 'easeOutQuad');
		$(this).find('a').stop().animate({ opacity: '0.0' }, 300, 'easeOutQuad');
	});


	// 메인 - 미라콤 소식 //
	$('.main-news ul li').hover(function (event) {
		$(this).find('p img').stop().animate({ width : '105%', margin : '-2.5% 0 0 -2.5%', opacity: '0.5' }, 300, 'easeOutQuad');
	}, function (event) {
		$(this).find('p img').stop().animate({ width : '100%', margin : '0', opacity: '1' }, 300, 'easeOutQuad');
	});
	
	
	// 오버링 소개 - 2단 //
	$('.offering-about-second > li').eq(0).stop().animate({ width : '69.9%', padding : '160px 30px 0 30px' }, 750, 'easeOutQuad');
	$('.offering-about-second > li').eq(0).find('div').stop().animate({ opacity: '1' }, 750, 'easeOutQuad');
	$('.offering-about-second > li').eq(1).stop().animate({ width : '30%', padding : '200px 30px 0 30px'  }, 750, 'easeOutQuad');
	$('.offering-about-second > li').eq(1).find('div').stop().animate({ opacity: '0' }, 750, 'easeOutQuad');
	
	$('.offering-about-second > li').each(function (index) {
		$('.offering-about-second > li').eq(index).hover(function (event) {
			if (index == 0){
				$('.offering-about-second > li').eq(0).stop().animate({ width : '69.9%', padding : '160px 30px 0 30px' }, 750, 'easeOutQuad');
				$('.offering-about-second > li').eq(0).find('div').stop().animate({ opacity: '1' }, 750, 'easeOutQuad');
				$('.offering-about-second > li').eq(1).stop().animate({ width : '30%', padding : '200px 30px 0 30px'  }, 750, 'easeOutQuad');
				$('.offering-about-second > li').eq(1).find('div').stop().animate({ opacity: '0' }, 750, 'easeOutQuad');
			} else if (index == 1){
				$('.offering-about-second > li').eq(0).stop().animate({ width : '30%', padding : '200px 30px 0 30px' }, 750, 'easeOutQuad');
				$('.offering-about-second > li').eq(0).find('div').stop().animate({ opacity: '0' }, 750, 'easeOutQuad');
				$('.offering-about-second > li').eq(1).stop().animate({ width : '69.9%', padding : '160px 30px 0 30px' }, 750, 'easeOutQuad');
				$('.offering-about-second > li').eq(1).find('div').stop().animate({ opacity: '1' }, 750, 'easeOutQuad');
			}
		});
	});
	
	
	// 오버링 소개 - 3단 //
	$('.offering-about-third > li').eq(0).stop().animate({ width : '49.9%', padding : '160px 30px 0 30px' }, 750, 'easeOutQuad');
	$('.offering-about-third > li').eq(0).find('div').stop().animate({ opacity: '1' }, 750, 'easeOutQuad');
	$('.offering-about-third > li').eq(1).stop().animate({ width : '25%', padding : '200px 30px 0 30px'  }, 750, 'easeOutQuad');
	$('.offering-about-third > li').eq(1).find('div').stop().animate({ opacity: '0' }, 750, 'easeOutQuad');
	$('.offering-about-third > li').eq(2).stop().animate({ width : '25%', padding : '200px 30px 0 30px'  }, 750, 'easeOutQuad');
	$('.offering-about-third > li').eq(2).find('div').stop().animate({ opacity: '0' }, 750, 'easeOutQuad');
	
	$('.oat-cloud > li').eq(0).stop().animate({ width : '49.9%', padding : '130px 30px 0 30px' }, 750, 'easeOutQuad');
	$('.oat-cloud > li').eq(0).find('div').stop().animate({ opacity: '1' }, 750, 'easeOutQuad');
	$('.oat-cloud > li').eq(1).stop().animate({ width : '25%', padding : '170px 30px 0 30px'  }, 750, 'easeOutQuad');
	$('.oat-cloud > li').eq(1).find('div').stop().animate({ opacity: '0' }, 750, 'easeOutQuad');
	$('.oat-cloud > li').eq(2).stop().animate({ width : '25%', padding : '170px 30px 0 30px'  }, 750, 'easeOutQuad');
	$('.oat-cloud > li').eq(2).find('div').stop().animate({ opacity: '0' }, 750, 'easeOutQuad');
	
	$('.offering-about-third > li').each(function (index) {
		$('.offering-about-third > li').eq(index).hover(function (event) {
			if (index == 0){
				$('.offering-about-third > li').eq(0).stop().animate({ width : '49.9%', padding : '160px 30px 0 30px' }, 750, 'easeOutQuad');
				$('.offering-about-third > li').eq(0).find('div').stop().animate({ opacity: '1' }, 750, 'easeOutQuad');
				$('.offering-about-third > li').eq(1).stop().animate({ width : '25%', padding : '200px 30px 0 30px'  }, 750, 'easeOutQuad');
				$('.offering-about-third > li').eq(1).find('div').stop().animate({ opacity: '0' }, 750, 'easeOutQuad');
				$('.offering-about-third > li').eq(2).stop().animate({ width : '25%', padding : '200px 30px 0 30px'  }, 750, 'easeOutQuad');
				$('.offering-about-third > li').eq(2).find('div').stop().animate({ opacity: '0' }, 750, 'easeOutQuad');
			} else if (index == 1){
				$('.offering-about-third > li').eq(0).stop().animate({ width : '25%', padding : '200px 30px 0 30px' }, 750, 'easeOutQuad');
				$('.offering-about-third > li').eq(0).find('div').stop().animate({ opacity: '0' }, 750, 'easeOutQuad');
				$('.offering-about-third > li').eq(1).stop().animate({ width : '49.9%', padding : '160px 30px 0 30px' }, 750, 'easeOutQuad');
				$('.offering-about-third > li').eq(1).find('div').stop().animate({ opacity: '1' }, 750, 'easeOutQuad');
				$('.offering-about-third > li').eq(2).stop().animate({ width : '25%', padding : '200px 30px 0 30px' }, 750, 'easeOutQuad');
				$('.offering-about-third > li').eq(2).find('div').stop().animate({ opacity: '0' }, 750, 'easeOutQuad');
			} else if (index == 2){
				$('.offering-about-third > li').eq(0).stop().animate({ width : '25%', padding : '200px 30px 0 30px' }, 750, 'easeOutQuad');
				$('.offering-about-third > li').eq(0).find('div').stop().animate({ opacity: '0' }, 750, 'easeOutQuad');
				$('.offering-about-third > li').eq(1).stop().animate({ width : '25%', padding : '200px 30px 0 30px' }, 750, 'easeOutQuad');
				$('.offering-about-third > li').eq(1).find('div').stop().animate({ opacity: '0' }, 750, 'easeOutQuad');
				$('.offering-about-third > li').eq(2).stop().animate({ width : '49.9%', padding : '160px 30px 0 30px' }, 750, 'easeOutQuad');
				$('.offering-about-third > li').eq(2).find('div').stop().animate({ opacity: '1' }, 750, 'easeOutQuad');
			}
			
			if (index == 0){
				$('.oat-cloud > li').eq(0).stop().animate({ width : '49.9%', padding : '130px 30px 0 30px' }, 750, 'easeOutQuad');
				$('.oat-cloud > li').eq(0).find('div').stop().animate({ opacity: '1' }, 750, 'easeOutQuad');
				$('.oat-cloud > li').eq(1).stop().animate({ width : '25%', padding : '170px 30px 0 30px'  }, 750, 'easeOutQuad');
				$('.oat-cloud > li').eq(1).find('div').stop().animate({ opacity: '0' }, 750, 'easeOutQuad');
				$('.oat-cloud > li').eq(2).stop().animate({ width : '25%', padding : '170px 30px 0 30px'  }, 750, 'easeOutQuad');
				$('.oat-cloud > li').eq(2).find('div').stop().animate({ opacity: '0' }, 750, 'easeOutQuad');
			} else if (index == 1){
				$('.oat-cloud > li').eq(0).stop().animate({ width : '25%', padding : '170px 30px 0 30px' }, 750, 'easeOutQuad');
				$('.oat-cloud > li').eq(0).find('div').stop().animate({ opacity: '0' }, 750, 'easeOutQuad');
				$('.oat-cloud > li').eq(1).stop().animate({ width : '49.9%', padding : '130px 30px 0 30px' }, 750, 'easeOutQuad');
				$('.oat-cloud > li').eq(1).find('div').stop().animate({ opacity: '1' }, 750, 'easeOutQuad');
				$('.oat-cloud > li').eq(2).stop().animate({ width : '25%', padding : '170px 30px 0 30px' }, 750, 'easeOutQuad');
				$('.oat-cloud > li').eq(2).find('div').stop().animate({ opacity: '0' }, 750, 'easeOutQuad');
			} else if (index == 2){
				$('.oat-cloud > li').eq(0).stop().animate({ width : '25%', padding : '170px 30px 0 30px' }, 750, 'easeOutQuad');
				$('.oat-cloud > li').eq(0).find('div').stop().animate({ opacity: '0' }, 750, 'easeOutQuad');
				$('.oat-cloud > li').eq(1).stop().animate({ width : '25%', padding : '170px 30px 0 30px' }, 750, 'easeOutQuad');
				$('.oat-cloud > li').eq(1).find('div').stop().animate({ opacity: '0' }, 750, 'easeOutQuad');
				$('.oat-cloud > li').eq(2).stop().animate({ width : '49.9%', padding : '130px 30px 0 30px' }, 750, 'easeOutQuad');
				$('.oat-cloud > li').eq(2).find('div').stop().animate({ opacity: '1' }, 750, 'easeOutQuad');
			}
		});
	});
	
	
	// 특징 //
	$(".service-character").slick({
		vertical: true,
		slidesToShow: 1,
		slidesToScroll: 1,
		autoplay: true,
		autoplaySpeed: 3000,
		arrows: false,
		dots: true,
		verticalSwiping: true
	});
	
	
	// 구축사례 //
	$('.slider-for').slick({
		slidesToShow: 1,
		slidesToScroll: 1,
		arrows: false,
		fade: true,
		asNavFor: '.slider-nav'
	});
	$('.slider-nav').slick({
		slidesToShow: 1,
		slidesToScroll: 1,
		asNavFor: '.slider-for',
		dots: true,
		centerMode: true,
		centerPadding: '30%',
		focusOnSelect: true,
		prevArrow: '<button class="slick-prev" aria-label="Previous" type="button"><i class="xi-angle-left-thin"></i></button>',
		nextArrow: '<button class="slick-next" aria-label="Next" type="button"><i class="xi-angle-right-thin"></i></button>',
		responsive: [
		{
		  breakpoint: 991,
		  settings: {
			slidesToShow: 1
		  }
		},
		{
		  breakpoint: 767,
		  settings: {
			slidesToShow: 1,
			centerPadding: '0'
		  }
		},
		{
		  breakpoint: 479,
		  settings: {
			//arrows: false,
			slidesToShow: 1,
			centerPadding: '0'
		  }
		}
	  ]
	});


	// 윤리경영 - 경영원칙 //
	$('.ethical-rule > div').each(function (index) {
		var rdChk = 0+String(index);
		$('.ethical-rule > div').eq(index).click(function(){ 
			if (rdChk == 0+String(index)) {
				$('.ethical-rule > div > div').eq(index).slideDown(300, 'easeOutQuad');
				$('.ethical-rule > div').eq(index).find('i').addClass('xi-minus-min');
				rdChk = 1+String(index);
			} else {
				$('.ethical-rule > div > div').eq(index).slideUp(300, 'easeOutQuad');
				$('.ethical-rule > div').eq(index).find('i').removeClass('xi-minus-min');
				$('.ethical-rule > div').eq(index).find('i').addClass('xi-plus-min');
				rdChk = 0+String(index);
			}
		});
	});


	// 채용 - 직무소개 //
	$('.recruit-duty > div').each(function (index) {
		var rdChk = 0+String(index);
		$('.recruit-duty > div').eq(index).click(function(){ 
			if (rdChk == 0+String(index)) {
				$('.recruit-duty > div > div').eq(index).slideDown(300, 'easeOutQuad');
				$('.recruit-duty > div').eq(index).find('i').addClass('xi-minus-min');
				rdChk = 1+String(index);
			} else {
				$('.recruit-duty > div > div').eq(index).slideUp(300, 'easeOutQuad');
				$('.recruit-duty > div').eq(index).find('i').removeClass('xi-minus-min');
				$('.recruit-duty > div').eq(index).find('i').addClass('xi-plus-min');
				rdChk = 0+String(index);
			}
		});
	});


	// 갤러리 //
	$('.list-gallery ul li').hover(function (event) {
		$(this).find('p img').stop().animate({ width : '105%', margin : '-2.5% 0 0 -2.5%', opacity: '0.3' }, 300, 'easeOutQuad');
		$(this).find('> h1').stop().animate({ bottom : '80px', opacity: '1.0' }, 400, 'easeOutQuad');
	}, function (event) {
		$(this).find('p img').stop().animate({ width : '100%', margin : '0', opacity: '1.0' }, 300, 'easeOutQuad');
		$(this).find('> h1').stop().animate({ bottom : '60px', opacity: '0.0' }, 400, 'easeOutQuad');
	});

	
	// 부트스트랩 - 툴팁 //
	$('[data-toggle="tooltip"]').tooltip()
	
});


// 오퍼링 솔루션 - 열기 //
function OSopen (indexChk){
	//alert(indexChk);
	$('.offering-solution').css('display', 'none');
	$('#offeringSolution'+indexChk).css('display', 'block');
};


//부트스트랩 멀티 모달 음영
var count = 0; // 모달이 열릴 때 마다 count 해서  z-index값을 높여줌
$(document).on('show.bs.modal', '.modal', function () {
    var zIndex = 1040 + (10 * count);
    $(this).css('z-index', zIndex);
    setTimeout(function() {
        $('.modal-backdrop').not('.modal-stack').css('z-index', zIndex - 1).addClass('modal-stack');
    }, 0);
    count = count + 1
});


// 부트스트랩 멀티모달 스크롤
$(document).on('hidden.bs.modal', '.modal', function () {
    $('.modal:visible').length && $(document.body).addClass('modal-open');
});


// 부트스트랩 모달 가운데정렬
/*
function alignModal(){
	var modalDialog = $(this).find(".modal-dialog");
	modalDialog.css("margin-top", Math.max(0, ($(window).height() - modalDialog.height()) / 2));
}

$(".modal").on("shown.bs.modal", alignModal);

$(window).on("resize", function(){
	$(".modal:visible").each(alignModal);
});   
*/

// 링크점선 제거 //
function bluring(){
	if(event.srcElement.tagName=="A" || event.srcElement.tagName=="IMG")
	document.body.focus();
}
document.onfocusin=bluring;


//이메일 유효성 검사
function validateEmail(sEmail) {
	var filter = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
	if(filter.test(sEmail)) {
		return true;
	}else {
		return false;
	}
}

//페이징
function fncMakePageBody(total_size,cur_page_no) {

	var pagingParam = {
			'totalSize'   : total_size,
			'pageNo'      : cur_page_no,
			'pageSize'    : PAGE_SIZE,
			'pageListSize': PAGE_SIZE,
			'pageClickFunctionName': 'page_List',
			'showUnlinkedSymbols' : false
	};

	$(document).ready(function () {
		$('#paging_bar').magefister4jPaging(pagingParam);
	});
}

//swfUpload 팝업
function fnFileUpload(LIMIT_FILE_CNT) {
	if (LIMIT_FILE_CNT == undefined || LIMIT_FILE_CNT == "") {
		LIMIT_FILE_CNT = 500;
	}
	
	window.open("/common/index.do?jPath=swfUpload/swfPopup&LIMIT_FILE_CNT="+LIMIT_FILE_CNT
			,"swfUpload","top=100px, left=100px, height=500px, width=500px, status=no, scrollbars=no,location=no ,toolbar=no,menubar=no,resizable=no");
}

/*
*  DOCUMENT ELEMENT VALIDATION CHECK
*  required  : 필수항목(INPUT,SELECT-ONE,TEXTAREA)
				<input type="radio" required />
*  numeric   : 숫자입력항목(INPUT,TEXTAREA)
				<input type="text" numeric="numeric" />
*  maxlength : 입력 최대 길이(INPUT,TEXTAREA)
				<input type="text" maxlength="100" />
*  minlength : 입력 최소 길이(INPUT,TEXTAREA)
				<input type="text" maxlength="3" />
*  matchedlength : 입력 길이 매치(INPUT,TEXTAREA)
				<input type="text" matchlength="3" />
*  email	 : 이메일 형식(INPUT,TEXTAREA)
				<input type="text" email="email" />
*  alpah	 : 알파벳 입력 형식(INPUT,TEXTAREA)
				<input type="text" alpah="alpah" />
*/
function elementCheck(V_FORM) {
	var formChk = true;
	var isFocus = false;
	if (V_FORM == null || V_FORM == 'undefined') {
		$form = $(document);
	} else {
		$form = $('#' + V_FORM);
	}

	$form.find("INPUT,TEXTAREA,SELECT").each(function () {
		var $element = $(this);
		var value = '';
		var title = '';
		var pattern;
		var valueLen;

		if ( $element.prop('tagName') == "SELECT") {
			value = $element.val() == null ? '' : $element.val();
			title = $element.attr('title');
		} else {
			if ( $element.attr('type') == "checkbox") {
				if ($("input[name=" + $element[0].name + "]:checkbox:checked").length > 0) {
					value = $('input[name='+ $element[0].name +']:checked').val();
				}

				title = $('input[name='+ $element[0].name +']:eq(0)').attr('title');
			} else if ($element.attr('type') == "radio") {
				if ($("input[name=" + $element[0].name + "]:radio:checked").length > 0) {
					value = $('input[name='+ $element[0].name +']:checked').val();
				}

				title = $('input[name='+ $element[0].name +']:eq(0)').attr('title');
			} else {
				isFocus = true;
				value = $element.val();
				title = $element.attr('title');
			}
		}

		if (value == '') {
			valueLen = 0;
		} else {
			valueLen = (value.length + (escape(value)+"%u").match(/%u/g).length-1);
		}

		// required 체크
		if ( $element.attr('required') == 'required') {
			if (value == '') {
				alert(title + "는(은) 필수 입력입니다.");
				if (isFocus) {	$element.attr('tabIndex', -1).focus();	}
				formChk = false;
				return false;
			}
		}

		if ( $element.attr('numeric') == 'numeric') {
			
			pattern = /(^[0-9]+$)/;
			if (value != "" && !pattern.test(value)) {
				alert(title + "는(은) 숫자로만 입력하셔야 합니다.");
				if (isFocus) {	$element.attr('tabIndex', -1).focus();	}
				formChk = false;
				return false;
			}
		}

		if ( $element.attr('alpah') == 'alpah') {
			pattern = /(^[a-zA-Z]+$)/;
			if (!pattern.test(value)) {
				alert(title + "는(은) 영문으로만 입력하셔야 합니다.");
				if (isFocus) {	$element.attr('tabIndex', -1).focus();	}
				formChk = false;
				return false;
			}
		}

		if ( $element.attr('alphanum') == 'alphanum') {
			pattern = /((^[a-zA-Z]+[0-9]+$)|(^[0-9]+[a-zA-Z]+$))/;
			if (!pattern.test(value)) {
				alert(title + "는(은) 영문,숫자 혼합으로 입력하셔야 합니다.");
				if (isFocus) {	$element.attr('tabIndex', -1).focus();	}
				formChk = false;
				return false;
			}
		}

		if ( $element.attr('maxlength') > 0 && valueLen > $element.attr('maxlength')) {
			alert(title + "는(은) 한글 " + (parseInt($element.attr('maxlength')) / 2) + "자(영문 " + $element.attr('maxlength') + "자) 이내로 작성 하십시오.");
			if (isFocus) {	$element.attr('tabIndex', -1).focus();	}
			formChk = false;
			return false;
		}

		if ( $element.attr('minlength') > 0 && valueLen < $element.attr('minlength')) {
			alert(title + "는(은) 영문 " + $element.attr('minlength') + "자(한글 " + (parseInt($element.attr('minlength')) / 2) + "자) 이상 작성 하십시오.");
			if (isFocus) {	$element.attr('tabIndex', -1).focus();	}
			formChk = false;
			return false;
		}

		if ( $element.attr('matchedlength') > 0 && $element.attr('matchedlength') != valueLen) {
			alert(title + "는(은) " + $element.attr('matchedlength') + "자 입니다.");
			if (isFocus) {	$element.attr('tabIndex', -1).focus();	}
			formChk = false;
			return false;
		}
		
	});

	return formChk;
}

//세자리마다 콤마
function gfnAddComma(number) {
	var sosu = '';
	var minus = '';
	number = number + '';
	try {
		if (number.indexOf('.') > -1) {
			sosu = number.substring(number.indexOf('.'), number.length);
			number = number.substring(0, number.indexOf('.')) + '';
		}
		if (number.indexOf('-') > -1) {
			minus = '-';
			number = number.substring(1) + '';
		}
	} catch(e) {}

	number = ('' + number).split(',').join('');
	if (number.length > 3) {
		var mod = number.length % 3;
		var output = (mod > 0 ? (number.substring(0,mod)) : '');
		for (var i = 0; i < Math.floor(number.length / 3); i++) {
			if ((mod == 0) && (i == 0))
				output += number.substring(mod+ 3 * i, mod + 3 * i + 3);
			else
				output+= ',' + number.substring(mod + 3 * i, mod + 3 * i + 3);
		}
		return (minus+output + sosu);
	}
	else
		return minus+number + sosu;
}

//첨부파일 다운로드
function gfnAttachFileDown(FILENM, FILEPATH, TRANSFILENM) {
	var fileFrm = document.fileDownFrmFooter;
	fileFrm.F_FILENM.value=FILENM;
	fileFrm.F_FILEPATH.value=FILEPATH;
	fileFrm.F_TRANSFILENM.value=TRANSFILENM;
	fileFrm.action = "/common/fileDown.do";
	fileFrm.target = "fileDownFrameFooter";
	fileFrm.submit();
}

/** ******************달력 관련********************* */
function setDatePicker(id) {

	$("#"+id).attr("readonly","true");

	$("#"+id).datepicker({
		dateFormat: 'yy.mm.dd', //데이터 포멧형식
		changeMonth: true,   //달별로 선택 할 수 있다.
		changeYear: true ,   //년별로 선택 할 수 있다.
		showOn: "both", // 버튼과 텍스트 필드 모두 캘린더를 보여준다.
		buttonImage: "/static_root/images/btnIcn/btn_calendar.png", // 버튼 이미지
		buttonImageOnly: true, // 버튼에 있는 이미지만 표시한다
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'], // 월의 한글 형식.
		dayNamesMin : ['일','월','화','수','목','금','토'],
		showMonthAfterYear: true,
	      onSelect: function( selectedDate ) {
			    var selectIdNm = $(this).attr("id");
				var selectId = $(this).attr("id").replace(/[^0-9]/g, "");

					if(selectIdNm.indexOf("ST_DATE")> -1){
						$('#ED_DATE' + selectId).datepicker();
					    $('#ED_DATE' + selectId).datepicker("option", "minDate", $("#ST_DATE" + selectId).val());
					    $('#ED_DATE' + selectId).datepicker("option", "onClose", function ( selectedDate ) {
					        $("#ST_DATE" + selectId).datepicker( "option", "maxDate", selectedDate );
					    });
					}else{
						$('#ST_DATE' + selectId).datepicker();
					    $('#ST_DATE' + selectId).datepicker("option", "maxDate", $("#ED_DATE" + selectId).val());
					    $('#ST_DATE' + selectId).datepicker("option", "onClose", function ( selectedDate ) {
					        $("#ED_DATE" + selectId).datepicker( "option", "minDate", selectedDate );
					    });
					}

			},
		beforeShow : function () {
			//$(this).val("");
		}
	});
}

/**
 *  기간 선택 달력 (제이쿼리 달력)
 *  from_id : 시작일 input Id
 *  to_id : 끝일 input Id
 */
function setFromToDatePicker(from_id, to_id){	
	setDatePicker(from_id);
	setDatePicker(to_id);
	
	$('#'+from_id).datepicker();
    $('#'+from_id).datepicker("option", "maxDate", $("#"+to_id).val());
    $('#'+from_id).datepicker("option", "onClose", function ( selectedDate ) {
        $("#"+to_id).datepicker( "option", "minDate", selectedDate );
    });
 
    $('#'+to_id).datepicker();
    $('#'+to_id).datepicker("option", "minDate", $("#"+from_id).val());
    $('#'+to_id).datepicker("option", "onClose", function ( selectedDate ) {
        $("#"+from_id).datepicker( "option", "maxDate", selectedDate );
    });    
}

function BBSNOFileDown(bbsno){
	
	$.ajax({ 
		 type : "POST"
		,url  : "/user/Board/Resourse.do"
		,dataType : "json"
		,data : {
			"BBS_NO" : bbsno
		}
		,success : function(transport) {
			setboardGrid(eval(transport.boardList));
		}
	});
	
}

function setboardGrid(dataSet) {
	var resultHtml ="";
	if (dataSet == null || dataSet == "") {
		alert("등록된 자료가 없습니다.");
		return;
	} else {

		$.each(dataSet,function(key,json) {
			var strUrl= '/static_root'+ json.FILE_PATH + json.TRANS_FILE_NM;
			window.open(strUrl ,'_blank');
		});
	}

}

function fnFamilySite(obj){
	if($(obj).val() != ""){
		window.open($(obj).val(), "_blank");
	}
}



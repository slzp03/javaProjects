<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="hbg.dao.BoardDAO" %>
<%@ page import="hbg.vo.BoardVO" %>

<!DOCTYPE html>
<html lang="ja">
<head>

<!-- META -->

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="Author" content="사이트 저작자">
<meta name="Keywords" content="검색 엔진을 위한 키워드">
<meta name="Description" content="사이트에 대한 설명">

<!-- RESPONSIVE -->

<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1, user-scalable=no">

<!-- SCRIPT -->

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<!--<script src="경로" type="text/javascript"></script>-->

<!-- STYLESHEET -->

<link href="HBG/styles/base.css" type="text/css" rel="stylesheet">
<link href="HBG/styles/layout.css" type="text/css" rel="stylesheet">
<link href="HBG/styles/module.css" type="text/css" rel="stylesheet">
<link href="HBG/styles/states.css" type="text/css" rel="stylesheet">
<link href="HBG/styles/theme.css" type="text/css" rel="stylesheet">

<!-- TITLE -->

<title>ボード</title>
<style>

.slip-swiping-container {
    overflow-x: hidden;
}

.slippylist li {
    user-select: none;
    -moz-user-select: none;
    -webkit-user-select: none;
    cursor: default;
}

/* the rest is junk for the demo page */
.slippylist li.demo-allow-select {
    padding: 1em;
    line-height: 1.3;
    user-select: text;
    -moz-user-select: text;
    -webkit-user-select: text;
}

.slippylist li.demo-allow-select span {
    cursor: text;
}

.slippylist li {
    position: relative;    
    display: flex; align-items: center; justify-content: space-between;   
    width: 100%; height: 80px;
    padding: 20px;
    border-bottom: 1px solid #47536d;
}

.skewed {
    transform: rotate(2deg) scale(0.99);
    -webkit-transform: rotate(2deg) scale(0.99);
}

.demo-no-swipe .demo-no-reorder {
    opacity: 0.5;
}
    
.demo-no-swipe:focus {
    border-bottom: 1px solid #fff;
    outline: none
}

.scroll {
    overflow-y: scroll;
    height: 300px;
}
    
/* width */
.scroll::-webkit-scrollbar {
  width: 1px;
}

/* Track */
.scroll::-webkit-scrollbar-track {
  background: #fff; 
}
 
/* Handle */
.scroll::-webkit-scrollbar-thumb {
  background: #3498db;
}

/* Handle on hover */
.scroll::-webkit-scrollbar-thumb:hover {
  background: #aaa;
}

.text-alarm {
  position: fixed;
  display: none;
  width: 100%; height: 50px;  
  background: #e67e22;
  color: #fff;
  font-size: 16px;
  text-align: center;
  line-height: 49px; 
  top: 0;
  box-shadow: 1px 1px 5px #000;
}


</style>

<script src="HBG/scripts/cldar.js"></script>

</head>
<body>

    <div class="layout-wrap">
        <div class="layout-inner">
        
            <%@ include file="include/hbg-header.jsp" %>
            
            <div id="hbg-service">

                <div class="content-1">
                    <div class="content-1s content-1-1 thm-board">
                        <div class="title thm-color thm-border">使用可能ボード</div>
                        <div class="scroll">
                        
                        <ul>
                            <li>
                                <div class="content-1-1-1">
                                    <div class="content-1-1-1-1 memo"></div>
                                    <div class="content-1-1-1-2">
                                        <div class="content-1-1-1-1-1 thm-color">MEMO</div>
                                        <div class="content-1-1-1-1-2 thm-subcolor">あなたの考えを自由に書いてください。</div>
                                    </div>
                                </div>
                                <div class="content-1-1-2 add" data-add-type="memo"></div>
                            </li>
                            <li>
                                <div class="content-1-1-1">
                                    <div class="content-1-1-1-1 cldar"></div>
                                    <div class="content-1-1-1-2">
                                        <div class="content-1-1-1-1-1 thm-color">CALENDAR</div>
                                        <div class="content-1-1-1-1-2 thm-subcolor">カレンダー機能</div>
                                    </div>
                                </div>
                                <div class="content-1-1-2 add" data-add-type="cldar"></div>
                            </li>
                            <li>
                                <div class="content-1-1-1">
                                    <div class="content-1-1-1-1 clist"></div>
                                    <div class="content-1-1-1-2">
                                        <div class="content-1-1-1-1-1 thm-color">CHECKLIST</div>
                                        <div class="content-1-1-1-1-2 thm-subcolor">チェックリスト</div>
                                    </div>
                                </div>
                                <div class="content-1-1-2 add" data-add-type="clist"></div>
                            </li>
                            
                        </ul>
                        
                        </div>
                    </div>
                    <div class="content-1s content-1-2 thm-board">
                        <div class="title thm-color thm-border">使用中ボード</div>
                        
                        <div class="scroll">
                            <ol id="demo2" class="slippylist"></ol>
                        </div>
                    </div>
                    <div class="content-1s content-1-3 thm-board">
                        <div class="title thm-color thm-border">ボード管理</div>
                        
                        <div>
                        	<ul>
                                <li onclick="boardPlusBtn()">ボード追加<div class="folder-plus"></div></li>
                                <li onclick="boardMinusBtn()">ボード削除<div class="folder-minus"></div></li>
                                <li onclick="boardShareBtn()">ボード共有<div class="folder-share"></div></li>
                                <script>
                                function boardPlusBtn() {
                                	$('#hbg-service .content-1 .add').stop().fadeIn(500);
                                	$('#hbg-service .content-1 .minus').stop().fadeOut(500);
                                	$('#hbg-service .content-1 .shareicon').stop().fadeOut(500);
                                }
                                
                                function boardMinusBtn() {
                                	$('#hbg-service .content-1 .add').stop().fadeOut(500);
                                	$('#hbg-service .content-1 .shareicon').stop().fadeOut(500, function () {
                                		$('#hbg-service .content-1 .minus').stop().fadeIn(500);
                                	});                                	                                	
                                }
                                
                                function boardShareBtn() {
                                	$('#hbg-service .content-1 .add').stop().fadeOut(500);
                                	$('#hbg-service .content-1 .minus').stop().fadeOut(500, function () {
                                		$('#hbg-service .content-1 .shareicon').stop().fadeIn(500);
                                	});
                                }
                                </script>
                        	</ul>
                        </div>
                    </div>
                </div>
                
                <div class="content-2">
                    <ul class="boardlist"></ul>                    
                </div>
                
<script src="HBG/scripts/slip.js"></script>
<script>

    function setupSlip(list) {
        
        list.addEventListener('slip:beforereorder', function(e) {
            if (e.target.classList.contains('demo-no-reorder')) e.preventDefault();
        }, false);

        list.addEventListener('slip:beforeswipe', function(e) {
            if (e.target.nodeName == 'INPUT' || e.target.classList.contains('demo-no-swipe')) e.preventDefault();
        }, false);

        list.addEventListener('slip:beforewait', function(e) {
            if (e.target.classList.contains('instant')) e.preventDefault();
        }, false);

        list.addEventListener('slip:afterswipe', function(e) {
            e.target.parentNode.appendChild(e.target);
            /**********/
            boardOrder();
            /**********/
        }, false);

        list.addEventListener('slip:reorder', function(e) {
            e.target.parentNode.insertBefore(e.target, e.detail.insertBefore);
            /**********/
            boardOrder();
            /**********/
            return false;
        }, false);
        
        return new Slip(list);
    }

    setupSlip(document.getElementById('demo2'));
    
    /**********/
    
    function boardOrder() {
    	
    	var orderArray = new Array($('.slippylist li').length);
    	/* 순서 저장 */
		$('.slippylist li').each(function (index, item) {
			orderArray[index] = $(item).attr('data-board-no');
		});    	
    	
		for (var i = 0; i < orderArray.length; i++) {
			/* 기본 보드 틀 */
    		var temp = '<li class="thm-board ' + orderArray[i] + '" data-board-no="' + orderArray[i] + '" data-board-type="' + $('.boardlist .' + orderArray[i]).attr('data-board-type') + '">' + $('.boardlist .' + orderArray[i]).html() + '</li>';
			/* 타이틀 불러오기 */
			var orderTitle = $('.boardlist .' + orderArray[i] + 'title').val();
			/* 타입 불러오기 */
			var orderType = $('.boardlist .' + orderArray[i]).attr('data-board-type');

			switch (orderType) {
				case "memo" :
		    		$('.boardlist .' + orderArray[i]).remove();
		    		$('.boardlist').append(temp);					
	        		var str = $('.boardlist .' + orderArray[i] + ' .content-2-1 textarea').val();
	        		str = str.split('<br>').join('\n');
	        		$('.boardlist .' + orderArray[i] + ' .content-2-1 textarea').val(str);
					break;
				case "clist" :					
					var tempClistCheck = new Array(5);
					var tempClistContent = new Array(5);
					
					for (var j = 0; j < tempClistCheck.length; j++) {
						tempClistCheck[j] = 0;
						if ($('.boardlist .' + orderArray[i] + ' input:checkbox[id=' + orderArray[i] + 'cb' + j + ']').is(":checked")) tempClistCheck[j] = 1;
						tempClistContent[j] = $('.boardlist .' + orderArray[i] + ' .board-clist #' + orderArray[i] + 'cl' + j).val();
					}
					
		    		$('.boardlist .' + orderArray[i]).remove();
		    		$('.boardlist').append(temp);
					
		    		for (var j = 0; j < tempClistCheck.length; j++) {
		    			var value = false;
		    			if (tempClistCheck[j] == 1) {
		    				value = true;
		    			}
		    			$('.boardlist .' + orderArray[i] + ' input:checkbox[id=' + orderArray[i] + 'cb' + j + ']').attr('checked', value);
		    			$('.boardlist .' + orderArray[i] + ' .board-clist #' + orderArray[i] + 'cl' + j).val(tempClistContent[j]);
		    		}		    		
		    		break;
				default :
		    		$('.boardlist .' + orderArray[i]).remove();
		    		$('.boardlist').append(temp);
		    		break;					
			}
			
    		$('.boardlist .' + orderArray[i] + 'title').val(orderTitle);
    		
    	}
    	
    	jQuery.ajaxSettings.traditional = true;
    	
    	$.ajax({
    		
    		url : '${pageContext.request.contextPath}/hbg?command=boardorder.do',
			type : 'post',
			async: false,
			data : {
				'array' : orderArray
			},
    		success : function (data) {
    			
    			if (data != null) {
    			}
    			
			}
    	});
    	
    	boardSave();
    	
	}
    
    /**********/
	
</script>

<script>
$(document).ready(function () {
	
	/* SERV */
	var BOARD_NO;
	var BOARD_TITLE;
	var BOARD_TYPE;
	var BOARD_UPDATE;
	
	function htmlSLIP(BOARD_NO, BOARD_TITLE, BOARD_TYPE, BOARD_UPDATE) {
		return '<li class="demo-no-swipe ' + BOARD_NO + '" data-board-no="' + BOARD_NO + '"><div class="content-1-2-1"><div class="content-1-1-1-1 ' + BOARD_TYPE + '"></div><div class="content-1-1-1-2"><div class="content-1-1-1-1-1 thm-color">' + BOARD_TITLE + '</div><div class="content-1-1-1-1-2 thm-subcolor">最近修正日付 : ' + BOARD_UPDATE + '</div></div></div><div class="content-1-2-2 minus" data-board-no="' + BOARD_NO + '"></div><div class="content-1-2-2 shareicon" data-board-no="' + BOARD_NO + '"></div></li>';
	}
	
	function htmlBOARD(BOARD_NO, BOARD_TYPE, BOARD_UPDATE) {
		return '<li class="thm-board ' + BOARD_NO + '" data-board-no="' + BOARD_NO + '" data-board-type="' + BOARD_TYPE + '"><div class="title thm-border"><div class="thm-color"><input type="text" class="board-title ' + BOARD_NO + 'title"></div></div><div class="content-2-1"></div></li>';
	}	
	
	/* SERVICE 정보 불러오기 */
	
	<%

	ArrayList<BoardVO> service = (ArrayList<BoardVO>)request.getAttribute("service");
	
	for (BoardVO vo : service) {
		%>		
		BOARD_NO = '<%= vo.getBoard_no() %>';
        BOARD_TITLE = '<%= vo.getBoard_title() %>';
       	BOARD_TYPE = '<%= vo.getBoard_type() %>';
        BOARD_UPDATE = '<%= vo.getBoard_update().substring(0, 10) %>';
        
        <%
        switch (vo.getBoard_type()) {
        	case "memo" : %>
        		var appendBOARD = htmlBOARD(BOARD_NO, BOARD_TYPE, BOARD_UPDATE);
        		$('.boardlist').append(appendBOARD);
        		$('.boardlist .' + BOARD_NO + ' .' + BOARD_NO + 'title').val(BOARD_TITLE);
        		var htmlMEMO = '<textarea class="thm-board thm-border"><%= vo.getMemo_content() %></textarea>';
        		$('.boardlist .' + BOARD_NO + ' .content-2-1').append(htmlMEMO);
        		
        		var str = $('.boardlist .' + BOARD_NO + ' .content-2-1 textarea').val();
        		str = str.split('<br>').join('\n');
        		$('.boardlist .' + BOARD_NO + ' .content-2-1 textarea').val(str);

        		<%
        		break;        		
        	case "clist" : %>
        		var appendBOARD = htmlBOARD(BOARD_NO, BOARD_TYPE, BOARD_UPDATE);
    			$('.boardlist').append(appendBOARD);
        		$('.boardlist .' + BOARD_NO + ' .' + BOARD_NO + 'title').val(BOARD_TITLE);
    			$('.boardlist .' + BOARD_NO + ' .content-2-1').append('<table class="board-clist"><tbody></tbody></table>');
    			var clist_check1 = <%= vo.getClist_check1() %>;
    			var clist_check2 = <%= vo.getClist_check2() %>;
    			var clist_check3 = <%= vo.getClist_check3() %>;
    			var clist_check4 = <%= vo.getClist_check4() %>;
    			var clist_check5 = <%= vo.getClist_check5() %>;
    			var clist_content1 = '<%= vo.getClist_content1() %>';
    			var clist_content2 = '<%= vo.getClist_content2() %>';
    			var clist_content3 = '<%= vo.getClist_content3() %>';
    			var clist_content4 = '<%= vo.getClist_content4() %>';
    			var clist_content5 = '<%= vo.getClist_content5() %>';
    			for (var i = 1; i <= 5; i++) {
    				var checked = ''
    				if (eval("clist_check" + i) == 1) {
    					checked = 'checked'
    				}
    				var htmlCLIST = '<tr><td><input type="checkbox" id="' + BOARD_NO + 'cb' + i + '" ' + checked + '><label for="' + BOARD_NO + 'cb' + i + '"></label></td><td><input type="text" id="' + BOARD_NO + 'cl' + i + '"></td></tr>'; 
    				$('.boardlist .' + BOARD_NO + ' .content-2-1 .board-clist tbody').append(htmlCLIST);    				
    				$('.boardlist .' + BOARD_NO + ' .content-2-1 .board-clist #' + BOARD_NO + 'cl' + i).val(eval("clist_content" + i));
    			}
    			
        		<%
        		break;
        		
        	case "cldar" : %>
	        	var appendBOARD = htmlBOARD(BOARD_NO, BOARD_TYPE, BOARD_UPDATE);
				$('.boardlist').append(appendBOARD);
	    		cldar(BOARD_NO);
	    		$('.boardlist .' + BOARD_NO + ' .' + BOARD_NO + 'title').val(BOARD_TITLE);
        		<%
        		break;
        }
        %>
        
        $('.slippylist').append(htmlSLIP(BOARD_NO, BOARD_TITLE, BOARD_TYPE, BOARD_UPDATE));
        
        /* ADD EVENT MINUS */
        $('#hbg-service .slippylist .' + BOARD_NO + ' .minus').on('click', function () {
        	var board_no = $(this).attr('data-board-no');
        	$('.slippylist .' + board_no).remove();
        	$('.boardlist .' + board_no).remove();
        	$.ajax({
        		url : '${pageContext.request.contextPath}/hbg?command=boarddelete.do&boardno='+ board_no ,
				type : 'post',
				success : function(data) {
				}
        	});
        });
        
        /* ADD EVENT SHARE */
        $('#hbg-service .slippylist .' + BOARD_NO + ' .shareicon').on('click', function () {
        	var no = $(this).attr('data-board-no');
        	openShare(no);
        });
        
		<%	
	}	
	
	%>
	
	/* 불러오기 끝 */
	
	/* BOARD 생성 */
	
    $('#hbg-service .content-1 .add').on('click', function () {
    	
        var add_type = $(this).attr('data-add-type');
        
        var BOARDNO;
        var BOARDTITLE;
       	var BOARDTYPE;
        var BOARDUPDATE;
        
        var user = "${sessionScope.user_email}";
        
        if (add_type == 'memo') {
        	BOARDTYPE = 'memo';
        }
        else if (add_type == 'clist') {
        	BOARDTYPE = 'clist';
        }
		else if (add_type == 'cldar') {
			BOARDTYPE = 'cldar';
        }
        
		BOARDTITLE = 'NEW BOARD';
        
		$.ajax({
			url : '${pageContext.request.contextPath}/hbg?command=boardadd.do&boardtype=' + BOARDTYPE,
			type : 'post',
			success : function(data) {
				BOARDNO = data;
				$.ajax({
					url : '${pageContext.request.contextPath}/hbg?command=boardregdate.do&boardno=' + BOARDNO,
					type : 'post',
					success : function(data) {
						BOARDUPDATE = data;
						$.ajax({
							url : '${pageContext.request.contextPath}/hbg?command=userno.do&user=' + user +'&boardno=' + BOARDNO,
							type : 'post',
							success : function(data) {
							}		
						});
						var SLIP = '<li class="demo-no-swipe ' + BOARDNO + '" data-board-no="' + BOARDNO + '"><div class="content-1-2-1"><div class="content-1-1-1-1 ' + BOARDTYPE + '"></div><div class="content-1-1-1-2"><div class="content-1-1-1-1-1 thm-color">' + BOARDTITLE + '</div><div class="content-1-1-1-1-2 thm-subcolor">最近修正日付 : ' + BOARDUPDATE + '</div></div></div><div class="content-1-2-2 minus" data-board-no="' + BOARDNO + '"></div></li>';
				        $('.slippylist').append(SLIP);
				        var BOARD;
				        switch (BOARDTYPE) {
				        	case 'memo' :
				        		BOARD = '<li class="thm-board ' + BOARDNO + '" data-board-no="' + BOARDNO + '" data-board-type="' + BOARDTYPE + '"><div class="title thm-border"><div class="thm-color"><input type="text" class="board-title ' + BOARDNO + 'title"></div></div><div class="content-2-1"><textarea class="thm-board thm-border"></textarea></div></li>';
				        		$('.boardlist').append(BOARD);
				        		$('.boardlist .' + BOARDNO + ' .' + BOARDNO + 'title').val(BOARDTITLE);
				        		break;
				        	case 'clist' :
				        		BOARD = '<li class="thm-board ' + BOARDNO + '" data-board-no="' + BOARDNO + '" data-board-type="' + BOARDTYPE + '"><div class="title thm-border"><div class="thm-color"><input type="text" class="board-title ' + BOARDNO + 'title"></div></div><div class="content-2-1"><form><table class="board-clist"><tr><td><input type="checkbox" id="' + BOARDNO + 'cb1"><label for="' + BOARDNO + 'cb1"></label></td><td><input type="text" id="' + BOARDNO + 'cl1"></td></tr><tr><td><input type="checkbox" id="' + BOARDNO + 'cb2"><label for="' + BOARDNO + 'cb2"></label></td><td><input type="text" id="' + BOARDNO + 'cl2"></td></tr><tr><td><input type="checkbox" id="' + BOARDNO + 'cb3"><label for="' + BOARDNO + 'cb3"></label></td><td><input type="text" id="' + BOARDNO + 'cl3"></td></tr><tr><td><input type="checkbox" id="' + BOARDNO + 'cb4"><label for="' + BOARDNO + 'cb4"></label></td><td><input type="text" id="' + BOARDNO + 'cl4"></td></tr><tr><td><input type="checkbox" id="' + BOARDNO + 'cb5"><label for="' + BOARDNO + 'cb5"></label></td><td><input type="text" id="' + BOARDNO + 'cl5"></td></tr></table></form></div></li>';
				        		$('.boardlist').append(BOARD);
				        		$('.boardlist .' + BOARDNO + ' .' + BOARDNO + 'title').val(BOARDTITLE);
				        		break;
				        	case 'cldar' :
				        		BOARD = '<li class="thm-board ' + BOARDNO + '" data-board-no="' + BOARDNO + '" data-board-type="' + BOARDTYPE + '"><scr' + 'ipt>cldar(1)</scr' + 'ipt></li>';				        		
				        		$('.boardlist').append(BOARD);
				        		cldar(BOARDNO);
				        		$('.boardlist .' + BOARDNO + ' .' + BOARDNO + 'title').val(BOARDTITLE);
				        		break;
				        }
				        
						boardSave();
				        				        
				        /* ADD EVENT MINUS */
				        $('#hbg-service .slippylist .' + BOARDNO + ' .minus').on('click', function () {
				        	var board_no = $(this).attr('data-board-no');
				        	console.log(board_no);
				        	$('.slippylist .' + board_no).remove();
				        	$('.boardlist .' + board_no).remove();
				        	$.ajax({
				        		url : '${pageContext.request.contextPath}/hbg?command=boarddelete.do&boardno='+ board_no ,
								type : 'post',
								success : function(data) {
								}
				        	});
				        });
				        
				        $('#hbg-service .slippylist').focus();
					        
					}
				});
			}
		});

    });
	
	boardSave();
	
});

</script>

            </div><!-- END SERVICE END -->
            
            <%@ include file="include/hbg-footer.jsp" %>
            
        </div>
    </div><!-- END WRAP END -->


<script>
/* BOARDLIST 저장 */
function boardSave() {
	$('#hbg-service .boardlist input, #hbg-service .boardlist textarea').on('change', function () {
		
		$('.boardlist li').each(function (index, item) {
			var board_no = $(item).attr('data-board-no');
			var board_title = $('.boardlist li .' + board_no + 'title').val();
			var board_type = $(item).attr('data-board-type');
			
			if (board_title == '') {
				board_title = '題目なし';
			}

			$.ajax({
        		url : '${pageContext.request.contextPath}/hbg?command=titleupdate.do&board_no=' + board_no + '&board_title=' + board_title,
				type : 'post',
				success : function(data) {
				}
        	});
			
			$('.slippylist li.demo-no-swipe.' + board_no + ' .content-1-1-1-1-1').text(board_title);
			
			switch (board_type) {
				case "memo" :
			    	jQuery.ajaxSettings.traditional = true;
					$.ajax({
		        		url : '${pageContext.request.contextPath}/hbg?command=memoupdate.do&board_no=' + board_no,
						type : 'post',
						data : {
							'memo_content' : $('.boardlist .' + board_no + ' textarea').val()
						},
						success : function(data) {
						}
		        	});
					break;
				case "clist" :
					for (var i = 1; i <= 5; i++) { 
						var checkbox_no = i;
						var checkbox_checked = 0;
						if ($('.boardlist .' + board_no + ' input:checkbox[id=' + board_no + 'cb' + checkbox_no + ']').is(":checked")) checkbox_checked = 1;
						$.ajax({
			        		url : '${pageContext.request.contextPath}/hbg?command=checkboxupdate.do&board_no=' + board_no + '&checkbox_no=' + checkbox_no + '&checkbox_checked=' + checkbox_checked,
							type : 'post',
							success : function(data) {
							}
			        	});
						jQuery.ajaxSettings.traditional = true;
						$.ajax({
			        		url : '${pageContext.request.contextPath}/hbg?command=checktextupdate.do&board_no=' + board_no + '&checkbox_no=' + checkbox_no,
							type : 'post',
							data : {
								'clist_content' : $('.boardlist .' + board_no + ' #' + board_no + 'cl' + i).val()
							},
							success : function(data) {
							}
			        	});
					}

					break;
			}

		});
		
		
		$('.text-alarm').stop().slideDown(1000, function () {
			setTimeout(function () {
				$('.text-alarm').stop().slideUp(1000, function () {
					$('.text-alarm').text('格納しました。');
				});
			}, 2000);
		});
		
	});
	
}
</script>

<div class="text-alarm">格納しました。</div>

<script>
function openShare(board_no) {
	var appendHtml = '';
	appendHtml += '<div class="share">';
	appendHtml += '<div class="share-title">';
	appendHtml += '共有<a class="share-close" onclick="closeShare()"></a>';
	appendHtml += '</div>';
	appendHtml += '<div class="share-content">';
	appendHtml += '<input type="text" placeholder="共有したいE-Mailを記入してください。">';
	appendHtml += '<input type="button" value="共有" onclick="shareOK(' + board_no + ')">';
	appendHtml += '</div>';
	appendHtml += '</div>';
	
	$('body').append(appendHtml);
}

function closeShare() {
	$('.share').remove();
}

function shareOK(board_no) {
	console.log(board_no);
	/*********************************/
	var share_email = $('.share input[type=text]').val();
	/*
	공유하고 공유받은 사용자에게 알람추가
	*/	
	/*********************************/
	$('.text-alarm').text('共有');
	$('.text-alarm').stop().slideDown(1000, function () {
		setTimeout(function () {
			$('.text-alarm').stop().slideUp(1000, function () {
				$('.text-alarm').text('格納しました。');
			});
		}, 2000);
	});
	$('.share').remove();
}
</script>

<script>
var toggle_alarm = 1;
function toggleAlarm() {
	$('.header-alarm span').remove();
	if (toggle_alarm) {
		var appendHtml = '';
	 	appendHtml += '<div class="alarm">';
	 	appendHtml += 	'<div class="alarm-arrow"></div>';
	 	/* alarm 반복문 */
	 	appendHtml += 	'<div class="alarm-box">';
	 	appendHtml += 		'<div class="alarm-text">OO様のボード共有</div>';
	 	appendHtml += 		'<input type="button" value="確認" class="alarm-btn" onclick="alarmClose()">';
	 	appendHtml += 	'</div>';
	 	/* 반복문 끝 */
	 	appendHtml += '</div>';		        	
	 	$('#header').append(appendHtml);
	 	toggle_alarm = 0;
	}
	else {
		$('.alarm').remove();
		toggle_alarm = 1;
	}
}
function alarmClose() {
	$('.alarm').remove();
	toggle_alarm = 1;
}
</script>

</body>
</html>
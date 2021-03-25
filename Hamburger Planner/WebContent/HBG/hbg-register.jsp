<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${result==0 }">
	<script>
		alert("회원가입에 실패하였습니다 다시입력해주십시오");
	</script> 
</c:if>
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

<link href="styles/base.css" type="text/css" rel="stylesheet">
<link href="styles/layout.css" type="text/css" rel="stylesheet">
<link href="styles/module.css" type="text/css" rel="stylesheet">
<link href="styles/states.css" type="text/css" rel="stylesheet">
<link href="styles/theme.css" type="text/css" rel="stylesheet">

<!-- TITLE -->

<title>新規登録</title>
<style>
    
</style>
</head>
<body>
  
    <div class="layout-wrap">
        <div class="layout-inner">
        
            <%@ include file="include/hbg-header.jsp" %>
            
            <div id="hbg-register">
                <div class="register-inner">
                    <form name="frm" method="post" enctype="multipart/form-data" action="/hbg?command=RegisterInsert.do">
                        <div class="title co-white">新規登録</div>
                        
                        <div class="user_image">
                           <label for="user_image_file">
                            <a class="user_image_plus"></a>
                            </label>
                        </div>
                        <input type="file" class="inp-img" name="user_image_file" id="user_image_file" style="display: none;">
                        <input class="user_name" name="user_name" type="text" placeholder="姓名" autocomplete="off">                      
                        <div class="msg msg-1"></div>
                        <input class="user_email" id=user_email name="user_email" type="text"  placeholder="ID(E-Mail)" autocomplete="off">                        
                        <div class="msg msg-2"></div>
                        <input class="user_pass" name="user_pass" type="password" placeholder="パスワード" autocomplete="off">
                        <div class="msg msg-3"></div>
                        <input class="user_passok" name="user_passok" type="password" placeholder="パスワード確認" autocomplete="off">
                        <div class="msg msg-4"></div>
                        <input type="button" class="next" value="確認">
                        
                    </form>
                </div>
<script type="text/javascript">
$(document).ready(function () {
	 
   	var getName = RegExp(  /^[가-힣a-zA-Z]{2,40}$/);
   	var getEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
   	var getCheck= RegExp(/^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/);
   	
   	$('.user_name')
    .on("propertychange change keyup paste input, focusout", function () {
		if (!getName.test($(".user_name").val()) && $(this).val().length > 0) {
            /* 유효성 검사 */
	    	$('.msg-1').text('漢字/英字2桁以上入力してください。');
        	$(this).css({
                'border-bottom': '1px solid #e74c3c'
            });
                               
        } else if (getName.test($(".user_name").val())) {
			$('.msg-1').text('');
            $(this).css({
                'border-bottom': '1px solid #1abc9c'
            });
            
        } else if ($(this).val().length == 0) {
			$('.msg-1').text('');
            $(this).css({
                'border-bottom': '1px solid #47536d'
            });
		}
    })
    .on("focus", function () {
    	$('.msg-1').text('');
        $(this).css({
            'border-bottom': '1px solid #fff'
        });
    })
   	
   	$("#user_email")
   	.on("propertychange change keyup paste input, focusout", function() {
   		var user_id = $('#user_email').val();
   		if (!getEmail.test($(".user_email").val()) && $(this).val().length > 0) {
   			$('.msg-2').text('様式が当たらないです。');
  			$(".msg-2").css({
				color: '#e74c3c'
			});
        	$(this).css({
                'border-bottom': '1px solid #e74c3c'
            });
   		}
   		else {
   			$.ajax({
	   		url : '${pageContext.request.contextPath}/hbg?command=RegisterEmailCheck.do&user_id='+ user_id ,
	   		type : 'post',
	   		success : function(data) {

	   			console.log("1 = 중복o / 3 = 중복x : "+ data);
	   			
	   			if (data == 1) {
	   				// 1 : 아이디가 중복되는 문구
	   				$(".msg-2").text("既にあるIDです。");
	   				$(".msg-2").css({
	   					color: '#e74c3c'
	   				});
	   				$('#user_email').css({
	   	                'border-bottom': '1px solid #e74c3c'
	   	            });
	   			} else if (data == 2){
	   				$(".msg-2").text(""); //공백 일시
	   			} else if (data == 3){
	   				$(".msg-2").text("できるIDです。");
	   				$(".msg-2").css({
	   					color: '#1abc9c'
	   				});
	   				$('#user_email').css({
	   	                'border-bottom': '1px solid #1abc9c'
	   	            });
	   			}
	   		}, error : function() {
	   			console.log("실패");
	   		}
	      
	   		});
   		}
   		
   		if ($(this).val().length == 0) {
			$('.msg-2').text('');
            $(this).css({
                'border-bottom': '1px solid #47536d'
            });
		}
   	
   	})
    .on("focus", function () {
    	$('.msg-1').text('');
        $(this).css({
            'border-bottom': '1px solid #fff'
        });
    });
    
    $('.user_pass')
      .on("propertychange change keyup paste input, focusout", function () {
		if (!getCheck.test($(".user_pass").val()) && $(this).val().length > 0) {        
            /* 유효성 검사 */
	    	$('.msg-3').text('英字、数字、特殊記号を含めて8桁以上で作成してください。');
        	$(this).css({
                'border-bottom': '1px solid #e74c3c'
            });
		}
		if($(".user_pass").val() != $(".user_passok").val() && $(".user_passok").val().length > 0 ){
			$('.msg-4').text('再び入力してください。');
            $(".user_passok").css({
                'border-bottom': '1px solid #e74c3c'
            });			 
		} if (getCheck.test($(".user_pass").val())) {
			$('.msg-3').text('');
            $(this).css({
                'border-bottom': '1px solid #1abc9c'
            });
        } else if($(this).val().length == 0){
			$('.msg').text('');
            $(this).css({
                'border-bottom': '1px solid #47536d'
            });			    
		}
		
    })
	.on("focus", function () {
    	$('.msg-1').text('');
        $(this).css({
            'border-bottom': '1px solid #fff'
        });
    });
    
    $('.user_passok')
    .on("propertychange change keyup paste input, focusout", function () {
        if ( $(".user_pass").val() != ($(".user_passok").val()) && $(this).val().length > 0) {

			$('.msg-4').text('パスワードが当たらない');
            $(this).css({
                'border-bottom': '1px solid #e74c3c'
            });
	    } else if ($(".user_pass").val() == ($(".user_passok").val()) && $(this).val().length > 0) {
			$('.msg-4').text('');
            $(this).css({
                'border-bottom': '1px solid #1abc9c'
            });            
        } else if($(this).val().length == 0 ){
			$('.msg-4').text('');
            $(this).css({
                'border-bottom': '1px solid #47536d'
            });		
		}
         
    })
	.on("focus", function () {
    	$('.msg-1').text('');
        $(this).css({
            'border-bottom': '1px solid #fff'
        });
    });
    
    function readInputFile(input) {
        if(input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
            	$('.user_image').css({
            		'background-image': 'url(' + e.target.result + ')'
            	})
            }
            reader.readAsDataURL(input.files[0]);
        }
    }
    $(".inp-img").on('change', function(){
        readInputFile(this);
    });
    
    $('.next').on('click', function () {
    	frm.submit();
    });
    
});


</script>
            </div><!-- REGISTER -->
            
            <%@ include file="include/hbg-footer.jsp" %>
            
        </div>
    </div><!-- END WRAP END -->

</body>
</html>
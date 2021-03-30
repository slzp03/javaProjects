<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<c:if test="${modi==0 }">
	<script>
		alert("修正を失敗しました。パスワードを確認してください。");
	</script> 
	<% int temp=-1;
	session.setAttribute("modi", temp); %>
</c:if>
<c:if test="${modi==1 }">
	<script>
	alert("修正しました。");
	</script> 
	<% int temp=-1;
	session.setAttribute("modi", temp); %>
</c:if>
<c:if test="${del==0 }">
	<script>
		alert("退会を失敗しました。パスワードを確認してください。");
	</script>
	<% int temp=-1;
	session.setAttribute("del", temp); %>
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

<title>マイページ</title>

<script>
	
    function info1() {
        $('#hbg-mypage .content-2-2-2').stop().fadeOut(50, function () {
            $('#hbg-mypage .content-2-2-1').fadeIn();
        });
    }
    
    function info2() {
        $('#hbg-mypage .content-2-2-1').stop().fadeOut(50, function () {
            $('#hbg-mypage .content-2-2-2').fadeIn();
        });
    }
    function Modify(){
    	if(confirm("修正しますか？")==true){
    		
			modi.submit();
		}else{
			return;
		}
}
    
    function Delete(){
    	if(confirm("削除しますか？")==true){
    		
			del.submit();
		}else{
			return;
		}
 
}
</script>
</head>
<body>
    <div class="layout-wrap">
        <div class="layout-inner">
           
            <%@ include file="include/hbg-header.jsp" %>
            
            <div id="hbg-mypage">
                <div class="content-1">
                    <div class="content-1-1">MY PAGE</div>
                    <ul>
                        <li onclick="info1()">情報修正</li>
                        <li onclick="info2()">退会</li>
                    </ul>
                </div>

                <div class="content-2">
                    <div class="content-2-1">
                        <a>ホーム > マイページ > 情報修正</a>
                    </div>

                    <div class="content-2-2">
                        
                        <div class="content-2-2-1">
                            <form name="modi" method="post" action="/hbg?command=modify.do" enctype="multipart/form-data">
                                <div class="title">情報修正</div>
                                
                                <div class="user_image">
                                <label for="user_image_file">
                                <a class="user_image_plus"></a>
                                </label>
                                </div>
                                <input type="file" class="inp-img" name="user_image" id="user_image_file" style="display: none;" >
                                <input  style="color: #6879a1; width: 100%; height: 40px;border-bottom: 1px solid #47536d;" class="user_name" name="user_name" type="text" placeholder="NAME" autocomplete="off" value="${user.user_name}" readonly>

                                <div class="msg msg-1"></div>

                                <input style="color: #6879a1; width: 100%; height: 40px;border-bottom: 1px solid #47536d;" class="user_email" id=user_email name="useremail" type="text"  placeholder="ID(E-Mail)" autocomplete="off" value="${user.user_email }" readonly>

                                <div class="msg msg-2"></div>

                                <input class="user_pass" name="user_pass" type="password" placeholder="パスワード" autocomplete="off">
                                <div class="msg msg-3"></div>
                                <input class="user_passok" name="user_passok" type="password" placeholder="パスワード確認" autocomplete="off">
                                <div class="msg msg-4"></div>

                                <input type="button" class="next" value="修正" onClick="javascript:Modify()">
                            </form>
                            
                        </div>
                        
                        <div class="content-2-2-2">
                            <form name="del" method="post" action="/hbg?command=delete.do" enctype="multipart/form-data">
                                <div class="title">退会</div>
                                
                                <input style="color: #6879a1; width: 100%; height: 40px;border-bottom: 1px solid #47536d;" class="user_name" name="user_name" type="text" placeholder="NAME" autocomplete="off" value="${user.user_name}" readonly>

                                <div class="msg msg-1"></div>
                                <input style="color: #6879a1; width: 100%; height: 40px;border-bottom: 1px solid #47536d;" class="user_email" id=user_email name="useremail" type="text"  placeholder="ID(E-Mail)" autocomplete="off" value="${user.user_email }" readonly>

                                <div class="msg msg-2"></div>
                                <input class="user_pass" name="user_pass" type="password" placeholder="パスワード" autocomplete="off">
                                <div class="msg msg-3"></div>
                                <input class="user_passok" name="user_passok" type="password" placeholder="パスワード確認" autocomplete="off">
                                <div class="msg msg-4"></div>
							<input type="button" class="next" value="削除" onClick="javascript:Delete()">
                            </form>                            
                        </div>
                        
                    </div>

                </div>
    
            </div><!-- END MYPAGE END -->
            
          	<%@ include file="include/hbg-footer.jsp" %>
          	
        </div>
    </div><!-- END WRAP END -->


</body>
</html>
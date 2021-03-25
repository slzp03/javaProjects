<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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

<title>メールテーク</title>

</head>
<body>
  
    <div class="layout-wrap">
        <div class="layout-inner">
        
        	<%@ include file="include/hbg-header.jsp" %>
            
            <div id="hbg-register-email" style="display: flex; align-items:center; justify-content: center; height: 400px; flex-direction: column;">
                <div class="msg">E-Mail承認を完了してください。</div>
                <a href="/hbg?command=login.go"><input type="button" class="next" value="ログインページへ" style="font-size: 20px; color: #fff;"></a>
            </div>    
                    
            <%@ include file="include/hbg-footer.jsp" %>
            
        </div>
    </div><!-- END WRAP END -->

</body>
</html>
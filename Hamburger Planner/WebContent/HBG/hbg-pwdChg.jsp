<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<c:if test="${change==0 }">
	<script>
		alert("パスワードを確認してください。");
	</script> 
	<% int temp=-1;
	session.setAttribute("change", temp); %>
</c:if>
<c:if test="${pwdSc==1 }">
	<script>
		alert("パスワード変更ができます。");
	</script> 
	<% int temp=-1;
	session.setAttribute("pwdSc", temp); %>
</c:if>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="Author" content="사이트 저작자">
<meta name="Keywords" content="검색 엔진을 위한 키워드">
<meta name="Description" content="사이트에 대한 설명">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1, user-scalable=no">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<link href="styles/base.css" type="text/css" rel="stylesheet">
<link href="styles/layout.css" type="text/css" rel="stylesheet">
<link href="styles/module.css" type="text/css" rel="stylesheet">
<link href="styles/states.css" type="text/css" rel="stylesheet">
<link href="styles/theme.css" type="text/css" rel="stylesheet">
<title>パスワード変更</title>
</head>
<body>

<div class="layout-wrap">
        <div class="layout-inner">
        
            <%@ include file="include/hbg-header.jsp" %>

            <div id="hbg-login">
                <div class="login-inner">
                      <form method="post" action="/hbg?command=change.do">

                        <div class="title">パスワード変更</div>
                        
                         <input class="user_email" id=user_email name="user_email" type="text"  placeholder="아이디 (이메일)" autocomplete="off" value="${user_email}" readonly>

                                <div class="msg msg-2"></div>
                        
                        <input class="user_pass" name="user_pass" type="password" placeholder="パスワード" autocomplete="off">
                                <div class="msg msg-3"></div>
                        <input class="user_passok" name="user_passok" type="password" placeholder="パスワード確認" autocomplete="off">
                                <div class="msg msg-4"></div>
                        <input type="submit" class="next" value="変更">
                    </form>
                    
                    <a href="/HBG/hbg-login.jsp">戻る</a>
                </div>
            </div>
            
            <%@ include file="include/hbg-footer.jsp" %>
            
        </div>
    </div><!-- END WRAP END -->

</body>
</html>
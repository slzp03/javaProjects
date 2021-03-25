<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<c:if test="${pwdSc==0 }">
	<script>
		alert("情報が存在しないです。");
	</script> 
	<% int temp=-1;
	session.setAttribute("pwdSc", temp); %>
</c:if>
<title>パスワード探す</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1, user-scalable=no">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<link href="styles/base.css" type="text/css" rel="stylesheet">
<link href="styles/layout.css" type="text/css" rel="stylesheet">
<link href="styles/module.css" type="text/css" rel="stylesheet">
<link href="styles/states.css" type="text/css" rel="stylesheet">
<link href="styles/theme.css" type="text/css" rel="stylesheet">
</head>
<body>
<div class="layout-wrap">
        <div class="layout-inner">
        
            <%@ include file="include/hbg-header.jsp" %>

            <div id="hbg-login">
                <div class="login-inner">
                    <form method="post" action="/hbg?command=pwdSc.do">

                        <div class="title">パスワード探す</div>
                        
                        <input name="user_name" class="user_name" type="text" placeholder="姓名" autocomplete="off">
                        
                        <input name="user_email" id="user_email" class="user_email" type="text"  placeholder="ID(E-Mail)" autocomplete="off">
                        
                        <div class="msg msg-1"></div>
                        
                        <div class="content">
                           
                        </div>
                        
                        <input type="submit" class="next" value="パスワード探す">
                    </form>
                    
                    <a href="/HBG/hbg-login.jsp">戻る</a>
                </div>
            </div>
            
            <%@ include file="include/hbg-footer.jsp" %>
            
        </div>
    </div><!-- END WRAP END -->
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name = "viewport" content = "width=device-width, initial-scale=1, shrink-to-fit=no">
<title>講義評価Web</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
<link rel="stylesheet" href="./css/custom.css">
</head>
<body>
	<%
	String userID=null;
	if(session.getAttribute("userID")!=null){
		userID=(String)session.getAttribute("userID");
	}
	if(userID==null){
		PrintWriter sc = response.getWriter();
		sc.println("<script>");
		sc.println("alert('Loginしてください。');");
		sc.println("location.href='userLogin.jsp';");
		sc.println("</script>");
		sc.close();
		return;
	}
	
%>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="index.jsp">講義評価WEBSITE</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="index.jsp">MAIN</a>
      </li>
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          会員管理
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <%
          if(userID ==null) {
          %>
          <a class="dropdown-item" href="userLogin.jsp">Login</a>
          <a class="dropdown-item" href="userJoin.jsp">新規登録</a>
           <%}else{ %>
          <a class="dropdown-item" href="userLogout.jsp">Logout</a>
        <%} %>
        </div>
      </li>
    </ul>
    <form class="form-inline my-2 my-lg-0">
      <input class="form-control mr-sm-2" type="search" placeholder="内容入力" aria-label="Search">
      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">検索</button>
    </form>
  </div>
</nav>

<section class="container mt-3" style="max-width:560px;">
	
<div class="alert alert-warning mt-4" role="alert">
	E-Mail Address 証明が必要です。再び受けるのはボタンをクリックしてください。
</div>
<a href="emailSendAction.jsp" class="btn btn-primary">再証明</a>
</section>

<footer class="bg-dark mt-3 p-5 text-center" style="color:#ffffff;">
	CopyRight &copy; 2021 キムさん　ALL Rights Reserved.
</footer>

		<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" ></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" ></script>
	
	
	
</body>
</html>
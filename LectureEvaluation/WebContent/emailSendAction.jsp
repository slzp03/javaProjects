
<%@page import="javax.mail.internet.MimeMessage"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.mail.Transport" %>
<%@ page import="javax.mail.Message" %>
<%@ page import="javax.mail.Address" %>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.Session"%>
<%@page import="javax.mail.Authenticator"%>
<%@ page import="java.util.Properties" %>
<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="util.SHA256" %>
<%@ page import="util.Gmail" %>
<%@ page import="java.io.PrintWriter" %>

<%
request.setCharacterEncoding("UTF-8");
UserDAO userDAO = new UserDAO();
String userID=null;
if(session.getAttribute("userID")!=null){
	userID=(String)session.getAttribute("userID");
}
if(userID==null){
	PrintWriter sc = response.getWriter();
	sc.println("<script>");
	sc.println("alert('GO LOGIN');");
	sc.println("location.href='userLogin.jsp'");
	sc.println("</script>");
	sc.close();
	return;
}



boolean emailChecked = userDAO.getUserEmailChecked(userID);

if(emailChecked==true){
	PrintWriter sc = response.getWriter();
	sc.println("<script>");
	sc.println("alert('既に証明しました。');");
	sc.println("location.href='index.jsp'");
	sc.println("</script>");
	sc.close();
	return;
}

String host = "http://localhost:8080/LectureEvaluation/";
String from = "audgns842@gmail.com";
String to = userDAO.getUserEmail(userID);
String subject = "Email 証明です。";
String content = "Linkに接続して証明してください。" + "<a href='"+host+"emailCheckAction.jsp?code="+new SHA256().getSHA256(to)+"'>メール証明</a>";
Properties p = new Properties();
p.put("mail.smtp.user", from);
p.put("mail.smtp.host", "smtp.googlemail.com");
p.put("mail.smtp.port", "465");
p.put("mail.smtp.starttls.enable", "true");
p.put("mail.smtp.auth", "true");
p.put("mail.smtp.debug", "true");
p.put("mail.smtp.socketFactory.port", "465");
p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
p.put("mail.smtp.socketFactory.fallback", "false");

try{
	Authenticator auth = new Gmail();
	Session ses = Session.getInstance(p,auth);
	ses.setDebug(true);
	MimeMessage msg = new MimeMessage(ses);
	msg.setSubject(subject);
	Address fromAddr = new InternetAddress(from);
	msg.setFrom(fromAddr);
	Address toAddr = new InternetAddress(to);
	msg.addRecipient(Message.RecipientType.TO, toAddr);
	msg.setContent(content,"text/html;charset=UTF-8");
	Transport.send(msg);
}catch(Exception e){
	
		
	e.printStackTrace();
	PrintWriter sc = response.getWriter();
	sc.println("<script>");
	sc.println("alert('Error発生しました。');");
	sc.println("history.back();");
	sc.println("</script>");
	sc.close();
}


%>

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
          <a class="dropdown-item" href="userLogin.jsp">Login</a>
          <a class="dropdown-item" href="userJoin.jsp">新規登録</a>
           <a class="dropdown-item" href="userLogout.jsp">Logout</a>
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
	<div class="alert alert-success mt-4" role="alert">
		Email　Address 証明メールを送りました。自分のメールに入って証明してください。
	</div>
</section>

<footer class="bg-dark mt-3 p-5 text-center" style="color:#ffffff;">
	CopyRight &copy; 2021 キムさん　ALL Rights Reserved.
</footer>

		<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" ></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" ></script>
	
	
	
</body>
</html>
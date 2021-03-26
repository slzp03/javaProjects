
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

request.setCharacterEncoding("UTF-8");
String reportTitle = null;
String reportContent = null;
if(request.getParameter("reportTitle")!=null){
	reportTitle=request.getParameter("reportTitle");
}
if(request.getParameter("reportContent")!=null){
	reportContent=request.getParameter("reportContent");
}
if(reportContent==null || reportTitle==null){
	PrintWriter sc = response.getWriter();
	sc.println("<script>");
	sc.println("alert('入力内容してください。');");
	sc.println("history.back();");
	sc.println("</script>");
	sc.close();
	return;
}

String host = "http://localhost:8080/LectureEvaluation/";
String from = "audgns842@gmail.com";
String to = "slzp03@naver.com";
String subject = "講義評価　信号Email";
String content = "信号者 :" + userID+
				 "<br>題名　:"+reportTitle +
				 "<br>内容　:"+reportContent;

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
	msg.setContent(content,"text/html;charset=UTF8");
	Transport.send(msg);
	
}catch(Exception e){
	
		
	e.printStackTrace();
	PrintWriter sc = response.getWriter();
	sc.println("<script>");
	sc.println("alert('MAIL - Error発生しました。');");
	sc.println("history.back();");
	sc.println("</script>");
	sc.close();
}

PrintWriter sc = response.getWriter();
sc.println("<script>");
sc.println("alert('信号が受付なりました。');");
sc.println("history.back();");
sc.println("</script>");
sc.close();

%>

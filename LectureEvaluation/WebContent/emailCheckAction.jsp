<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="util.SHA256" %>
<%@ page import="java.io.PrintWriter" %>

<%
request.setCharacterEncoding("UTF-8");
String code = null;
if(session.getAttribute("code")!=null){
	code = (String)session.getAttribute("code");
}
UserDAO userDAO = new UserDAO();
String userID=null;

if(session.getAttribute("userID")!=null){
	userID = (String)session.getAttribute("userID");
}
if(userID==null){
	PrintWriter sc = response.getWriter();
	sc.println("<script>");
	sc.println("alert('LOGINしてください。');");
	sc.println("location.href = 'userLogin.jsp'");
	sc.println("</script>");
	sc.close();
	return;
}
String userEmail = userDAO.getUserEmail(userID);
boolean isRight = (new SHA256().getSHA256(userEmail).equals(code)) ? true : false;
if(isRight==true){
	userDAO.setUserEmailChecked(userID);
	PrintWriter sc = response.getWriter();
	sc.println("<script>");
	sc.println("alert('証明成功しました。');");
	sc.println("location.href = 'index.jsp'");
	sc.println("</script>");
	sc.close();
	return;
}else{
	PrintWriter sc = response.getWriter();
	sc.println("<script>");
	sc.println("alert('CODE Error 発生しました。');");
	sc.println("location.href = 'index.jsp'");
	sc.println("</script>");
	sc.close();
	return;
}

%>
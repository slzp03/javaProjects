<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="util.SHA256" %>
<%@ page import="java.io.PrintWriter" %>

<%
request.setCharacterEncoding("UTF-8");

String userID=null;
if(session.getAttribute("userID")!=null){
	userID=(String)session.getAttribute("userID");
}
if(userID!=null){
	PrintWriter sc = response.getWriter();
	sc.println("<script>");
	sc.println("location.href='index.jsp';");
	sc.println("</script>");
	sc.close();
	return;
}


String userPassword = null;
if(request.getParameter("userID")!=null){
	userID=request.getParameter("userID");
}
if(request.getParameter("userPassword")!=null){
	userPassword=request.getParameter("userPassword");
}

if(userID == null || userPassword == null ){
	PrintWriter sc = response.getWriter();
	sc.println("<script>");
	sc.println("alert('条件に当たらない');");
	sc.println("history.back();");
	sc.println("</script>");
	sc.close();
	return;
}

UserDAO userDAO = new UserDAO();
int result = userDAO.login(userID, userPassword);
System.out.println(result);
if(result==1){
	session.setAttribute("userID", userID);
	PrintWriter sc = response.getWriter();
	sc.println("<script>");
	sc.println("location.href = 'index.jsp';");
	sc.println("</script>");
	sc.close();
	return;
}else if(result==0){
	PrintWriter sc = response.getWriter();
	sc.println("<script>");
	sc.println("alert('パスワードが間違い');");
	sc.println("history.back();");
	sc.println("</script>");
	sc.close();
	return;
}else if(result==-1){
	PrintWriter sc = response.getWriter();
	sc.println("<script>");
	sc.println("alert('IDが存在しない');");
	sc.println("history.back();");
	sc.println("</script>");
	sc.close();
	return;
}
else if(result==-2){
	PrintWriter sc = response.getWriter();
	sc.println("<script>");
	sc.println("alert('データベースError');");
	sc.println("history.back();");
	sc.println("</script>");
	sc.close();
	return;
}
%>
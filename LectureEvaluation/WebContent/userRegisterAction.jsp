<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="util.SHA256" %>
<%@ page import="java.io.PrintWriter" %>

<%
request.setCharacterEncoding("UTF-8");
String userID=null;
String userPassword = null;
String userEmail = null;
if(request.getParameter("userID")!=null){
	userID=request.getParameter("userID");
}
if(request.getParameter("userPassword")!=null){
	userPassword=request.getParameter("userPassword");
}
if(request.getParameter("userEmail")!=null){
	userEmail=request.getParameter("userEmail");
}
if(userID == null || userPassword == null || userEmail == null){
	PrintWriter sc = response.getWriter();
	sc.println("<script>");
	sc.println("alert('条件に当たらない');");
	sc.println("history.back();");
	sc.println("</script>");
	sc.close();
	return;
}

UserDAO userDAO = new UserDAO();
int result = userDAO.join(new UserDTO(userID,userPassword,userEmail,SHA256.getSHA256(userEmail),false));

if(result==-1){
	PrintWriter sc = response.getWriter();
	sc.println("<script>");
	sc.println("alert('既に存在します');");
	sc.println("history.back();");
	sc.println("</script>");
	sc.close();
	return;
}else{
	session.setAttribute("userID", userID);
	PrintWriter sc = response.getWriter();
	sc.println("<script>");
	sc.println("location.href = 'emailSendAction.jsp'");
	sc.println("</script>");
	sc.close();
	return;
}
%>
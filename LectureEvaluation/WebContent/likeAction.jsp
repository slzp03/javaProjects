<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="evaluation.EvaluationDAO" %>
<%@ page import="likey.LikeyDAO" %>
<%@ page import="user.UserDAO" %>
<%!
	public static String getClientIP(HttpServletRequest request){
	String ip= request.getHeader("X-FORWARDED-FOR");
	if(ip==null || ip.length()==0){
		ip=request.getHeader("Proxy-Client=IP");
	}
	if(ip==null || ip.length()==0){
		ip=request.getHeader("WL-Proxy-Client=IP");
	}
	if(ip==null || ip.length()==0){
		ip=request.getRemoteAddr();
	}
	return ip;
}
%>
<%
request.setCharacterEncoding("UTF-8");
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

String evaluationID = null;
if(request.getParameter("evaluationID")!=null){
	evaluationID=request.getParameter("evaluationID");
}
EvaluationDAO evaluationDAO = new EvaluationDAO();
LikeyDAO likeyDAO = new LikeyDAO();
int result = likeyDAO.like(userID, evaluationID, getClientIP(request));
if(result==1){
	result = evaluationDAO.like(evaluationID);
	if(result==1){
		PrintWriter sc = response.getWriter();
		sc.println("<script>");
		sc.println("alert('推薦完了しました。');");
		sc.println("location.href='index.jsp';");
		sc.println("</script>");
		sc.close();
		return;
	}else{
		PrintWriter sc = response.getWriter();
		sc.println("<script>");
		sc.println("alert('データベースError');");
		sc.println("history.back();");
		sc.println("</script>");
		sc.close();
		return;
	}
}else{
	PrintWriter sc = response.getWriter();
	sc.println("<script>");
	sc.println("alert('既に推薦しました。');");
	sc.println("history.back();");
	sc.println("</script>");
	sc.close();
	return;
}

%>
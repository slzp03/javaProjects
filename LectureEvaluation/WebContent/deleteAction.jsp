<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="evaluation.EvaluationDAO" %>
<%@ page import="likey.LikeyDTO" %>
<%@ page import="user.UserDAO" %>
<%
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
String evaluationID = null;
if(request.getParameter("evaluationID")!=null){
	evaluationID=request.getParameter("evaluationID");
}
EvaluationDAO evaluationDAO = new EvaluationDAO();
if(userID.equals(evaluationDAO.getUserID(evaluationID))){
	int result = new EvaluationDAO().delete(evaluationID);
	if(result ==1){
		PrintWriter sc = response.getWriter();
		sc.println("<script>");
		sc.println("alert('削除しました。');");
		sc.println("location.href = 'index.jsp';");
		sc.println("</script>");
		sc.close();
		return;
	}else{
		PrintWriter sc = response.getWriter();
		sc.println("<script>");
		sc.println("alert('Error 発行しました。');");
		sc.println("history.back();");
		sc.println("</script>");
		sc.close();
		return;
	}
}else{
	PrintWriter sc = response.getWriter();
	sc.println("<script>");
	sc.println("alert('自分の投稿だけ削除可能します。');");
	sc.println("history.back();");
	sc.println("</script>");
	sc.close();
	return;
}
%>
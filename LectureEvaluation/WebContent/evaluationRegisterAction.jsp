<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="evaluation.EvaluationDTO" %>  
<%@ page import="evaluation.EvaluationDAO" %>
<%@ page import="util.SHA256" %>
<%@ page import="java.io.PrintWriter" %>

<%
request.setCharacterEncoding("UTF-8");
String userID=null;

if(session.getAttribute("userID")!=null){
	userID=(String)session.getAttribute("userID");
}
if(userID==null){
	PrintWriter sc = response.getWriter();
	sc.println("<script>");
	sc.println("alert('LOGINしてください。');");
	sc.println("location.href = 'userLogin.jsp';");
	sc.println("</script>");
	sc.close();
	return;
}

 
 String lectureName = null;
 String professorName= null;
 int lectureYear = 0;
 String semesterDivide= null;
 String lectureDivide= null;
 String evaluationTitle= null;
 String evaluationContent= null;
 String totalScore= null;
 String creditScore= null;
 String comfortableScore= null;
 String lectureScore= null;

if(request.getParameter("lectureName")!=null){
	lectureName=request.getParameter("lectureName");
}
if(request.getParameter("professorName")!=null){
	professorName=request.getParameter("professorName");
}
if(request.getParameter("lectureYear")!=null){
	try{
		lectureYear=Integer.parseInt(request.getParameter("lectureYear"));
	}catch(Exception e){
		e.printStackTrace();
	}
	
}
if(request.getParameter("semesterDivide")!=null){
	semesterDivide=request.getParameter("semesterDivide");
}
if(request.getParameter("lectureDivide")!=null){
	lectureDivide=request.getParameter("lectureDivide");
}
if(request.getParameter("evaluationTitle")!=null){
	evaluationTitle=request.getParameter("evaluationTitle");
}
if(request.getParameter("evaluationContent")!=null){
	evaluationContent=request.getParameter("evaluationContent");
}
if(request.getParameter("totalScore")!=null){
	totalScore=request.getParameter("totalScore");
}
if(request.getParameter("creditScore")!=null){
	creditScore=request.getParameter("creditScore");
}
if(request.getParameter("comfortableScore")!=null){
	comfortableScore=request.getParameter("comfortableScore");
}
if(request.getParameter("lectureScore")!=null){
	lectureScore=request.getParameter("lectureScore");
}
//System.out.println("lectureName : "+lectureName);
//System.out.println("professorName : "+professorName);
//System.out.println("lectureYear : "+lectureYear);
//System.out.println("semesterDivide : "+semesterDivide);
//System.out.println("lectureDivide : "+lectureDivide);
//System.out.println("evaluationTitle : "+evaluationTitle);
//System.out.println("evaluationContent : "+evaluationContent);
//System.out.println("totalScore : "+totalScore);
//System.out.println("creditScore : "+creditScore);
//System.out.println("comfortableScore : "+comfortableScore);
//System.out.println("lectureScore : "+lectureScore);
if(lectureName ==null || professorName == null || lectureYear==0 || semesterDivide == null
 || lectureDivide == null || evaluationTitle == null || evaluationContent == null || totalScore == null
 || creditScore == null || comfortableScore == null || lectureScore == null || evaluationContent.equals("")||evaluationTitle.equals("")){
	
	PrintWriter sc = response.getWriter();
	sc.println("<script>");
	sc.println("alert('入力内容が必要です。');");
	sc.println("history.back();");
	sc.println("</script>");
	sc.close();
	return;
	
}

EvaluationDAO evaluationDAO = new EvaluationDAO();
int result = evaluationDAO.write(new EvaluationDTO(0, userID, lectureName, professorName, lectureYear,
		semesterDivide, lectureDivide, evaluationTitle, evaluationContent,
		totalScore, creditScore, comfortableScore, lectureScore,0));
if(result ==-1){
	PrintWriter sc = response.getWriter();
	sc.println("<script>");
	sc.println("alert('登録失敗しました。');");
	sc.println("history.back();");
	sc.println("</script>");
	sc.close();
	return;
}else{
	PrintWriter sc = response.getWriter();
	sc.println("<script>");
	sc.println("location.href = 'index.jsp';");
	sc.println("</script>");
	sc.close();
	return;
}

%>
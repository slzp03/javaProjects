<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="evaluation.EvaluationDTO" %>
<%@ page import="evaluation.EvaluationDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
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
	request.setCharacterEncoding("UTF-8");
	String lectureDivide = "全て";
	String searchType = "最新";
	String search = "";
	int pageNumber=0;
	if(request.getParameter("lectureDivide")!=null){
		lectureDivide=request.getParameter("lectureDivide");
	}
	if(request.getParameter("searchType")!=null){
		searchType=request.getParameter("searchType");
	}
	if(request.getParameter("search")!=null){
		search=request.getParameter("search");
	}
	if(request.getParameter("pageNumber")!=null){
		try{
			pageNumber=Integer.parseInt(request.getParameter("pageNumber"));
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	String userID=null;
	if(session.getAttribute("userID")!=null){
		userID=(String)session.getAttribute("userID");
	}
	if(userID==null){
		PrintWriter sc = response.getWriter();
		sc.println("<script>");
		sc.println("alert('LOGINしてください。');");
		sc.println("location.href='userLogin.jsp';");
		sc.println("</script>");
		sc.close();
		return;
	}
	boolean emailChecked = new UserDAO().getUserEmailChecked(userID);
	
	if(emailChecked==false){
		PrintWriter sc = response.getWriter();
		sc.println("<script>");
		sc.println("location.href='emailSendConfirm.jsp';");
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
    <form action = "./index.jsp" method="get" class="form-inline my-2 my-lg-0">
      <input type = "text" name="search" class="form-control mr-sm-2" type="search" placeholder="内容入力" aria-label="Search">
      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">検索</button>
    </form>
  </div>
</nav>

<section class="container">
	<form method="get" action ="./index.jsp" class="form-inline mt-3">
		<select name="lectureDivide" class="form-control mx-1 mt-2">
			<option value="全て">全て</option>
			<option value="専攻"<%if(lectureDivide.equals("専攻")) out.println("selected"); %>>専攻</option>
			<option value="教養"<%if(lectureDivide.equals("教養")) out.println("selected"); %>>教養</option>
			<option value="残り"<%if(lectureDivide.equals("残り")) out.println("selected"); %>>残り</option>
		</select>
		<select name="searchType" class="form-control mx-1 mt-2">
			<option value="最新">最新</option>
			<option value="推薦"<%if(searchType.equals("推薦")) out.println("selected"); %>>推薦</option>
		</select>
		<input type="text" name="search" class="form-control mx-1 mt-2" placeholder="入力">
		<button type="submit" class="btn btn-primary mx-1 mt-2">検索</button>
		<a class="btn btn-primary mx-1 mt-2" data-toggle="modal" href="#registerModal">登録</a>
		<a class="btn btn-danger mx-1 mt-2" data-toggle="modal" href="#reportModal">信号</a>
	</form>
<%
ArrayList<EvaluationDTO> evaluationList = new ArrayList<EvaluationDTO>();
evaluationList = new EvaluationDAO().getList(lectureDivide, searchType, search, pageNumber);
if(evaluationList != null)
	for(int i=0;i<evaluationList.size();i++){
		if(i==5)break;
		EvaluationDTO evaluation = evaluationList.get(i);
	
%>
<div>
	<div class="card bg-light mt-3">
		<div class="card-header bg-light">
			<div class="row">
				<div class="col-8 text-left"><%= evaluation.getLectureName() %>&nbsp;<small><%= evaluation.getProfessorName() %></small></div>
				<div class="col-4 text-right">まとめ&nbsp;<span style="color:red;"><%= evaluation.getTotalScore() %></span></div>
			</div>
		</div>
		<div class="card-body">
		<h5 class="card-title"><%= evaluation.getEvaluationTitle() %>&nbsp;
			<small><%= evaluation.getLectureYear() %>年<%= evaluation.getSemesterDivide() %></small>
		</h5>
		<p class="card-text"><%= evaluation.getEvaluationContent() %></p>
		<div class="row">
			<div class="col-9 text-left">
				成績<span style="color:red;"><%= evaluation.getCreditScore() %></span>
				楽々<span style="color:red;"><%= evaluation.getComfortableScore() %></span>
				講義<span style="color:red;"><%= evaluation.getLectureScore() %></span>
				<span style="color:green;">推薦：<%= evaluation.getLikeCount() %>人</span>
			</div>
			<div class="col-3 text-right">
				<a onclick="return confirm('推薦するか？')" href="./likeAction.jsp?evaluationID=<%= evaluation.getEvaluationID()%>">推薦</a>
				<a onclick="return confirm('削除するか？')" href="./deleteAction.jsp?evaluationID=<%= evaluation.getEvaluationID()%>">削除</a>
			</div>
		</div>
	</div>
	</div>
	</div>
<%}%>
	
</section>
<ul class="pagination justify-content-center mt-3">
	<li class="page-item">
	<%
	if(pageNumber<=0){
	%>
	<a class="page-link disabled">以前</a>
	<%
	}else{
	%>
	<a class="page-link" href="./index.jsp?lectureDivide=<%=URLEncoder.encode(lectureDivide,"UTF-8") %>&searchType = <%=URLEncoder.encode(searchType,"UTF-8")%>
	&search=<%=URLEncoder.encode(search,"UTF-8")%>&pageNumber=<%=pageNumber-1%>">以前</a>
	<%
	}
	%>
	</li>
	<li>
	<%
	if(evaluationList.size()<6){
	%>
	<a class="page-link disabled">以降</a>
	<%
	}else{
	%>
	<a class="page-link" href="./index.jsp?lectureDivide=<%=URLEncoder.encode(lectureDivide,"UTF-8") %>&searchType = <%=URLEncoder.encode(searchType,"UTF-8")%>
	&search=<%=URLEncoder.encode(search,"UTF-8")%>&pageNumber=<%=pageNumber+1%>">以降</a>
	<%
	}
	%>
	</li>
</ul >
<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="modal">評価登録</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form action="./evaluationRegisterAction.jsp" method="post">
					<div class="form-row">
						<div class="form-group col-sm-6">
							<label>講義名</label>
							<input type="text" name="lectureName" class="form-control" maxlength="20">
						</div>
						<div class="form-group col-sm-6">
							<label>教授名</label>
							<input type="text" name="professorName" class="form-control" maxlength="20">
						</div>
					</div>
					<div class="form-row">
						<div class="form-group col-sm-4">
							<label>年</label>
							<select name="lectureYear" class="form-control">
								<option value="2011">2011</option>
								<option value="2012">2012</option>
								<option value="2013">2013</option>
								<option value="2014">2014</option>
								<option value="2015">2015</option>
								<option value="2016">2016</option>
								<option value="2017">2017</option>
								<option value="2018">2018</option>
								<option value="2019">2019</option>
								<option value="2020">2020</option>
								<option value="2021" selected>2021</option>
								<option value="2022">2022</option>
							</select>							
						</div>
						<div class="form-group col-sm-4">
							<label>学期</label>
							<select name="semesterDivide" class="form-control">
								<option value="1学期" selected>1学期</option>
								<option value="2学期">2学期</option>
								<option value="夏学期">夏学期</option>
								<option value="冬学期">冬学期</option>
							</select>
						</div>
						<div class="form-group col-sm-4">
							<label>講義区分</label>
							<select name="lectureDivide" class="form-control">
								<option value="専攻" selected>専攻</option>
								<option value="教養">教養</option>
								<option value="基礎">基礎</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label>題名</label>
						<input type="text" name="evaluationTitle" class="form-control" maxlength="30">
					</div>
					<div class="form-group">
						<label>内容</label>
						<textarea name="evaluationContent" class="form-control" maxlength="2048" style="height:180px;"></textarea>
					</div>
					<div class="form-row">
						<div class="form-group col-sm-3">
							<label>まとめ</label>
							<select name="totalScore" class="form-control">
								<option value="A" selected>A</option>
								<option value="B" selected>B</option>
								<option value="C" selected>C</option>
								<option value="D" selected>D</option>
								<option value="F" selected>F</option>
							</select>
						</div>
						<div class="form-group col-sm-3">
							<label>成績</label>
							<select name="creditScore" class="form-control">
								<option value="A" selected>A</option>
								<option value="B" selected>B</option>
								<option value="C" selected>C</option>
								<option value="D" selected>D</option>
								<option value="F" selected>F</option>
							</select>
						</div>
						<div class="form-group col-sm-3">
							<label>楽々</label>
							<select name="comfortableScore" class="form-control">
								<option value="A" selected>A</option>
								<option value="B" selected>B</option>
								<option value="C" selected>C</option>
								<option value="D" selected>D</option>
								<option value="F" selected>F</option>
							</select>
						</div>
						<div class="form-group col-sm-3">
							<label>出席</label>
							<select name="lectureScore" class="form-control">
								<option value="A" selected>A</option>
								<option value="B" selected>B</option>
								<option value="C" selected>C</option>
								<option value="D" selected>D</option>
								<option value="F" selected>F</option>
							</select>
						</div>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-primary">登録</button>
						<button type="button" class="btn btn-secondary" data-dismiss="modal">取り消し</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="modal">信号する</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form action="./reportAction.jsp" method="post">
					
					<div class="form-group">
						<label>信号題名</label>
						<input type="text" name="reportTitle" class="form-control" maxlength="30">
					</div>
					<div class="form-group">
						<label>信号内容</label>
						<textarea name="reportContent" class="form-control" maxlength="2048" style="height:180px;"></textarea>
					</div>
					
					<div class="modal-footer">
						<button type="submit" class="btn btn-danger">信号する</button>
						<button type="button" class="btn btn-secondary" data-dismiss="modal">取り消し</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<footer class="bg-dark mt-3 p-5 text-center" style="color:#ffffff;">
	CopyRight &copy; 2021 キムさん　ALL Rights Reserved.
</footer>

		<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" ></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" ></script>
	
	
	
</body>
</html>
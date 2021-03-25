<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

<section class="container">
	<form method="get" action ="./index.jsp" class="form-inline mt-3">
		<select name="LectureDivide" class="form-control mx-1 mt-2">
			<option value="全部">全部</option>
			<option value="専攻">専攻</option>
			<option value="教養">教養</option>
			<option value="残り">残り</option>
		</select>
		<input type="text" name="search" class="form-control mx-1 mt-2" placeholder="入力">
		<button type="submit" class="btn btn-primary mx-1 mt-2">検索</button>
		<a class="btn btn-primary mx-1 mt-2" data-toggle="modal" href="#registerModal">登録</a>
		<a class="btn btn-danger mx-1 mt-2" data-toggle="modal" href="#reportModal">信号</a>
	</form>
	<div class="card bg-light mt-3">
		<div class="card-header bg-light">
			<div class="row">
				<div class="col-8 text-left">HipHop&nbsp;<small>キムさん</small></div>
				<div class="col-4 text-right">まとめ&nbsp;<span style="color:red;">A</span></div>
			</div>
		</div>
		<div class="card-body">
		<h5 class="card-title">JUSTHIS&nbsp;
			<small>(2020・1学期)</small>
		</h5>
		<p class="card-text">im gone 나지금 내앞에 있는널 웃기기가싫어 진지하면 싫어하는 니가 나도 싫어 그만 듣고싶어 매일죽고싶다 하거나 죽여버리고 싶다고 하거나 난 떠나</p>
		<div class="row">
			<div class="col-9 text-left">
				成績<span style="color:red;">A</span>
				楽々<span style="color:red;">B</span>
				講義<span style="color:red;">C</span>
				<span style="color:green;">推薦：14人</span>
			</div>
			<div class="col-3 text-right">
				<a onclick="return confirm('推薦するか？')" href="./likeAction.jsp?evaluationID=">推薦</a>
				<a onclick="return confirm('削除するか？')" href="./deleteAction.jsp?evaluationID=">削除</a>
			</div>
		</div>
	</div>
	</div>
	
	<div class="card bg-light mt-3">
		<div class="card-header bg-light">
			<div class="row">
				<div class="col-8 text-left">HipHop&nbsp;<small>キムさん</small></div>
				<div class="col-4 text-right">まとめ&nbsp;<span style="color:red;">A+</span></div>
			</div>
		</div>
		<div class="card-body">
		<h5 class="card-title">GONE&nbsp;
			<small>(2020・2学期)</small>
		</h5>
		<p class="card-text">내 곡도 될까 스테디 셀러가 다 떠나고 나서야 소비하려고 하니까 자살율이 높다는건 죽을일이 자살밖에 없다는 거지 그러니까 평화롭다는 거지</p>
		<div class="row">
			<div class="col-9 text-left">
				成績<span style="color:red;">A</span>
				楽々<span style="color:red;">B</span>
				講義<span style="color:red;">C</span>
				<span style="color:green;">推薦：13人</span>
			</div>
			<div class="col-3 text-right">
				<a onclick="return confirm('推薦するか？')" href="./likeAction.jsp?evaluationID=">推薦</a>
				<a onclick="return confirm('削除するか？')" href="./deleteAction.jsp?evaluationID=">削除</a>
			</div>
		</div>
	</div>
	</div>
	
	<div class="card bg-light mt-3">
		<div class="card-header bg-light">
			<div class="row">
				<div class="col-8 text-left">HipHop&nbsp;<small>キムさん</small></div>
				<div class="col-4 text-right">まとめ&nbsp;<span style="color:red;">A++</span></div>
			</div>
		</div>
		<div class="card-body">
		<h5 class="card-title">(2019year)&nbsp;
			<small>(2021・1学期)</small>
		</h5>
		<p class="card-text">그러니까 내가 살아있는건 정상이니까지 그러니까 너가 삻아있는건 정상이니까지 그러니우리가 살아있는건 정상이니까지 그러니까 살아있다는건 정상이니까지</p>
		<div class="row">
			<div class="col-9 text-left">
				成績<span style="color:red;">A</span>
				楽々<span style="color:red;">B</span>
				講義<span style="color:red;">C</span>
				<span style="color:green;">推薦：12人</span>
			</div>
			<div class="col-3 text-right">
				<a onclick="return confirm('推薦するか？')" href="./likeAction.jsp?evaluationID=">推薦</a>
				<a onclick="return confirm('削除するか？')" href="./deleteAction.jsp?evaluationID=">削除</a>
			</div>
		</div>
	</div>
	</div>
	<div class="card bg-light mt-3">
		<div class="card-header bg-light">
			<div class="row">
				<div class="col-8 text-left">HipHop&nbsp;<small>キムさん</small></div>
				<div class="col-4 text-right">まとめ&nbsp;<span style="color:red;">S</span></div>
			</div>
		</div>
		<div class="card-body">
		<h5 class="card-title">GOOOOOD&nbsp;
			<small>(2021・2学期)</small>
		</h5>
		<p class="card-text">i spittin' better than 99% rappers in 한국 인정해 랩으로 내가 에미넴 근데 얘네들 랩은 왼쪽 아래 자막 뺴면 개소린데 읽어면 더 개소린데 나보다 버는데 배로 내가여기서 뭘 왜더해 I'm Gone</p>
		<div class="row">
			<div class="col-9 text-left">
				成績<span style="color:red;">A</span>
				楽々<span style="color:red;">B</span>
				講義<span style="color:red;">C</span>
				<span style="color:green;">推薦：12人</span>
			</div>
			<div class="col-3 text-right">
				<a onclick="return confirm('推薦するか？')" href="./likeAction.jsp?evaluationID=">推薦</a>
				<a onclick="return confirm('削除するか？')" href="./deleteAction.jsp?evaluationID=">削除</a>
			</div>
		</div>
	</div>
	</div>	
	
	
</section>


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
							<select name="lecturYear" class="form-control">
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
						<button type="submit" class="btn btn-danger">登録</button>
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
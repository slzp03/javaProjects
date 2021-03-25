<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${del==1 }">
	<script>
		alert("退会しました。");
	</script>
	<% session.invalidate(); %>
</c:if>
<!DOCTYPE html>
<html lang="ja">
<head>

<!-- META -->

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="Author" content="사이트 저작자">
<meta name="Keywords" content="검색 엔진을 위한 키워드">
<meta name="Description" content="사이트에 대한 설명">

<!-- RESPONSIVE -->

<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1, user-scalable=no">

<!-- SCRIPT -->

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<!--<script src="경로" type="text/javascript"></script>-->

<!-- STYLESHEET -->

<link href="HBG/styles/base.css" type="text/css" rel="stylesheet">
<link href="HBG/styles/layout.css" type="text/css" rel="stylesheet">
<link href="HBG/styles/module.css" type="text/css" rel="stylesheet">
<link href="HBG/styles/states.css" type="text/css" rel="stylesheet">
<link href="HBG/styles/theme.css" type="text/css" rel="stylesheet">

<!-- TITLE -->

<title>アプリ紹介</title>
<style>
    
</style>
</head>
<body>
  
    <div class="layout-wrap">
        <div class="layout-inner">

            <%@ include file="HBG/include/hbg-header.jsp" %>
            
            <div id="hbg-index">
                <div class="content-1">
                    <div class="content1-1">
                      <video width="320" height="240" autoplay class="preview" muted
                      loop="loop">

            <source src="HBG/styles/images/Day.mp4" type="video/mp4">

            </video>
                        <div class="index-title">
                            <h4>易くて簡単なスケジュール管理システム</h4>
                            <br><br><br>
                            <h5>LET'S PLANNING SCHEDULE</h5>
                        </div>
                    </div>
                    <a href="hbg?command=login.go" class="text">はじめに</a>
                </div>
                <div class="mountain">
                    <img>
                    <p><span class="txt1">WEB・MOBILE&nbsp;同時支援</span><br><br><br>
                    <span class="txt1-1">自分の&nbsp;好みで,<br><br><br>積みて使う&nbsp;プランナー</span><br><br><br>
	                   <span class="txt2">無料サービス提供<br><br>カレンダー・メモ・テークリストを&nbsp;&nbsp;一緒に&nbsp;&nbsp;使う&nbsp;&nbsp;ことが&nbsp;&nbsp;できる&nbsp;&nbsp;総合&nbsp;&nbsp;プランナー&nbsp;&nbsp;プログラム<br><br>
                        共有機能で&nbsp;&nbsp;あなたの&nbsp;&nbsp;プランナーを&nbsp;&nbsp;共有する&nbsp;&nbsp;ことが&nbsp;&nbsp;できる。</span></p>
                </div>
              
                <div class="content-3">
                    <div class="content-3-1">
                        <img src="HBG/styles/images/global.png">
                    </div>
                    <div class="content-3-2">
                        <h1>Share a schedule</h1>
                        <span>上部の&nbsp;&nbsp;共有ボタンを&nbsp;&nbsp;推して&nbsp;&nbsp;世界の&nbsp;&nbsp;どこでも共有できる。<br>スケジュールを&nbsp;&nbsp;ボタン一つで&nbsp;&nbsp;簡単に&nbsp;&nbsp;共有しませんか。</span>
                    </div>
                </div>
                <div class="content-4">
                    <div class="content-4-1">
                       <h1>Change of your style</h1>
                       <span>スライドの&nbsp;&nbsp;機能を&nbsp;&nbsp;利用する&nbsp;&nbsp;プランナー&nbsp;&nbsp;位置&nbsp;&nbsp;編集<br>一つの&nbsp;&nbsp;ページで&nbsp;&nbsp;プランナー&nbsp;&nbsp;構成&nbsp;&nbsp;及び&nbsp;&nbsp;追加、削除を<br>する&nbsp;&nbsp;ことが&nbsp;&nbsp;できる。</span>
                    </div>
                    <div class="content-4-2">
                        <img src="HBG/styles/images/webck.png">
                    </div>
                </div>
                <div class="content-5">
                    <div class="content-5-1">
                           <img src="HBG/styles/images/alarm2.png">
    
                        
                    </div>
                    <div class="content-5-2">
                        <h1>Search and Alarm</h1>
                        <span>キーワードで&nbsp;&nbsp;プランナーの&nbsp;&nbsp;全て&nbsp;&nbsp;サービスを&nbsp;&nbsp;ページ内で&nbsp;&nbsp;検索&nbsp;&nbsp;可能<br> プランナーと&nbsp;&nbsp;演動で&nbsp;&nbsp;投稿&nbsp;&nbsp;追加、削除、修正し&nbsp;&nbsp;通知が<br>出ます。&nbsp;&nbsp;共有機能を&nbsp;&nbsp;使って&nbsp;&nbsp;お互いに&nbsp;&nbsp;修正することが&nbsp;<br>速く&nbsp;&nbsp;できる。 </span>
                    </div>
                </div>               
               <!--<div class="content-6">
                    <div class="content-6-1">
                        <a>일정 관리를 무료로 <br>사용하는 <br>방법</a>
                    </div>
                    <div class="content-6-2">
                        <h2>쉽고 간편한 스케줄러를 작성하는 방법!</h2>
                            <ul>
                                <li><i class="material-icons">done</i>서비스 페이지에 들어간다</li>
                                <li><i class="material-icons">done</i>캘린더 / 메모 / 체크리스트 중 서비스 기능을 선택한다</li>
                                <li><i class="material-icons">done</i>원하는 날짜에 내용을 입력하면 자동저장</li>
                            </ul>
                    </div>
                </div>-->
                <div class="content-7">
                    <h4>CONTACT</h4>
                    <h5>service@hamburgerplanner.co.jp</h5>
                    <h5>070-1234-5678</h5>
                    <h5>光が丘駅</h5>
                </div>
              
            </div><!-- END INDEX -->
            
            <%@ include file="HBG/include/hbg-footer.jsp" %>
            
            <div class="btn-top" style="cursor:pointer;" onclick="javascript: indexTop()">TOP</div>
		    <script>
		        function indexTop() {
		            $('html, body').animate({
		               scrollTop: 0 
		            }, 2000);
		        }
		    </script>
        </div>
    </div><!-- END WRAP END -->

</body>
</html>
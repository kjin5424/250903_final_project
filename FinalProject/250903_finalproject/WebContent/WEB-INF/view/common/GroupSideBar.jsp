<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	HttpSession session_import = request.getSession();
	String groupApplyCode = (String)session_import.getAttribute("groupApplyCode");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공모자들 - 모임 홈</title>
    
    <!-- CSS -->
    <link rel="stylesheet" href="css_new/common_sample.css">
    <link rel="stylesheet" href="css_new/topmenubar_sample.css">
    <link rel="stylesheet" href="css_new/home_sample.css">
    <link rel="stylesheet" href="css_new/sidebar.css">

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body onload="InitializeStaticMenu();">

<!-- 왼쪽 플로팅 사이드바 -->
<div class="floating-sidebar staticmenu">
    <div class="sidebar-header">
        <h3>
        	<a href="home.do?groupApplyCode=<%=groupApplyCode%>">🏠모임 홈</a>
        </h3>
    </div>
    <ul class="sidebar-menu">
        <li><a href="postlist.do?groupApplyCode=<%=groupApplyCode%>">📋 게시판</a></li>
        <li><a href="challengelist.do?groupApplyCode=<%=groupApplyCode%>">🏆 도전과제</a></li>
        <li><a href="memberlist.do?groupApplyCode=<%=groupApplyCode%>"> 👥 모임원</a></li>
        <li><a href="messagelist.do?groupApplyCode=<%=groupApplyCode%>"> ✉️ 쪽지</a></li>
        <li><a href="managelist.do?groupApplyCode=<%=groupApplyCode%>"> ⚙️ 관리</a></li>
    </ul>
    <div class="sidebar-toggle-btn">메뉴</div>
</div>

<script type="text/javascript">
 var stmnLEFT = 10;
 var stmnGAP1 = 0;
 var stmnGAP2 = 150;
 var stmnBASE = 150;
 var stmnActivateSpeed = 35;
 var stmnScrollSpeed = 20;
 var stmnTimer; 

 function RefreshStaticMenu() { 
  var menu = document.querySelector('.staticmenu');
  if (!menu) return;

  var stmnStartPoint = parseInt(menu.style.top, 10) || 0;
  var stmnEndPoint = Math.max(document.documentElement.scrollTop, document.body.scrollTop) + stmnGAP2;

  if (stmnEndPoint < stmnGAP1) stmnEndPoint = stmnGAP1;

  if (stmnStartPoint != stmnEndPoint) { 
   var stmnScrollAmount = Math.ceil(Math.abs(stmnEndPoint - stmnStartPoint) / 15);
   menu.style.top = (stmnStartPoint + ((stmnEndPoint < stmnStartPoint) ? -stmnScrollAmount : stmnScrollAmount)) + 'px';
  }
  stmnTimer = setTimeout(RefreshStaticMenu, stmnActivateSpeed);
 }

 function InitializeStaticMenu() {
  var menu = document.querySelector('.staticmenu');
  if (!menu) return;

  menu.style.right = stmnLEFT + 'px';
  menu.style.top = (document.body.scrollTop + stmnBASE) + 'px';
  menu.style.position = 'absolute';

  RefreshStaticMenu();
 }
</script>

</body>
</html>

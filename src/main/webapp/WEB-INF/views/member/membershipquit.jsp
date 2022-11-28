<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page import="java.net.URLDecoder"%>
<%@ page session="false" %>
<c:set var="loginId" value="${request.getSession(false)=='' ? '' : pageContext.request.session.getAttribute('c_id')}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>OTTProject - Membership Quit</title>
	<link rel="stylesheet" href="<c:url value='/css/menu.css'/>">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
	<style>
		* { box-sizing:border-box; }
		a { text-decoration: none; }
		form {
			width:400px;
			height:600px;
			display : flex;
			flex-direction: column;
			align-items:center;
			position : absolute;
			top:50%;
			left:50%;
			transform: translate(-50%, -50%) ;
			border: 1px solid rgb(89,117,196);
			border-radius: 10px;
		}
		input[type='text'], input[type='password'] {
			width: 300px;
			height: 40px;
			border : 1px solid rgb(89,117,196);
			border-radius:5px;
			padding: 0 10px;
			margin-bottom: 10px;
		}
		button {
			background-color: rgb(89,117,196);
			color : white;
			width:300px;
			height:50px;
			font-size: 17px;
			border : none;
			border-radius: 5px;
			margin : 20px 0 30px 0;
		}
		#title {
			font-size : 50px;
			margin: 40px 0 30px 0;
		}
		#msg {
			height: 30px;
			text-align:center;
			font-size:16px;
			color:red;
			margin-bottom: 20px;
		}
		.td_No_1{
			width: 50px;
		}
		.td_No_2{
			width: 200px;
		}
		.td_No_3{
			width: 150px;
		}
	</style>
</head>
<body>
<div id="menu">
	<ul>
		<li id="logo">OTT</li>
		<li><a href="<c:url value='/'/>">Home</a></li>
		<li><a href="<c:url value='/board/list'/>">Board</a></li>
		<li><a href="<c:url value='${loginOutLink}'/>">${loginOut}</a></li>
		<li><a href="<c:url value='/register/add'/>">Sign in</a></li>
		<li><a href=""><i class="fa fa-search"></i></a></li>
	</ul>
</div>
	<form action="/customer/withdrwal" method="post">
	
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		
		<div class="title"><h2>Membership</h2></div>
		
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		
		<label for="">プランを解約しますか？</label>
		
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		
		<!-- 추후 #c_id의 value는 로그인 후 회원정보에서 가져온 id를 넣도록 -->
		<input type="hidden" id="c_id" name="c_id" value="${loginId}">
		
		<button style="background-color: red;">解約</button>
	</form>
	<script>
	
		
		
	</script>
</body>
</html>
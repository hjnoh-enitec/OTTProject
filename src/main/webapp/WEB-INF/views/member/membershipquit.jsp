<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
	<link rel="shortcut icon" href="/img/logo.png">
	<style>
		* { box-sizing:border-box; }
		a { text-decoration: none; }

		form {
			width:400px;
			height: 500px;
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

		button {
			background-color: rgb(89,117,196);
			color : white;
			width:200px;
			height:50px;
			font-size: 17px;
			border : none;
			border-radius: 5px;
			margin : 20px 0 30px 0;
		}
		#title {
			margin: 40px 0 30px 0;
		}

	</style>
</head>
<body>
<%//@ include file="/jsp/home/header.jsp"%>

<div>
	<form action="/customer/withdrwal" method="post">

		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		
		<div id="title"><h1>プランを解約しますか？</h1></div>
		
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		
		<!-- 추후 #c_id의 value는 로그인 후 회원정보에서 가져온 id를 넣도록 -->
		<input type="hidden" id="c_id" name="c_id" value="${loginId}">
		
		<button style="background-color: red;" type="submit">はい</button>
		<button style="background-color: blue;" type="button" onclick="back()">いいえ</button>
	</form>
</div>
	

	<script>
		function back(){
			history.go(-1);
		}
	</script>
	
</body>
</html>
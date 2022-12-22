<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page session="false" %>
<%@ page import="java.net.URLDecoder"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:eval expression="@environment.getProperty('path.urlPath')"
	var="urlPath" />
<c:set var="c_id" value="${request.getSession(false)=='' ? '' : pageContext.request.session.getAttribute('c_id')}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>login</title>
	<link rel="stylesheet" href="<c:url value='/css/menu.css'/>">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
	<link rel="shortcut icon" href="/img/logo.png">
	<style>
		* { box-sizing:border-box; }
		a { text-decoration: none; }
		form {
			width:500px;
			height:500px;
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
			width:200px;
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
	</style>
</head>
<body>
	<form action ="<c:url value="/modify/modify"/>" method="post" onsubmit="return formCheck(this);">
	<h3 id="title">パスワードを<br>入力してください</h3>
	<div id="msg">
		${param.msg}
	</div>
						<input type="hidden" id="urlPath" value="${urlPath}">
	<input type="hidden" name="c_id" value="${c_id}">
	<input type="password" name="c_pwd" placeholder="パスワード">
	<button>提出</button>
	<button type="button" onclick="move()">キャンセル</button>
	</form>
	<script>
		const urlPath = document.getElementById("urlPath");
		let url;
		function move() {
			history.go(-1);
		}
	
		function formCheck(frm) {
			let msg ='';
			if(frm.c_pwd.value.length==0) {
				setMessage('PWを入力してください', frm.c_pwd);
				return false;	
			}
			return true;
		}
		function setMessage(msg, element){
			document.getElementById("msg").innerHTML = ` ${'${msg}'}`;
			if(element) {
				element.select();
			}
		}
	</script>

</body>
</html>
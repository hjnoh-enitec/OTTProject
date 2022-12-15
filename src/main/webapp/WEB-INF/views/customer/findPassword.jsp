<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>findPassword</title>
	
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
	<style>
		* { box-sizing:border-box; }
		a { text-decoration: none; }
		form {
			width:400px;
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
	</style>
</head>
<body>
<form action="<c:url value="/find/sendCheckedMail"/>" method="post" onsubmit="return formCheck(this);">
	<h3 id="title">Login</h3>
	<input type="text" id="c_id" name="c_id" value="" placeholder="E-MAIL" autofocus>
	<input type="text" name="toURL" value="${param.toURL}">
	<input type="text" value="<c:url value="/find/sendCheckedMail"/>">
	<button>認証メール送る</button>
</form>
<script>
	function formCheck(frm) {
		let c_id = document.getElementById("c_id");
		if(c_id.value == ""){
			alert('メールを入力してください。');
			return false;
		}
		return true;
	}
</script>
</body>
</html>
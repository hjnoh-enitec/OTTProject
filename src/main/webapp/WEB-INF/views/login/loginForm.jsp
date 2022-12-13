<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page session="false" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="stylesheet" href="/css/login.css?ver=1">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
</head>
<body>
	
	
	<section class="LoginSection">
		<div class="LoginDiv">
			<div class="title">
				<h1>LogIn</h1>
				
			</div>
			<div class="form">
				<form action="/login/login" method="post" id="f">
					<input type="text" name="toURL" value="${toURL}"/>
					<p>
					<input type="text" name="c_id"  value="${cookie.c_id.value}" placeholder="E-MAIL" autofocus>
					</p>
					<p>
					<input type="password" name="c_pwd" placeholder="パスワード">
						<br>
						<font color="white" id="emptycheck"></font>
					</p>
					<p>
					<input type="submit" value="LogIn">
					<br>
					<input type="checkbox" id="infoCk" name="rememberId" value="on" ${empty cookie.c_id.value ? "":"checked"}>
					<label for="infoCk">IDを保存</label>
					<p>
					<br>
				</form>
			</div>
		
			
			<div class="joinQ">
			<a href="/register/signup">新規登録</a>
			<br/><a href="/find/id">IDを忘れた方様</a> |
			<a href="/find/pwd">パスワードを忘れた方様</a> 
			
			</div>
</div>
	</section>
</body>
</html>
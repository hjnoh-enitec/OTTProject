<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page session="false" %>
<%@ page import="java.net.URLDecoder"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>メールチェック</title>
<link rel="stylesheet" href="<c:url value='/css/menu.css'/>">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
<style>
* { box-sizing:border-box; }
.content{
			width:600px;
			height:300px;
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
button{
			background-color: rgb(89,117,196);
			color : white;
			width:200px;
			height:40px;
			font-size: 17px;
			border : none;
			border-radius: 5px;
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
	<div class="content">
	<h1>登録はまた終わっていません</h1>
	<h2><b>${c_id}</b>にメールを送りました<br/>メールを確認して新規登録を終えてください。</h2>
	<button type="button" onclick="location.href='/token/signUp?c_id=${c_id}'">メール再送</button>
	<button type="button" onclick="location.href='/login/login'">ログイン</button>
	</div>
</div>
</body>
</html>
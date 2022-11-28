<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
* {
	box-sizing: border-box;
}
form {
	width: 400px;
	height: 600px;
	display: flex;
	flex-direction: column;
	align-items: center;
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	border: 1px solid rgb(89, 117, 196);
	border-radius: 10px;
}
.input-field {
	width: 300px;
	height: 40px;
	border: 1px solid rgb(89, 117, 196);
	border-radius: 5px;
	padding: 0 10px;
	margin-bottom: 10px;
}
input[type='text'], input[type='password'] {
			width: 300px;
			height: 40px;
			border : 1px solid rgb(89,117,196);
			border-radius:5px;
			padding: 0 10px;
			margin-bottom: 10px;
		}
label {
	width: 300px;
	height: 30px;
	margin-top: 4px;
}
button {
	background-color: rgb(89, 117, 196);
	color: white;
	width: 300px;
	height: 50px;
	font-size: 17px;
	border: none;
	border-radius: 5px;
	margin: 20px 0 30px 0;
}
.title {
	font-size: 50px;
	margin: 40px 0 30px 0;
}
.msg {
	height: 30px;
	text-align: center;
	font-size: 16px;
	color: red;
	margin-bottom: 20px;
}
.sns-chk {
	margin-top: 5px;
}
</style>
</head>
<body>
<form action="<c:url value="/find/pwd"/>" method="post"  onsubmit ="formCheck(this)">
	<h3 id="title">ChangePassword</h3>
	<div id="msg">
		<c:if test="${not empty param.msg}">
			<i class="fa fa-exclamation-circle"> ${URLDecoder.decode(param.msg)}</i>
		</c:if>
	</div>
	<input type="text" name = "c_id" value="${c_id}">
	<input type="password" name="c_pwd" value="${cookie.id.value}" placeholder="パスワード">
	<input type="password" name="rePassword" placeholder="パスワード確認">
	<input type="hidden" name="toURL" value="${param.toURL}">
	<button>パスワード変更</button>
	<script>
		let pwd = ${password};
		let cPwd = ${rePassword};
		if(pwd.equals(cPwd)){
			return true;
		}else{
			return false;
		}
	</script>
</form>
</body>
</html>
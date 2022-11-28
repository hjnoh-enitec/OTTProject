<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page import="java.net.URLDecoder"%>
<!DOCTYPE html>
<html lang="JP">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
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
<title>FindID</title>
</head>
<body>
	<!-- form action="<c:url value="/findId"/>" method="POST" onsubmit="return formCheck(this)"-->
	<form action="/find/id" onsubmit="return doAction()" method="POST">
		<div class="title">Find ID</div>
		<label for="">名前</label>
		<input class="input-field" type="text" name="c_name" id="c_name" placeholder="ex : 動画太郎">
		<label for="">生年月日</label>
		<input class="input-field" type="text" name="c_birth" id="c_birth" placeholder="ex : 20220101">
		<label for="">電話番号</label>
		<input class="input-field" type="text" name="c_phone" id="c_phone" placeholder="ex : 07012345678">
		<button>ID探し</button>
	</form>
	
	<script>
		function doAction() {
			let birthRegex = /^(19[0-9][0-9]|20\d{2})(0[0-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$/;
			let phoneRegex = new RegExp('^(0[7|8|9][0])([0-9]{4})([0-9]{4})$');
			
			var nameVal = document.getElementById("c_name").value;
			var birthVal = document.getElementById("c_birth").value;
			var phoneVal = document.getElementById("c_phone").value;
			if (nameVal.length < 3) {
				alert("check name");
				return false;
			}
			
			if (birthVal.length != 8 || birthRegex.test(birthVal) == false) {
				alert("check birth");
				return false;
			}
			
			if(phoneRegex.test(phoneVal) == false){
				alert("check phone number");
				return false;
			}
			
			return true;
		}
	</script>
</body>
</html>
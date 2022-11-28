<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page session="false" %>
<%@ page import="java.net.URLDecoder"%>
<!DOCTYPE html>
<html lang="en">
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

#checkDuplBtn {
	background-color: rgb(50, 200, 196);
	color: white;
	width: 70px;
	height: 25px;
	font-size: 5px;
	border: none;
	border-radius: 1px;
	margin: 0px 0 10px 0;
}

button {
	background-color: rgb(126, 126, 126);
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
<title>Register</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
</head>
<body>
	<!-- form action="<c:url value="/register/save"/>" method="POST" onsubmit="return formCheck(this)"-->
	<form:form action="/register/add" method="post"
		onchange="validInsert()" onkeypress="activeBtn()" id="frm">
		<div class="title">Register</div>
		<div id="msg" class="msg">
			<form:errors path="c_id" />
		</div>
		<label for="">ID
			&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
			&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
			<button id="checkDuplBtn" type="button" onclick="idCheck()">IDチェック</button>
		</label>
		<input class="input-field" type="text" id="c_id" name="c_id"
			placeholder="E-MAIL形式">
		<label for="">パスワード</label>
		<input class="input-field" type="password" name="c_pwd"
			placeholder="パスワード">
		<input class="input-field" type="password" name="c_pwd2"
			placeholder="再入力してください">
		<label for="">名前</label>
		<input class="input-field" type="text" name="c_name"
			placeholder="木村太郎">
		<label for="">携帯</label>
		<input class="input-field" type="number" name="c_phone"
			placeholder="`-`なし　例）09012345678">
		<label for="">生年月日</label>
		<input class="input-field" type="text" name="c_birth"
			placeholder="例)1990年06月02日 → 19900602">
		<div class="msg" id="idCheckMsg" style="margin-bottom: 0px">ID中腹チェックをした上に登録してください</div>
		<button id="submitBtn" disabled>新規登録</button>
	</form:form>

	<script>
	const submitBtn = document.getElementById("submitBtn");
	const checkDuplBtn = document.getElementById("checkDuplBtn");
	const frm = document.getElementById("frm");
	function activeBtn(){
	   if(frm.c_id.value.length>0
			   &&frm.c_pwd.value.length>0
			   &&frm.c_name.value.length>0
			   &&frm.c_phone.value.length>0
			   &&frm.c_birth.value.length>0
			   &&checkDuplBtn.disabled
			   ){
		   submitBtn.disabled = false;
		   submitBtn.style.backgroundColor='rgb(50, 200, 196)';
	   }else{
		   submitBtn.disabled = true;
		   submitBtn.style.backgroundColor='rgb(126, 126, 126)';
	   }
   }
   function validInsert() {
	   const emailCheck = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;	   
	   if(frm.c_id.value.match(emailCheck) == null){
		   setMessage('正しいメール形式を入力して下さい', frm.c_id);
		   
	   }
	   else if(frm.c_pwd2.value>0 && frm.c_pwd.value!==frm.c_pwd2.value) {　
           setMessage('pwdが一致しません', frm.c_pwd2);
       }
       else{
       	deleteMessage();
       }
	   activeBtn();
  }
   
  function setMessage(msg, element){
       document.getElementById("msg").innerHTML = `<i class="fa fa-exclamation-circle"> ${'${msg}'}</i>`;
       if(element) {
           element.select();
       }
  }
  
  function setMessage(msg){
      document.getElementById("msg").innerHTML = `<i class="fa fa-exclamation-circle"> ${'${msg}'}</i>`;
 }
  
  function deleteMessage(){
	   document.getElementById("msg").innerHTML = ``;
  }
  
  
  function idCheck() {
		const c_id = document.getElementById("c_id");
	  	$.ajax({
			type :'post',
			url : "http://localhost:8000/checkId",

			async : false,
			data : {
				"customer" : c_id.value
			},
			success : function(data) {
				if(data == 1)
				{
				setMessage('このIDは使えません');
				}
			else
				{
				setMessage('このIDは使えます');
				checkDuplBtn.disabled=true;
				checkDuplBtn.style.backgroundColor='rgb(126, 126, 126)';
				document.getElementById("c_id").readOnly=true;
				document.getElementById("idCheckMsg").style.display = "none";
				}
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "message:"
						+ request.responseText + "\n" + "error:" + error);
			}
		})
	activeBtn();
  }

   </script>
</body>
</html>
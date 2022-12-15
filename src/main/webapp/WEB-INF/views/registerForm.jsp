<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page session="false"%>
<%@ page import="java.net.URLDecoder"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/css/login.css?ver=1">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>

<title>Register</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
</head>
<body>
	<section class="LoginSection">
		<div class="LoginDiv">
			<div class="title">
				<h1>Register</h1>
			</div>
			<div class="form">
				<form:form action="/register/signup" method="post"
					onchange="validInsert()" onkeypress="activeBtn()" id="f">
					<input type="hidden" name="M_CODE" value="M0">
					<div class=idDupl>
						<button id="checkDuplBtn" type="button" onclick="idCheck()">IDチェック</button>
						<h5 class="idDuplMsg" id="idDuplMsg" style="color: red;"></h5>
					</div>
					<input class="input-field" type="text" id="c_id" name="c_id"
						placeholder="E-MAIL">
					<input class="input-field" type="password" name="c_pwd"
						placeholder="パスワード">
					<input class="input-field" type="password" name="c_pwd2"
						placeholder="再入力してください">
					<input class="input-field" type="text" name="c_name"
						placeholder="木村太郎">
					<input class="input-field" type="number" name="c_phone"
						placeholder="`-`なし　例）09012345678">
					<input class="input-field" type="text" name="c_birth"
						placeholder="例)1990年06月02日 → 19900602">
					<div class="msg" id="idCheckMsg"
						style="margin-bottom: 0px, width: 300px;">IDチェックをした上に登録してください</div>
					<button type="submit" id="submitBtn" disabled>新規登録</button>
					<button type="button" id="backPage" onclick="gomain()">メインページへ</button>
				</form:form>
			</div>
		</div>
	</section>
	<script>
		function gomain() {
			location.href='/';
		}
	const submitBtn = document.getElementById("submitBtn");
	const checkDuplBtn = document.getElementById("checkDuplBtn");
	const f = document.getElementById("f");
	function activeBtn(){
	   if(f.c_id.value.length>0
			   &&f.c_pwd.value.length>0
			   &&f.c_name.value.length>0
			   &&f.c_phone.value.length>0
			   &&f.c_birth.value.length>0
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
	   if(f.c_id.value.match(emailCheck) == null){
		   setMessage('正しいメール形式を入力して下さい', f.c_id);
		   
	   }
	   else if(f.c_pwd2.value>0 && f.c_pwd.value!==f.c_pwd2.value) {　
           setMessage('pwdが一致しません', f.c_pwd2);
       }
       else{
       	deleteMessage();
       }
	   activeBtn();
  }
   
  function setMessage(msg, element){
       document.getElementById("idCheckMsg").innerHTML = msg;
       if(element) {
           element.select();
       }
  }
  
  function setMessage(msg){
      document.getElementById("idCheckMsg").innerHTML = msg;
 }
  
  function deleteMessage(){
	   document.getElementById("idCheckMsg").innerHTML = ``;
  }
  
  
  function idCheck() {
		const c_id = document.getElementById("c_id");
		let regex = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		if(c_id.value.match(regex) != null){
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
						document.getElementById("idDuplMsg").innerHTML='このIDは使えません';
					}
				else
					{
					document.getElementById("idDuplMsg").innerHTML='このIDは使えます';
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
		}
		else{
			document.getElementById("idDuplMsg").innerHTML='メールアドレスを入力してください。';
		}
	  	
	activeBtn();
  }

   </script>
</body>
</html>
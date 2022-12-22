<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page session="false"%>
<%@ page import="java.net.URLDecoder"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:eval expression="@environment.getProperty('path.urlPath')"
	var="urlPath" />
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
				<form:form action="/register/signup" method="post" id="f">
					<input type="hidden" id="urlPath" value="${urlPath}">
					<input type="hidden" name="M_CODE" value="M0">
					<div class=idDupl>
						<h5 class="idDuplMsg" id="idDuplMsg" style="color: red;"></h5>
						<button id="checkDuplBtn" type="button" onclick="idCheck()">IDチェック</button>
					</div>
					<label class="signLabel" id="c_idLabel" for="c_id">メール</label>
					<br />
					<input class="input-field" type="text" id="c_id" name="c_id"
						placeholder="E-MAIL(最大25文字))" maxlength="25">
					<br />
					<label class="signLabel" id="c_pwdLabel" for="c_pwd">パスワード</label>
					<input class="input-field" type="password" id="c_pwd" name="c_pwd"
						placeholder="パスワード" maxlength="20">
					<br />
					<label class="signLabel" id="c_pwd2Label" for="c_pwd2">パスワード確認</label>
					<br />
					<input class="input-field" type="password" id="c_pwd2"
						name="c_pwd2" placeholder="再入力してください" maxlength="20">
					<br />
					<label class="signLabel" id="c_nameLabel" for="c_name">名前</label>
					<br />
					<input class="input-field" type="text" id="c_name" name="c_name"
						placeholder="木村太郎" maxlength="10">
					<br />
					<label class="signLabel" id="c_phoneLabel" for="c_phone">携帯番号</label>
					<br />
					<input class="input-field" type="text" id="c_phone"
						name="c_phone" id="c_phone" placeholder="`-`なし　例）09012345678"
						 maxlength="11">
					<br />
					<label class="signLabel" id="c_birthLabel" for="c_birth">生年月日</label>
					<br />
					<input class="input-field" type="text" id="c_birth"
						name="c_birth" id="c_birth" placeholder="例)1990年06月02日 → 19900602"
						maxlength="8">
						<div class="msgArea" id="validateMsg"></div>
					<button type="button" id="submitBtn" onclick="sbm()">新規登録</button>
					<button type="button" id="backPage" onclick="gomain()">メインページへ</button>
				</form:form>
			</div>
		</div>
	</section>
	<script>
	const idLabel = document.getElementById("c_idLabel");
	const pwdLabel = document.getElementById("c_pwdLabel");
	const pwd2Label = document.getElementById("c_pwd2Label");
	const nameLabel = document.getElementById("c_nameLabel");
	const phoneLabel = document.getElementById("c_phoneLabel");
	const birthLabel = document.getElementById("c_birthLabel");
	const frm = document.getElementById("f");
	const sbmBtn = document.getElementById("submitBtn");
	const checkDuplBtn = document.getElementById("checkDuplBtn");
	const msg = document.getElementById("validateMsg");
	const urlPath = document.getElementById("urlPath");
	 function idCheck() {
			const c_id = document.getElementById("c_id");
			let regex = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
			if(c_id.value.match(regex) != null){
				$.ajax({
					type :'post',
					url :urlPath+"/checkId",
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
	  }
	function sbmvalid() {
		msg.innerHTML = '';
		returnColor();
		const phoneRex = /^(0[7|8|9][0])([0-9]{4})([0-9]{4})$/;
		const birthRex = /^(19[0-9][0-9]|20\d{2})(0[0-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$/;
		if(frm.c_id.value.length < 1){
			idLabel.style.color = "red";
			frm.c_id.focus();
			msg.innerHTML = 'メールを入力してください。';
			return false;
		}
		if(!checkDuplBtn.disabled){
			idLabel.style.color = "red";
			frm.c_id.focus();
			msg.innerHTML = 'IDチェックをしてください。';
			return false;
		}
		if(frm.c_pwd.value.length < 4 || frm.c_pwd.value.length > 20){
			pwdLabel.style.color = "red";
			frm.c_pwd.focus();
			msg.innerHTML = 'パスワードは4~20文字の間で入力してください。';
			return false;
		}
		if(frm.c_pwd.value !== frm.c_pwd2.value){
			pwd2Label.style.color = "red";
			frm.c_pwd2.focus();
			msg.innerHTML = 'パスワードが一致しておりません。';
			return false;
		}
		if(frm.c_name.value.length < 1 || frm.c_name.value.length > 10){
			nameLabel.style.color = "red";
			frm.c_name.focus();
			msg.innerHTML = 'お客様のお名前を入力してください。';
			return false;
		}
		if(!phoneRex.test(frm.c_phone.value)){
			phoneLabel.style.color = "red";
			frm.c_phone.focus();
			msg.innerHTML = '携帯番号ではないです。もう一度確認してください。';
			return false;
		}
		if(!birthRex.test(frm.c_birth.value)){
			birthLabel.style.color = "red";
			frm.c_birth.focus();
			msg.innerHTML = '生年月日を正しく入力してください。';
			return false;
		}
		return true;
	}
	
	function sbm(){
		if(sbmvalid()){
			f.submit();
		}
	}
	function gomain() {
		location.href='/';
	}
	function returnColor() {
		idLabel.style.color = "white";
		pwdLabel.style.color = "white";
		pwd2Label.style.color = "white";
		nameLabel.style.color = "white";
		phoneLabel.style.color = "white";
		birthLabel.style.color = "white";
	}
   </script>
</body>
</html>
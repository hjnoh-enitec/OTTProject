<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page session="false"%>
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
}

.sns-chk {
	margin-top: 5px;
}
</style>
<title>Register</title>
</head>
<body>
	<form:form id="frm" action="/modify/save" method="post"
		onsubmit="return pwCheck(this)">
		<div class="title">ユーザ情報修正</div>
		<div id="msg" class="msg">
			<form:errors path="pwd" />
		</div>
		<label for="">ID</label>
		<input class="input-field" type="text" name="c_id"
			value="${customer.c_id}" readonly="readonly">
		<label for="">パスワード</label>
		<input class="input-field" type="password" name="c_pwd"
			placeholder="パスワード" maxlength="20">
		<label for="">パスワード再入力</label>
		<input class="input-field" type="password" name="c_pwd2"
			placeholder="再入力してください" maxlength="20">
		<label for="">名前</label>
		<input class="input-field" type="text" name="c_name"
			value="${customer.c_name}" readonly="readonly">
		<label for="">生年月日</label>
		<input class="input-field" type="text" name="c_birth"
			value="${customer.c_birth}" readonly="readonly">
		<label for="">携帯</label>
		<input class="input-field" type="text" name="c_phone"
			value="${customer.c_phone}" maxlength="11">
		<input type="hidden" name="c_mailcheck"
			value="${customer.c_mailcheck}">
		<button>修正</button>
	</form:form>
	<script>
       function pwCheck(frm) {
    	   deleteMessage('', frm.pwd);
    	   var reg = /\s/g;
    	   
            if(frm.c_pwd.value.length == 0){
     		   setMessage('パスワードを入力してください。', frm.c_pwd);
     		  return false;
     	   }
            
     	   if(frm.c_pwd2.value.length == 0){
     		   setMessage('もう一度パスワードを入力してください。', frm.c_pwd2);
     		  return false;
     	   }
     	  if(frm.c_pwd.value.length < 4 && frm.c_pwd2.value.length < 4){
     		  setMessage('パスワードは4文字以上入力してください。', frm.c_pwd2);
     		  return false;
     	   }
     	  if(frm.c_pwd.value.match(reg)){
     		setMessage('パスワードには空白は入れません。', frm.c_pwd);
     		return false;
     	  }
     	  if(frm.c_pwd.value!==frm.c_pwd2.value) {　
     		 setMessage('パスワードが一致しません', frm.c_pwd2);
              return false;
          }
     	   if(frm.c_phone.value.length == 0){
     		   setMessage('携帯番号を入力してください', frm.c_phone);
     		  return false;
     	   }
     	  if(frm.c_phone.value.length !== 11){
    		   setMessage('携帯番号を正しく入力してください', frm.c_phone);
    		  return false;
    	   }
     	  let phoneRegex = new RegExp('^(0[7|8|9][0])([0-9]{4})([0-9]{4})$');
     	  if (phoneRegex.test(frm.c_phone.value) == false) {
     		 setMessage('携帯番号を確認してください', frm.c_phone);
				
			return false;
			}     	   
     	   return true;
       }
       function setMessage(msg, element){
            document.getElementById("msg").innerHTML = `<i class="fa fa-exclamation-circle"> ${'${msg}'}</i>`;
            if(element) {
                element.select();
            }
       }
       function deleteMessage(msg,element){
    	   document.getElementById("msg").innerHTML = ``;
       }
       
   </script>
</body>
</html>
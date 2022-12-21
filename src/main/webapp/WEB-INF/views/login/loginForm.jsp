<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="stylesheet" href="/css/login.css?ver=1">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<style>
#modal-findID {
	display: none;
	position: absolute;
	width: 100%;
	height: 100%;
	z-index: 1;
}
#modal-findID h2 {
	margin: 0;
}
#modal-findID button {
	display: inline-block;
	width: 100px;
	margin-left: calc(100% - 100px - 10px);
}
#modal-findID .modal_content {
	width: 350px;
	height: 500px;
	margin: auto;
	padding: 20px 10px;
	background: #fff;
	border: 2px solid #666;
}
#modal-findID .modal_layer {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5);
	z-index: -1;
}
#modal-findPW {
	display: none;
	position: absolute;
	width: 100%;
	height: 100%;
	z-index: 1;
}
#modal-findPW h2 {
	margin: 0;
}
#modal-findPW button {
	display: inline-block;
	width: 100px;
	margin-left: calc(100% - 100px - 10px);
}
#modal-findPW .modal_content {
	width: 350px;
	height: 500px;
	margin: auto;
	padding: 20px 10px;
	background: #fff;
	border: 2px solid #666;
}
#modal-findPW .modal_layer {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5);
	z-index: -1;
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
#title-findID {
	font-size: 25px;
}
</style>
</head>
<body>
	<div class="LoginSection">
		<div id="modal-findID">
			<div class="modal_content">
				<form id="findIdForm">
					<div id="title-findID">Find ID</div>
					<div style="height: 70px;">
						<label for="">名前</label> <input class="input-field" type="text"
							name="c_name" id="c_name" placeholder="ex : 動画太郎">
					</div>
					<div style="height: 70px;">
						<label for="">生年月日</label> <input class="input-field" type="text"
							name="c_birth" id="c_birth" placeholder="ex : 20220101">
					</div>
					<div style="height: 70px;">
						<label for="">電話番号</label> <input class="input-field" type="text"
							name="c_phone" id="c_phone" placeholder="ex : 07012345678">
					</div>
					<div style="width: 50%; float: left;">
						<button onclick="findID()">ID探し</button>
					</div>
					<div style="width: 50%; float: right;">
						<button id="modal_close_btn" onclick="closeFindID()">戻る</button>
					</div>
				</form>
				<br>
				<br>
				<br>
				<div>
					<h2 id="msg_id"></h2>
				</div>
			</div>
		</div>
		<div id="modal-findPW">
			<div class="modal_content">
				<form id="findPWForm">
					<h3 id="title">メールアドレスを入力してください。</h3>
					<div style="text-align: center; height: 70px;">
						<input type="text" id="c_id" name="c_id" value="" placeholder="E-MAIL" autofocus style="width: 320px; height: 50px;">
						<input type="hidden" name="toURL" value="${param.toURL}">
					</div>
					<div style="height: 50px;">
						<button onclick="findPW()" style="margin: auto; width: 330px;">認証メール発送</button>
					</div>
					<div style="height: 50px;">
						<button id="modal_close_btn" onclick="closeFindPW()">戻る</button>
					</div>
				</form>
				<br>
				<br>
				<br>
				<div>
					<h2 id="msg_pw"></h2>
				</div>
			</div>
		</div>
		<div class="LoginDiv">
			<div class="title">
				<h1>LogIn</h1>
			</div>
			<div class="form">
				<form action="/login/login" method="post" id="f">
					<input type="hidden" name="toURL" value="${toURL}" />
					<p>
						<input type="text" name="c_id" value="${cookie.c_id.value}"
							placeholder="E-MAIL" autofocus>
					</p>
					<p>
						<input type="password" name="c_pwd" placeholder="パスワード"> <br>
						<font color="white" id="emptycheck"></font>
					</p>
					<p>
					<input type="submit" value="LogIn">
					<br>
					
					<input type="checkbox" id="check" name="rememberId" value="on" ${empty cookie.c_id.value ? "":"checked"}>
					<label for="check">ID保存</label>
					<p>
						<br>
				</form>
			</div>
			<div class="joinQ">
				<a href="/register/signup">新規登録</a> <br /> <a id="modal_open_btn_findID">IDを忘れた方</a>
				| <a id="modal_open_btn_findPW">パスワードを忘れた方</a> | <a href="/">戻る</a>
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="/js/loginForm.js"></script>
</body>
</html>
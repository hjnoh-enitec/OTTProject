<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
﻿
<meta charset="UTF-8">
<title></title>
<style>
div.container {
	
}

div.profileList {
	width: 600px;
	height: 200px;
}

div.profileImg {
	width: 150px;
	height: 150px;
	float: left;
}

div.profileName {
	width: 200px;
	height: 150px;
	float: left;
}

div.profileUpdateDelete {
	width: 150px;
	height: 150px;
	float: left;
	text-align: center;
	line-height: 150px;
	position: relative;
}

div.txtSpace {
	width: 130px;
	height: 150px;
	float: left;
	text-align: center;
	line-height: 150px;
}

div.btnSpace {
	width: 70px;
	height: 150px;
	float: left;
	position: relative;
}

input.profileName {
	width: 100px;
	outline: none;
	border: 0;
}

input.fileUpload {
	visibility: hidden;
}

button.nameChangebtn {
	outline: none;
	border: 0;
	width: 25px;
	height: 25px;
	background-color: transparent;
	position: absolute;
	left: 50%;
	top: 50%;
	transform: translate(-50%, -50%);
}

button.acceptbtn {
	outline: none;
	border: 0;
	width: 25px;
	height: 25px;
	display: none;
	background-color: transparent;
}

button.cancelbtn {
	outline: none;
	border: 0;
	width: 25px;
	height: 25px;
	display: none;
	background-color: transparent;
}

button.update {
	outline: none;
	border: 0;
	width: 25px;
	height: 25px;
	background-color: transparent;
	display: none;
	position: absolute;
	left: 50%;
	top: 50%;
	transform: translate(-50%, -50%);
}

button.delete {
	outline: none;
	border: 0;
	width: 25px;
	height: 25px;
	background-color: transparent;
	position: absolute;
	left: 50%;
	top: 50%;
	transform: translate(-50%, -50%);
}

img.profileImg {
	width: 150px;
	height: 150px;
	object-fit: cover;
}
</style>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
</head>
<body>
	<div class="container">
		<c:forEach var="profile" items="${profileList }" varStatus="status">
			<div class="profileList" id="profileList${status.index }">
				<div class="profileImg" id="profileImg${status.index }">
					<img src="${ profile.pf_path }" class="profileImg"
						id="profileImg-card${status.index }"
						onclick="imgChange(${status.index })">
				</div>
				<div class="profileName">
					<div class="txtSpace">
						<input type="text" class="profileName" name="name"
							id="name${status.index }" value="${profile.pf_name }"
							readonly="readonly" onkeypress="enterkey(${status.index},event)">
					</div>
					<div class="btnSpace">
						<button class="nameChangebtn" id="nameChange${status.index }"
							onclick="nameChange(${status.index})">
							<img src="/image/baseImage/modifyPan.jpg">
						</button>
						<button class="cancelbtn" id="cancel${status.index }"
							onclick="cancel(${status.index})">x</button>
						<button class="acceptbtn" id="changeAccept${status.index }"
							onclick="accept(${status.index})">o</button>
					</div>
				</div>
				<div class="profileUpdateDelete">
					<button class="update" id="profileUpdateBtn${status.index }"
						onclick="updateProfile(${status.index})">確認</button>
					<button class="delete" id="profileDeleteBtn${status.index }"
						onclick="deleteProfile(${status.index})">削除</button>
				</div>
				<form method="POST" enctype="multipart/form-data"
					id="fileUploadform${status.index }">
					<input type="file" class="fileUpload"
						id="fileUpload${status.index }" name="fileUpload"
						accept=".jpg,.png"
						onchange="changeProfileImg(event,${status.index })" /> <input
						type="hidden" id="pf_code${status.index }" name="pf_code"
						value="${profile.pf_code }"> <input type="hidden"
						id="pf_name${status.index }" name="pf_name"
						value="${profile.pf_name }">
				</form>
			</div>
		</c:forEach>
		<button class="goBackBtn" id="goBack" onclick="returnProfile()">戻る</button>
	</div>
	<script>
	
	function enterkey(index,e) {
		let txt = document.getElementById("name" + index);
		let code = e.code;
		if(!txt.readOnly){
			if(code == 'Enter'){
				accept(index);
			}
		}
	}
		function returnProfile(){
			location.href='/profile/select';
		}
		function cancel(index){
			let updateBtn = document.getElementById("nameChange" + index);
			let acceptBtn = document.getElementById("changeAccept"+ index);
			let	showProfileName = document.getElementById("name"+index);
			let profileName = document.getElementById("pf_name" + index);
			let sendUpdateBtn = document.getElementById("profileUpdateBtn"+ index);
			let sendDeleteBtn = document.getElementById("profileDeleteBtn"+ index);
			let cancelBtn = document.getElementById("cancel"+index);
			updateBtn.style.display = 'block';
			acceptBtn.style.display = 'none';
			cancelBtn.style.display = 'none';
			showProfileName.readOnly = true;
			showProfileName.style.outline = 'none';
			showProfileName.style.border = '0';
			showProfileName.style.borderRadius = '0';
			showProfileName.value=profileName.value;
		}
		
		function accept(index) {
			let updateBtn = document.getElementById("nameChange" + index);
			let acceptBtn = document.getElementById("changeAccept"+ index);
			let	showProfileName = document.getElementById("name"+index);
			let profileName = document.getElementById("pf_name" + index);
			let sendUpdateBtn = document.getElementById("profileUpdateBtn"+ index);
			let sendDeleteBtn = document.getElementById("profileDeleteBtn"+ index);
			let cancelBtn = document.getElementById("cancel"+index);
			updateBtn.style.display = 'block';
			acceptBtn.style.display = 'none';
			cancelBtn.style.display = 'none';
			showProfileName.readOnly = true;
			showProfileName.style.outline = 'none';
			showProfileName.style.border = '0';
			showProfileName.style.borderRadius = '0';
			profileName.value=showProfileName.value;
			if(sendUpdateBtn.style.display == ""){
				sendUpdateBtn.style.display = 'block';
				sendDeleteBtn.style.display = 'none';
			}
		}
		function nameChange(index) {
			let updateBtn = document.getElementById("nameChange" + index);
			let acceptBtn = document.getElementById("changeAccept"+ index);
			let profileName = document.getElementById("name" + index);
			let cancelBtn = document.getElementById("cancel"+index);
			updateBtn.style.display = 'none';
			acceptBtn.style.display = 'block';
			cancelBtn.style.display = 'block';
			profileName.readOnly = false;
			profileName.style.outline = '1px solid';
			profileName.style.border = '1px solid';
			profileName.style.borderRadius = '1px';
			
		}
		function imgChange(index) {
			let file = document.getElementById("fileUpload"+index);
			file.click();
			
		}
		function changeProfileImg(event,index){
			 let reader = new FileReader();
			 let sendUpdateBtn = document.getElementById("profileUpdateBtn"+ index);
			 let sendDeleteBtn = document.getElementById("profileDeleteBtn"+ index);
			 reader.onload = function(event){
				 let img = document.getElementById("profileImg-card"+index);
				 img.setAttribute("src",event.target.result);
			 };
			 reader.readAsDataURL(event.target.files[0]);
			 if(sendUpdateBtn.style.display == ""){
					sendUpdateBtn.style.display = 'block';
					sendDeleteBtn.style.display = 'none';
			}
		}
		function updateProfile(index){
			let updatebtn = document.getElementById("profileUpdateBtn"+index);
			let deletebtn = document.getElementById("profileDeleteBtn"+index);
			if(window.confirm("変更事項を保存しますか？")){
				let form = document.getElementById("fileUploadform"+index);
				let data = new FormData(form);
				$.ajax({
					type:'POST',
					enctype:'multipart/form-data',
					url:'http://localhost:8000/update',
					data:data,
					processData:false,
					contentType:false,
					cache:false,
					success:function(data){
						if(data == 0){
							
							window.location.reload();
						}
						else{
							alert('修正に失敗しました。');
						}
					},
					error : function(e){
						console.log('ERROR : ' + e);
					}
				});
			}updatebtn.style.display='none';
			deletebtn.style.display='block'
			
			}
			function deleteProfile(index) {
				if(window.confirm("本当に削除しますか？")){
					let pf_code = document.getElementById("pf_code" + index);
					$.ajax({
						type:'POST',
						url:'http://localhost:8000/delete',
						data:{"pf_code" : pf_code.value},
						success:function(data){
							if(data == 0){
								window.location.reload();
							}
							else if(data == 1){
								location.href='/profile/select';
							}
							else{
								alert('削除に失敗しました。');
							}
						},
						error : function(e){
							console.log('ERROR : ' + e);
						}
					})
				}
			}
	</script>
</body>
</html>
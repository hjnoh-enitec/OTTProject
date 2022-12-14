<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<c:set var="c_id" value="${request.getSession(false)=='' ? '' : pageContext.request.session.getAttribute('c_id')}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>プロフィール生成</title>
<script>
function setProfile(event){
	 let reader = new FileReader();
	 reader.onload = function(event){
		 let img = document.getElementById("fileUpload");
		 img.setAttribute("src",event.target.result);
	 };
	 
	 reader.readAsDataURL(event.target.files[0]);
}
function createProfile(){
	$('createProfile').submit();
}

</script>
</head>
<body>
<div>
<form:form id="createProfile" action="/profile/create" method="post" enctype="multipart/form-data" >
		<input type="hidden" name="c_id" value="${c_id }">
		<input type="hidden" name="pf_code" value="${pf_code}">
		<label class="profile-name">プロフィール名</label><input type="text" name="pf_name">	
		<br/>
		<div class="profile-card" id="profile-image">
		<img src="/img/baseImage/basicProfileImage.jpg" id="fileUpload"/>
		</div>
		<input type="file" name="fileUpload"  accept=".jpg,.png" onchange="setProfile(event);"/>
		<br/>
		${msg }
		<br/>
		<button onclick="createProfile()">プロフィール生成</button>
		</form:form>
		<button onclick="location.href='/profile/select'">戻る</button>
	</div>
</body>
</html>
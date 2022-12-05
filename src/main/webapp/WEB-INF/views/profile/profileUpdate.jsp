<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style>
div.profile_body {
	width: 500px;
}
</style>
</head>
<body>
	<div class="body">
		<div class="container">
			<c:forEach var="profile" items="${profileList }" varStatus="status">
				<form method="post" enctype="multipart/form-data" id="updateProfile${status.index }">
					<div class="form-group row">
						<div class="img${status.index }">
						<img src="${ profile.pf_path }" id="profileImg" onclick="imgChange(${status.index })">
						<input type="file" name="fileUpload" id="fileUpload${status.index }" style="display:none" accept=".jpg,.png" />
						</div>
						<div class="col-sm-10">
							<input type="text" readonly class="form-control-plaintext"
								id="pf_name" value="${profile.pf_name }">
						</div>
						<input type="button" value="update">
					</div>
				</form>
				<form>
					<div class="form-group row">
						<div class="col-sm-10">
							<input type="button" value="delete">
						</div>
					</div>
				</form>
			</c:forEach>
		</div>
	</div>
	<script>
		function fileChange(file){
			file.onchange = function(event){
					let reader = new FileReader();
					reader.onload = function(event){
					let img = document.getElementById("profileImg");
					img.setAttribute("src",event.target.result);
					 };
					 reader.readAsDataURL(event.target.files[0]); 
					 console.log("event one");
			}
		}
		function imgChange(index) {
			let form = document.getElementById("updateProfile"+index);
			let file = document.getElementById("fileUpload"+index);
			file.click();
			let reader = new FileReader();
			reader.onload = function(){
			let img = document.getElementById("profileImg");
			img.setAttribute("src",event.target.result);
			console.log("event one");
			console.log("event two");
			}
		}
	</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
body#profilebody {
	color: white;
	background-color: black;
}

p#logo {
	background: transparent;
	color: blue;
	text-align: left;
	font-size: 40px;
	margin-top: 0px;
	margin-left: 10px;
}

div#profile-aria {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%)
}

p#tv {
	width: 100%;
	text-align: center;
	font-size: 48px;
	margin-bottom: 10px;
	margin-left: 25px;
}
ul#profilrselect{
}

li#profilrselect {
	float: left;
	list-style: none;
	margin: 10px;
	display: block;
}

div#profile {
	width: 150px;
	height: 200px;
	background: transparent;
}

div#profile-card {
	width: 150px;
	height: 150px;
	background: white;
}

p#profile-card {
	color: white;
	text-align: center;
}

div#button {
	width: 120px;
	height: 30px;
	margin-left: 45%;
	margin-top: 30%;
	position : relative;
	padding: 5px;
	border: 1px solid white;
}

img#profileSelect {
	width: 150px;
	height: 150px;
	object-fit: cover;
}
button#settingbtn{
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%)
}
</style>
</head>
<body id="profilebody">
	<div>
		<%@ include file="/jsp/home/header.jsp"%>
		<div id="profile-aria">
			<div>
				<p id="tv">プロフィールを選択してください。</p>
			</div>
			<div>
				<ul id="profilrselect">
					<c:forEach items="${profileList }" var="profile" varStatus="status">
						<li id="profilrselect">
							<div id="profile"
								onclick="moveContent(profileForm${status.index})">
								<form action="/profile/select" method="post"
									id="profileForm${status.index }" name="profileForm">
									<input type="hidden" id="toURL" name="toURL" value="${toURL }" />
									<input type="hidden" id="pf_code" name="pf_code"
										value="${profile.getPf_code() }" /> <input type="hidden"
										id="pf_name" name="pf_name" value="${profile.getPf_name() }" />
									<input type="hidden" id="pf_path" name="pf_path"
										value="${profile.getPf_path() }" />
									<div id="profile-card">
										<img id="profileSelect" src="${profile.getPf_path() }">
									</div>
									<p id="profile-card">${profile.getPf_name() }</p>
								</form>
							</div>
						</li>
					</c:forEach>
					<c:if test="${fn:length(profileList)  < 4}">
						<li id="profilrselect">
							<div id="profile" onclick="location.href='/profile/create'">
								<div id="profile-card">
									<img src="/image/baseImage/addProfileImage.jpg" />
								</div>
								<p id="profile-card">プロフィール追加</p>
							</div>
						</li>
					</c:if>
				</ul>
			</div>
			<div id="button">
				<button id="settingbtn" onclick="openModal()">ProfileSetting</button>
			</div>
		</div>
	</div>
	<script>
		function moveContent(frm){
			frm.submit();

		}
		function openModal() {
			location.href='/profile/update';
			
		}
	</script>
</body>
</html>
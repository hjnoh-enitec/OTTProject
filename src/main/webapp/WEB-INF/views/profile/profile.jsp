<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<c:set var="c_id"
	value="${request.getSession(false)=='' ? '' : pageContext.request.session.getAttribute('c_id')}" />
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/css/profile.css">
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

		<!-- 모달 전체 (화면 흐려지는 곳) -->
	<div id="modal-add" class="modal-overlay">
		
		<!-- 본 모달창 -->
		<div class="modal-window">
				<!-- 컨텐츠 제목 -->
			<div class="title" id="modalTitle"></div>
			<div class="close-area" onclick="closeModal()">X</div>
			<div id="content">
				<form id="contentForm" action="/profile/create" method="post" enctype="multipart/form-data">
					<input type='hidden' name='c_id' value='${c_id }'>
					<input type="hidden" name="pf_code" value="${pf_code}">
					<label class='profile-name'>プロフィール名</label>
					<input type='text' name='pf_name'><br />
					<div class='profile-card' id='profile-image'>
						<img src='/image/baseImage/basicProfileImage.jpg' id='fileUpload' />
					</div>
					<input type='file' name='fileUpload' accept='.jpg,.png' onchange='setProfile(event)' /><br><br><br><br><br>
					<button id='buttonInForm' onclick="createProfile()">プロフィール作成</button>
				</form>
			</div>
					
		</div>
		
	</div>

<div id="modal-modify" class="modal-overlay">
		
		<!-- 본 모달창 -->
		<div class="modal-window">
				<!-- 컨텐츠 제목 -->
			<div class="title" id="modalTitle"></div>
			<div class="close-area" onclick="closeModal()">X</div>
			<div id="content">
				<form id="contentForm" action="/profile/create" method="post" enctype="multipart/form-data">
					<input type='hidden' name='c_id' value='${c_id }'>
					<input type="hidden" name="pf_code" value="${pf_code}">
					<label class='profile-name'>プロフィール名</label>
					<input type='text' name='pf_name'><br />
					<div class='profile-card' id='profile-image'>
						<img src='/image/baseImage/basicProfileImage.jpg' id='fileUpload' />
					</div>
					<input type='file' name='fileUpload' accept='.jpg,.png' onchange='setProfile(event)' /><br><br><br><br><br>
					<button id='buttonInForm' onclick="createProfile()">プロフィール作成</button>
				</form>
			</div>
					
		</div>
		
	</div>

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
							<div id="profile" onclick="openModalWithAddProfile()">
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
				<button id="settingbtn" onclick="openModalWithSetting()">ProfileSetting</button>
			</div>
		</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="/js/profile.js"></script>
	
</body>
</html>
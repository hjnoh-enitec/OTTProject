<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="false" %>
<c:set var="profileList" value ='${requestScope.profile }'/>
<c:set var="id" value='${cookie.c_id.value}'/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	body{
		color : white;
	}
	p.logo{
		background:transparent;
		color:blue;
		text-align :left;
		font-size : 40px;
		margin-top :0px;
		margin-left : 10px;
	}
	div.profile-aria{
		position:absolute;
		top:50%;
		left:50%;
		transform:translate(-50%,-50%)
	}
	p.tv{
		text-align:center;
		font-size:48px;
		margin-bottom:10px;
		margin-left:25px;
	}
	li{
		float:left;
		list-style:none;
		margin:10px;
		display:block;
	}
	div.profile{
		width:150px;
		height:200px;
		background:transparent;
	}
	div.profile-card{
		width:150px;
		height:150px;
		background:white;
	}
	p.profile-card{
		color:white;
		text-align:center;
	}
	div.button{
		width:120px;
		height:30px;
		margin-left:45%;
		margin-top:30%;
		text-align:center;
		padding:5px;
		border:1px solid white;
	}
</style>
</head>
<body bgcolor="black">
	<div>
		<div>
			<p class="logo">OTTProject</p>
		</div>
		<div class="profile-aria">
			<div>
				<p class="tv">プロフィールを選択してください。</p>
			</div>
			<div>
				<ul>
				<c:forEach items="${profileList }" var="profile" varStatus="status">
					<li>
						<div class="profile" onclick="selectProfile()">
							<div class="profile-card"><img src="${profile.getPf_path() }" id ="${profile.getPf_code() }"/></div>
							<p class="profile-card">${profile.getPf_name() }</p>
						</div>
					</li>
				</c:forEach>				
				<c:if test="${fn:length(profileList)  < 4}">  
					<li>
						<div class="profile" onclick="location.href='/profile/insert'">
							<div class="profile-card" id="${id }"><img src="/image/addProfileImage.jpg"/></div>
							<p class="profile-card" id="${id}">プロフィール追加</p>
						</div>
					</li>
				</c:if>
				</ul>
			</div>
			<div class="button">
				<div  onclick="location.href='/profile/update'">
					ProfileSetting
				</div>
			</div>
		</div>
	</div>
	<script>
		function selectProfile() {
			let f = document.createElement("form");
			f.setAttribute("method", "post");
			f.setAttribute("action", "/profile/select");
			document.body.appendChild(f);
			f.submit();
		}
	</script>
</body>
</html>
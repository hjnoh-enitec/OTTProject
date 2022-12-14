<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page session="false" %>
<c:set var="profileSelect" value ='${requestScope.profile }'/>
<c:set var="id" value='${cookie.c_id.value}'/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/js/board/modal.js"></script>
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
		font-size:44px;
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
	img.profileSelect{
		width:150px;
		height:150px;
		object-fit:cover;
	}
</style>
</head>
<body bgcolor="black">
	<div>
	<%@ include file="/jsp/home/header.jsp" %>
		<div class="profile-aria">
			<div>
				<p class="tv">プロフィールを選択してください。</p>
			</div>
			<div>
				<ul>
					<c:forEach items="${profileSelect }" var="profile" varStatus="status">
						<li>
						<input type="hidden" id="m_code" name="m_code" value="${m_code }"/>
							<div class="profile" onclick="moveContent(profileForm${status.index})">
								<form action="/profile/select" method="post" id = "profileForm${status.index }" name="profileForm">
									<input type="hidden" id="toURL" name="toURL" value="${toURL }"/>
									<input type="hidden" id="pf_code" name="pf_code"  value="${profile.getPf_code() }"/>
									<input type="hidden" id="pf_name" name="pf_name" value="${profile.getPf_name() }"/>
									<input type="hidden" id="pf_path" name="pf_path" value="${profile.getPf_path() }"/>
								<div class="profile-card">
									<img id="profileSelect" src="${profile.getPf_path() }" style="width: 150px; height: 150px;">
								</div>
								<p class="profile-card">${profile.getPf_name() }</p>
								</form>
							</div>
						</li>
					</c:forEach>
				<c:if test="${m_code == 'M0'}">
					<div onclick="location.href='/customer/modifyMembership'">
						<h1 style="text-align: center;">メンバーシップ申し込み</h1>
					</div>
				</c:if>	
					
				<c:if test="${m_code == 'M1'}">
					<c:if test="${fn:length(profileList) < 1}">  
						<li>
							<div class="profile" onclick="location.href='/profile/create'">
								<div class="profile-card"><img src="/img/baseImage/addProfileImage.jpg"/></div>
								<p class="profile-card">プロフィール追加</p>
							</div>
						</li>
					</c:if>
				</c:if>
				
				<c:if test="${m_code == 'M2'}">
					<c:if test="${fn:length(profileList) < 2}">  
					<li>
						<div class="profile" onclick="location.href='/profile/create'">
							<div class="profile-card"><img src="/img/baseImage/addProfileImage.jpg"/></div>
							<p class="profile-card">プロフィール追加</p>
						</div>
					</li>
					</c:if>
				</c:if>
				
				<c:if test="${m_code == 'M3' || m_code == 'M4'}">
					<c:if test="${fn:length(profileList) < 4}">  
						<li>
							<div class="profile" onclick="location.href='/profile/create'">
								<div class="profile-card"><img src="/img/baseImage/addProfileImage.jpg"/></div>
								<p class="profile-card">プロフィール追加</p>
							</div>
						</li>
					</c:if>
				</c:if>
				
				</ul>
			</div>
			<div class="button">
				<div  onclick="openModal()">
					ProfileSetting
				</div>
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
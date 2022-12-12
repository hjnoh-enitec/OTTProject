<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<c:set var="loginId"
	value="${request.getSession(false)=='' ? '' : pageContext.request.session.getAttribute('c_id')}" />
<c:set var="profileSelected"
	value="${request.getSession(false)==''?'' : pageContext.request.session.getAttribute('profile')}" />
<c:set var="loginOutLink"
	value="${loginId==null ? '/login/login?toURL=/' : '/login/logout'}" />
<c:set var="loginOut" value="${loginId==null ? 'Login' : 'Logout'}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
div.menu{

}
div.profileMini {
	width: 25px;
	height: 25px;
	background-color:white;
}

img.profileThumbnail {
	width: 25px;
	height: 25px;
	object-fit: cover;
}
a.nowLoginProfile{
	color:white;
}

li{
		float:left;
		list-style:none;
		margin:10px;
		display:block;
}
a.logo{
		background:transparent;
		color:blue;
		text-align :left;
		font-size : 15px;
		margin-top :0px;
		margin-left : 10px;
	}
</style>
</head>
<body>
	<div class="menu">
		<ul>
				<li><a class="logo">OTT</a></li>
				<li><a href="<c:url value='${loginOutLink}'/>">${loginOut}</a></li>
				<li><a href="/customer/info">会員情報</a></li>
			<c:choose>
				<c:when test="${not empty profileSelected }">
					<li>
						<div class="profileMini" onclick="moveProfileSelect()">
							<img id="profileThumbnail" src="${profileSelected.pf_thumbnail_path}" id="thumbnail">
						</div>
					</li>
					<li><a id="nowLoginProfile">${profileSelected.pf_name}</a></li>
				</c:when>
				<c:when test="${empty loginId }">
					<li><a href="<c:url value='/register/signup'/>">signUp</a></li>
				</c:when>
			</c:choose>
		</ul>
	</div>
	<script>
		function moveProfileSelect() {
			location.href='/profile/select';
		}
	</script>
</body>
</html>
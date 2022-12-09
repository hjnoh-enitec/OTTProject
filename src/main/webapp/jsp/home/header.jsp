<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<c:set var="loginId"
	value="${request.getSession(false)=='' ? '' : pageContext.request.session.getAttribute('c_id')}" />
<c:set var="profile"
	value="${request.getSession(false)==''?'' : pageContext.request.session.getAttribute('profile')}" />
<c:set var="profileList"
	value="${request.getSession(false) == '' ? '' : pageContext.request.session.getAttribute('profileList') }" />
<c:set var="loginOutLink"
	value="${loginId==null ? '/login/login?toURL=/' : '/login/logout'}" />
<c:set var="loginOut" value="${loginId==null ? 'Login' : 'Logout'}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
	crossorigin="anonymous"></script>
<title>Insert title here</title>
<style type="text/css">
div.menu {
	
}

div.profileMini {
	width: 25px;
	height: 25px;
	background-color: white;
}

img.profileThumbnail {
	width: 25px;
	height: 25px;
	object-fit: cover;
}

a.nowLoginProfile {
	color: white;
}

li {
	float: left;
	list-style: none;
	margin: 10px;
	display: block;
}

a.logo {
	background: transparent;
	color: blue;
	text-align: left;
	font-size: 15px;
	margin-top: 0px;
	margin-left: 10px;
}
</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg bg-light">
		<div class="container-fluid">
			<a class="navbar-brand" href="#">OTT</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					
					<c:choose>
						<c:when test="${empty loginId }">
						<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="<c:url value='/register/signup'/>">SignUp</a>
						</li>
							<li class="nav-item"><a class="nav-link"
							href="<c:url value='${loginOutLink}'/>">${loginOut}</a></li>
						</c:when>
						<c:when test="${empty profile }">
							<li class="nav-item"><a class="nav-link"
							href="<c:url value='${loginOutLink}'/>">${loginOut}</a></li>
						</c:when>
						<c:when test="${not empty profile }">
						<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" role="button"
						data-bs-toggle="dropdown" aria-expanded="false"> <img
							id="profileThumbnail" src="${profile.pf_thumbnail_path}"
							id="thumbnail"> ${profile.pf_name}
					</a>
						<ul class="dropdown-menu">
							<c:forEach var="list" items="${profileList }" varStatus="status">
							<c:if test="${profile.pf_code ne list.pf_code }">
							<li><a class="dropdown-item" onclick="profileChange(${list})"><img
								id="profileThumbnail" src="${list.pf_thumbnail_path}"
								id="thumbnail"> ${list.pf_name}</a></li>
							</c:if>
							</c:forEach>
							<li><hr class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="<c:url value='${loginOutLink}'/>">${loginOut}</a></li>
						</ul></li>
						</c:when>
					</c:choose>
				</ul>
				<form class="d-flex" role="search">
					<input class="form-control me-2" type="search" placeholder="Search"
						aria-label="Search">
					<button class="btn btn-outline-success" type="submit">Search</button>
				</form>
			</div>
		</div>
	</nav>
		function profileChange(profile) {
			let pf_code = profile.pf_code;
			let pf_name = profile.pf_name;
			let pf_
		}
	</script>
</body>
</html>
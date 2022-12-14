<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<c:set var="toURL" value="${request.getHeader('referer')}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
	crossorigin="anonymous"></script>
<title>Insert title here</title>
<style type="text/css">
</style>
</head>
<body>
	<input type="hidden" class="toURL" id="toURL" name="toURL"
		value="${toURL }">
	<nav class="navbar navbar-expand-lg bg-light">
		<div class="container-fluid">
			<a class="navbar-brand" href="/">OTT</a>
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
									<c:forEach var="list" items="${profileList }"
										varStatus="status">
										<c:if test="${profile.pf_code ne list.pf_code }">
											<form action="/profile/select" method="post"
												id="headerform${status.index }"
												onclick="profileChange(${status.index })">
												<li><a class="dropdown-item"> <img
														id="profileThumbnail" src="${list.pf_thumbnail_path}"
														id="thumbnail"> ${list.pf_name}
												</a></li> <input type="hidden" id="pf_code ${status.index }"
													name="pf_code" value="${list.pf_code }">
											</form>
										</c:if>
									</c:forEach>

									<li><c:if test="${fn:length(profileList)  < 4}">
											<a class="dropdown-item"
												href="<c:url value='/profile/create'/>">プロフィール追加</a>
										</c:if></li>
									<li><hr class="dropdown-divider"></li>
									<li><a class="dropdown-item"
										href="<c:url value='/profile/select'/>">プロフィール</a></li>
									<li><a class="dropdown-item"
										href="<c:url value='${loginOutLink}'/>">${loginOut}</a></li>
								</ul></li>
						</c:when>
					</c:choose>
				</ul>
				<form class="d-flex" role="search" action="/search/search">
					<input class="form-control me-2" type="search" placeholder="Search"
						aria-label="Search" id="search" name="search">
					<button class="btn btn-outline-success" type="submit">Search</button>
				</form>
			</div>
		</div>
	</nav>
	<script>
		function profileChange(index) {
			let frm = document.getElementById("headerform"+index);
			frm.submit();
		}
		
	</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OTT - Watch Video</title>
</head>
<body>
<div id="menu">
	<ul>
		<li id="logo">OTT</li>
		<li><a href="<c:url value='/'/>">Home</a></li>
		<li><a href="<c:url value='/board/list'/>">Board</a></li>
		<li><a href="<c:url value='${loginOutLink}'/>">${loginOut}</a></li>
		<li><a href="<c:url value='/register/signin'/>">Sign in</a></li>
		<li><a href=""><i class="fa fa-search"></i></a></li>
	</ul>
	<video width="640" height="320" controls autoplay="autoplay">
		<source src="/video/test1.mp4" type="video/mp4">
	</video>
</div>
</body>
</html>
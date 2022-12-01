<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page session="false"%>
<%@ page import="java.net.URLDecoder"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/css/content.css">
<meta charset="UTF-8">
<title>contentPage</title>
</head>
<body>
	<div>
	<iframe width="1900px" height="1100px" src="https://www.youtube.com/embed/jk7QSGwupPA?controls=0&autoplay=1&mute=1" frameborder="0"></iframe>
	<h1>視聴記録</h1>
	<div class="slider-frame">
		<div class="btn prev"></div>
		<div class="btn next"></div>
		<div class="slider-container" id="slider-container">
			<c:forEach items="${popularList}" var="image" >
				<img class="slide"
					src="https://image.tmdb.org/t/p/w200${image.imgPath}">
			</c:forEach>
		</div>
	</div>
	</div>
	<!-- <h1>こんなコンテントはどうですか</h1>
		<div class="slider-frame">
		<div class="btn prev"></div>
		<div class="btn next"></div>
		<div class="slider-container s2" id="slider-container">
			<c:forEach items="${myList}" var="image" >
				<img class="slide"
					src="https://image.tmdb.org/t/p/w200${image.imgPath}">
			</c:forEach>
		</div>
	</div> 
	</div>-->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="/js/content.js"></script>
</body>
</html>
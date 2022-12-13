<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page session="false"%>
<%@ page import="java.net.URLDecoder"%>
<c:set var="profile"
	value="${request.getSession(false)=='' ? '' : pageContext.request.session.getAttribute('profile')}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/watch.css">
<title>OTT - Watch Video</title>
</head>
<body onload="beforePlayVideo()" onmouseover="onVideo()"
	onmouseout="outVideo()">
	<div class="main" id="header">
		<form action="<c:url value="/quitVideo"/>" method="get">
			<input type="hidden" id="e_path" value="${path }"> <input
				type="hidden" name="e_code" id="e_code" value="${e_code }">
			<input type="hidden" name="ct_code" id="ct_code" value="${ct_code}">
			<input type="hidden" id="membership" value="${membership }">
			<input type="hidden" id="start_sec" value="${h_close_at}"> <input
				type="hidden" name="h_close_at" id="h_close_at" value=""> <input
				type="hidden" name="pf_code" id="pf_code"
				value="${profile.pf_code }">
			<button onclick="setVideoTime()">
				<img src="/img/back.png" id="backToMain">
			</button>
		</form>

		<p id="title" style="color: white;"></p>
	</div>
	<div id="video_div">
		<video controls autoplay id="videoPlayer">
		</video>
	</div>

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="/js/watch.js"></script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page session="false"%>
<%@ page import="java.net.URLDecoder"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="profile"
	value="${request.getSession(false)=='' ? '' : pageContext.request.session.getAttribute('profile')}" />
<!DOCTYPE html>
<spring:eval expression="@environment.getProperty('path.urlPath')" var="urlPath"/>
<html>
<head>
<style>
#btn {
	z-index: 10000;
}
</style>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/watch.css">
<title>OTT - Watch Video</title>
</head>

<body onload="beforePlayVideo()" onmouseover="onVideo()"
	onmouseout="outVideo()">
	<input type="hidden" id="urlPath" value="${urlPath}">
	<input type="hidden" id="membership" value="${membership}">
	<input type="hidden" id="ct_code" value="${param.ct_code}">
	<input type="hidden" id="e_code" value="${param.e_code}">
	<input type="hidden" id="s_code" value="${param.s_code}">
	<input type="hidden" id="e_number" value="${param.e_number}">
	<input type="hidden" id="s_number" value="${param.s_number}">
	<input type="hidden" id="ct_path" value="${param.ct_path}">
	<input type="hidden" id="h_close_at" value="${param.h_close_at}">
	<input type="hidden" name="pf_code" id="pf_code"
		value="${profile.pf_code}">
		<button id="btn" type="button" onclick="pageOut()">
			<img src="/img/back.png" id="backToMain">
		</button>

		<p id="title" style="color: white;"></p>
	<div id="video_div">
		<video controls autoplay id="videoPlayer">
		</video>
	</div>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="/js/watch.js"></script>
</body>
</html>
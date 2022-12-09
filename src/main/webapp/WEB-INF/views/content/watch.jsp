<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/watch.css">
<title>OTT - Watch Video</title>
</head>
<body onload="beforePlayVideo()" onmouseover="onVideo()" onmouseout="outVideo()">
	<div class="main" id="header">
		<form action="quitVideo" method="get">
			<input type="hidden" id="e_path" value="${path }">
			<input type="hidden" name="e_code" id="e_code" value="${e_code }">
			<input type="hidden" id="membership" value="${membership }">
			<input type="hidden" id="e_start_sec" value="${e_close_sec}">
			<input type="hidden" name="e_close_sec" id="e_close_sec" value="">
			<input type="hidden" name="pf_code" id="pf_code" value="${pf_code }">
			<input type="hidden" name="history_key" id="history_key" value="${pf_code }_${e_code }">
			<button onclick="setVideoTime()"><img src="/img/back.png" id="backToMain"></button>
		</form>
		
		<p id="title" style="color: white;"></p>
	</div>
	<div id="video_div">
		<video controls autoplay id="videoPlayer">
		</video>
	</div>
	
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="/js/watch.js"></script>
</body>
</html>
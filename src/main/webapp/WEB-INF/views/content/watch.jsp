<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">

#video_div{
	text-align: center;
}
body{
	background-color: black;
}
video{
	margin : 0 auto;
	width: 1400px; 
	height: 650px;
}
#backToMain{
	width: 50px;
	height: 40px;
	display: none;
}
</style>
<title>OTT - Watch Video</title>
</head>
<body onmouseover="onVideo(this)" onmouseout="outVideo(this)">
	<div class="main" >
		<img src="/img/back.png" onclick="location.href='/content/main'" id="backToMain">
		<p id="title" style="color: white;"></p>
	</div>
	<div id="video_div">
		
		<input type="hidden" id="path" value="${path }">
		<input type="hidden" id="playStartTime" value="#t=00:00:00">
		<input type="hidden" id="membership" value="${membership }">
		<video controls autoplay id="videoPlayer">
		</video>
	</div>
	<script>
		
		var videoPlayer = document.getElementById("videoPlayer");
		var path = document.getElementById("path").value;
		var playStartTime = document.getElementById("playStartTime").value;
		var membership = document.getElementById("membership").value;
		
		// basic
		if(membership == "M1"){
			path = "(hd)" + path;
			document.getElementById("title").innerHTML = "720p";
		// standard, premium
		}else if(membership == "M2" || membership == "M3"){
			path = "(fhd)" + path;
			document.getElementById("title").innerHTML = "1080p";
		// omega
		}else if(membership == "M4"){
			path = "(uhd)" + path;
			document.getElementById("title").innerHTML = "2160p";
		}
		
		videoPlayer.setAttribute("src", "/video/" + path + playStartTime);
	
		var backToMain = document.getElementById("backToMain");
		
		// 뒤로가기 버튼
		function onVideo(video){
			backToMain.style.display = "flex";
		}
		function outVideo(video){
			backToMain.style.display = "none";
		}
		
	</script>
</body>
</html>
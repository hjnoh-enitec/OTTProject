<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">

body{
	background-color: black;
}
video{
	margin-top : 0;
	width: 1500px; 
	height: 650px;
}
#backToMain{
	width: 50px;
	height: 40px;
	display: none;
}
p{
	color: white;
	display: flex;
}
.main{
	align-content : center;
	text-align: center;
}
</style>
<title>OTT - Watch Video</title>
</head>
<body onmouseover="onVideo(this)" onmouseout="outVideo(this)">
	<div class="main">
		<img src="/img/back.png" onclick="location.href='/video/contents'" id="backToMain">
	</div>
	<div >
		<video src="${path }" autoplay="autoplay" muted="muted" controls="controls" >
			</video>
	</div>
	<script>
	
		var backToMain = document.getElementById("backToMain");
		
		function onVideo(video){
			backToMain.style.display = "flex";
		}
		function outVideo(video){
			backToMain.style.display = "none";
		}
	
	</script>
</body>
</html>
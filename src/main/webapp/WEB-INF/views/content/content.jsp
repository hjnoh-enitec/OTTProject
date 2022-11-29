<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page session="false" %>
<%@ page import="java.net.URLDecoder"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type = "text/css">
</style>
<title>contentPage</title>
<style type="text/css">
.video{
	width :200px; 
	height :200px
}
</style>
</head>
<body>
<div>
 <video class="video" onmouseover="mouseOnvideo(this)" onmouseout="mouseOutvideo(this)" src="http://localhost:8000/sample.mp4"></video>
</div>
<h1>視聴記録</h1>

<h1>今年の映画ランキング</h1>
<c:forEach begin="0" end="6" var="i">
     <label></label>
     <img src="https://image.tmdb.org/t/p/w200${jsonArray.get(i).get('poster_path')}"/>
</c:forEach>
<h1>profile様が好きかもしれない映画</h1>
<img src="https://image.tmdb.org/t/p/w200${jsonArray.get(1).get('poster_path')}"/>
<script type="text/javascript">
function mouseOnvideo(video){
	video.play();
	video.style.width="300px";
	video.style.width="300px";
}
function mouseOutvideo(video){
	video.pause();
	video.style.width="250px";
	video.style.width="200px";
}
</script>
</body>
</html>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page session="false"%>
<%@ page import="java.net.URLDecoder"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OTT - Watch Video</title>
<style>
.movie {
	border: 1px solid black;
	margin: 30px;
	width: 300px;
	height: 200px;
}

.thumbnail {
	display: flex;
	justify-content: center;
	align-items: center;
	width: 300px;
}

.movie:hover {
	box-shadow: 5px 5px 5px gray;
}

.video_video {
	width: 300px;
	height: 200px;
	margin: 15px;
	border: 0;
	outline: 0;
	align-items: center;
	display: none;
}

.mvFile {
	width: 450px;
	height: 350px;
}

button {
	background: black;
	width: 400px;
}
/* modal */
#modal.modal-overlay {
	width: 100%;
	height: 100%;
	position: absolute;
	left: 0;
	top: 0;
	display: none;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	background: rgba(255, 255, 255, 0.25);
	box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
	backdrop-filter: blur(1.5px);
	-webkit-backdrop-filter: blur(1.5px);
	border-radius: 10px;
	border: 1px solid rgba(255, 255, 255, 0.18);
}

#modal .modal-window {
	/*background: rgba( 69, 139, 197, 0.70 );*/
	background: black;
	box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
	backdrop-filter: blur(13.5px);
	-webkit-backdrop-filter: blur(13.5px);
	border-radius: 10px;
	border: 1px solid rgba(255, 255, 255, 0.18);
	width: 500px;
	height: 650px;
	position: relative;
	/*top: 100px;*/
	padding: 10px;
}

#modal .title {
	padding-left: 10px;
	display: inline;
	text-shadow: 1px 1px 2px gray;
	color: white;
}

#modal .title h2 {
	display: inline;
}

#modal .close-area {
	display: inline;
	float: right;
	padding-right: 10px;
	cursor: pointer;
	text-shadow: 1px 1px 2px gray;
	color: white;
}

#modal .content {
	margin-top: 20px;
	padding: 0px 10px;
	text-shadow: 1px 1px 2px gray;
	color: white;
}

#modal .comment {
	color: white;
	font-size: 18px;
	text-align: center;
}
</style>
</head>
<body>
	<div id="container"></div>
	
	<div id="modal" class="modal-overlay">

		<div class="modal-window">
			<div class="title" id="modalTitle"></div>
			<div class="close-area">X</div>
			<!--<button class="moveToWatch"> </button> -->
			<div class="content">
				<form:form action="/video/contents" method="post">
					<input type="hidden" name="ct_code" id="ct_code">
					<button id="content"></button>
				</form:form>
			</div>
			<div class="comment" id="comment"></div>
		</div>

	</div>

	<div id="menu">
		<ul>
			<c:if test="${loginID != null}">
				<li>${loginID } 님</li>
				<input type="hidden" value="${loginID }" id="loginID">
			</c:if>
			<li id="logo">OTT</li>
			<li><a href="<c:url value='/'/>">Home</a></li>
			<li><a href="<c:url value='/board/list'/>">Board</a></li>
			<li><a href="<c:url value='${loginOutLink}'/>">${loginOut}</a></li>
			<li><a href="<c:url value='/register/signin'/>">Sign in</a></li>
			<li><a href=""><i class="fa fa-search"></i></a></li>
		</ul>
	</div>
	<div class="movies" id="">
		<table>
			<tr>
				<c:forEach var="cList" items="${contentList}" begin="0" end="3">
				<td>
					<div class="movie">
					<input type="hidden" class="video_code" value="<c:out value="${cList.ct_code}" />">
					<input type="hidden" class="video_title" value="<c:out value="${cList.ct_title}" />">
					<input type="hidden" class="video_path" value="<c:out value="${cList.ct_path}" />">
					<input type="hidden" class="video_info" value="<c:out value="${cList.ct_info}" />">
					<img src="<c:out value="${cList.ct_path_thumbnail}" />" class="thumbnail">
					<video src="<c:out value="${cList.ct_path}" />" autoplay="autoplay" muted="muted" class="video_video"></video>
					<div style="text-align: center; font-size: 20px;"><c:out value="${cList.ct_title}" /></div>
					</div>
				</td>
				</c:forEach>
			</tr>
			<tr>
				<c:forEach var="cList" items="${contentList}" begin="4" end="6">
				<td>
					<div class="movie">
					<input type="hidden" class="video_code" value="<c:out value="${cList.ct_code}" />">
					<input type="hidden" class="video_title" value="<c:out value="${cList.ct_title}" />">
					<input type="hidden" class="video_path" value="<c:out value="${cList.ct_path}" />">
					<input type="hidden" class="video_info" value="<c:out value="${cList.ct_info}" />">
					<img src="<c:out value="${cList.ct_path_thumbnail}" />" class="thumbnail">
					<video src="<c:out value="${cList.ct_path}" />" autoplay="autoplay" muted="muted" class="video_video"></video>
					<div style="text-align: center; font-size: 20px;"><c:out value="${cList.ct_title}" /></div>
					</div>
				</td>
				</c:forEach>
				<td>
					<div class="movie">
					<input type="hidden" class="video_code" value="YTA0000001">
					<input type="hidden" class="video_title" value="겨울왕국2">
					<input type="hidden" class="video_path" value="https://www.youtube.com/embed/3WUw9thZR4k?autoplay=1&mute=1">
					<input type="hidden" class="video_info" value="<c:out value="${cList.ct_info}" />">
					<img src="/img/Thumbnail8.png" class="thumbnail">
					<iframe width="300" height="200" src="https://www.youtube.com/embed/3WUw9thZR4k?autoplay=1&mute=1&controls=0&rel=0&disablekb=1&Loop=1" class="video_video"></iframe>
					<div style="text-align: center; font-size: 20px;"><c:out value="겨울왕국2" /></div>
					</div>
				</td>
			</tr>
		</table>
		
	</div>
	
	<script>
	
	const loginID = document.getElementById("loginID").value;
	console.log(loginID);
	const modal = document.getElementById("modal")
	
	const thumbnail = document.querySelectorAll(".thumbnail");
	const movie = document.querySelectorAll(".movie");
	const mvFile = document.querySelectorAll(".mvFile");
	const content = document.getElementById("content");
	const modalTitle = document.getElementById("modalTitle");
	const comment = document.getElementById("comment");
	
	const code = document.querySelectorAll(".video_code");
	const title = document.querySelectorAll(".video_title");
	const path = document.querySelectorAll(".video_path");
	const info = document.querySelectorAll(".video_info");
	const video = document.querySelectorAll(".video_video");
	
	const closeBtn = modal.querySelector(".close-area");
	closeBtn.addEventListener("click", e => {
	    modal.style.display = "none"
	});
	
	modal.addEventListener("click", e => {
	    const evTarget = e.target
	    if(evTarget.classList.contains("modal-overlay")) {
	        modal.style.display = "none"
	    }
	});
	
	for(let i = 0; i < movie.length; i++){
		
			movie[i].addEventListener("click", function(){
				if(loginID != 'Guest'){
					let num = i+1;
					
					modal.style.display = "flex"
					
					document.getElementById("ct_code").value = code[i].value;
					
					if(code[i].value.indexOf("YT") == 0){
						console.log("true");
						content.innerHTML = "<iframe width='300' height='200' src='" + path[i].value + "' class='video_video'></iframe>";
					}else{
						console.log("false");
						content.innerHTML = "<video src='" + path[i].value + "' autoplay='autoplay' muted='muted' class='mvFile' id='mvFile'></video>";
					}
					
					modalTitle.innerHTML = "<h2>" + title[i].value + "<h2>";
					comment.innerHTML = info[i].value;
				}else{
					window.location.href = '/login/login?toURL=/video/contents';
				}
				
			});
		
		
		movie[i].addEventListener("mouseover", function(){
			video[i].style.display = "flex";
			thumbnail[i].style.display = "none";
			movie[i].style.width = "330px";
			movie[i].style.height = "300px";

		});
		
		movie[i].addEventListener("mouseout", function(){
			video[i].style.display = "none";
			thumbnail[i].style.display = "flex";
			movie[i].style.width = "300px";
			movie[i].style.height = "200px";
		});
	}
	
	</script>

</body>
</html>
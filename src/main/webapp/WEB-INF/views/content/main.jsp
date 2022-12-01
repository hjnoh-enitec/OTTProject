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
.movies{
	justify-content: center;
	align-items: center;
}

.movie {
	border: 1px solid black;
	margin: 15px;
	width: 22%;
	height: 200px;
	float: left;
	justify-content: center;
	align-items: center;
}
/*
.movie:hover {
	box-shadow: 5px 5px 5px gray;
}
*/
.thumbnail {
	width: 80%;
	height: 80%;
	display: flex;
	margin: auto;
}

.video_video {
	width: 80%;
	height: 80%;
	margin: auto;
	border: 0;
	outline: 0;
	display: none;
}

.mvFile {
	width: 450px;
	height: 350px;
	margin: auto;
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
	justify-content: center;
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
	<input type="hidden" value="F" id="showModal">
	<div id="modal" class="modal-overlay">

		<div class="modal-window">
			<div class="title" id="modalTitle"></div>
			<div class="close-area">X</div>
			<!-- <iframe src="popup.jsp">TEST TEST TEST TEST TEST TEST </iframe> -->
			<div class="content">
				<form:form id="contentForm">
					<button>
						<video src='" + path[i].value + "' autoplay='autoplay' muted='muted' class='mvFile' id='mvFile' ></video>
					</button>
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
				<input type="hidden" value="${membership }" id="membership">
			</c:if>
			<li id="logo">OTT</li>
			<li><a href="<c:url value='/'/>">Home</a></li>
			<li><a href="<c:url value='/board/list'/>">Board</a></li>
			<li><a href="<c:url value='${loginOutLink}'/>">${loginOut}</a></li>
			<li><a href="<c:url value='register/signup'/>">Sign in</a></li>
			<li><a href=""><i class="fa fa-search"></i></a></li>
		</ul>
	</div>
	<div class="movies">
		<c:forEach var="cList" items="${contentList}">
			<div class="movie">
			
				<input type="hidden" class="video_code" value="<c:out value="${cList.ct_code}" />">
				<input type="hidden" class="video_title" value="<c:out value="${cList.ct_title}" />">
				<input type="hidden" class="video_path" value="<c:out value="${cList.ct_path}" />">
				<input type="hidden" class="video_info" value="<c:out value="${cList.ct_info}" />">
				<img src="<c:out value="${cList.ct_path_thumbnail}" />" class="thumbnail">
				<video src="<c:out value="${cList.ct_path}" />" autoplay="autoplay" muted="muted" class="video_video"></video>
				<div style="text-align: center; font-size: 20px;"><c:out value="${cList.ct_title}" /></div>
			
			</div>
		</c:forEach>
		<!--
		 https://www.youtube.com/embed/3WUw9thZR4k?autoplay=1&mute=1&controls=0&rel=0&disablekb=1&Loop=1-->
	</div>
	
	<script>
	
	const loginID = document.getElementById("loginID").value;
	const modal = document.getElementById("modal")
	
	const thumbnail = document.querySelectorAll(".thumbnail");
	const movie = document.querySelectorAll(".movie");
	const mvFile = document.querySelectorAll(".mvFile");
	const content = document.getElementById("content");
	const modalTitle = document.getElementById("modalTitle");
	const comment = document.getElementById("comment");
	const contentForm = document.getElementById("contentForm");
	
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
				
				if(loginID == 'Guest'){
					contentForm.setAttribute("action", "/login/login");
					contentForm.setAttribute("method", "get");
					contentForm.innerHTML = 
						"<input type='hidden' id='ct_code'>" + "<input type='hidden' name='toURL' id='toURL'>" +
						"<button><video src='" + path[i].value + "'autoplay='autoplay' muted='muted' class='mvFile' id='mvFile'></video></button>";
					var contentCode = document.getElementById("ct_code").value;
					contentCode = code[i].value;
					
					document.getElementById("toURL").value = "/content/watch?ct_code=" + contentCode;
				}else{
					contentForm.setAttribute("action", "/content/watch");
					contentForm.setAttribute("method", "get");
					contentForm.innerHTML = 
						"<input type='hidden' name='ct_code' id='ct_code'>" + 
						"<button><video src='" + path[i].value + "'autoplay='autoplay' muted='muted' class='mvFile' id='mvFile'></video></button>";
					document.getElementById("ct_code").value = code[i].value;
				}
					let num = i+1;
					
					modal.style.display = "flex"
					
					//if(code[i].value.indexOf("YT") == 0){
					//	contentForm.innerHTML = "<iframe width='300' height='200' src='" + path[i].value + "' class='video_video' id='mvFile'></iframe>";
					//}else{
					//	contentForm.innerHTML = "<video src='" + path[i].value + "' autoplay='autoplay' muted='muted' class='mvFile' id='mvFile'></video>";
					//}
					
					modalTitle.innerHTML = "<h2>" + title[i].value + "<h2>";
					comment.innerHTML = info[i].value;
					
			});
			
	}
	
	for(let i = 0; i < movie.length; i++){
		movie[i].addEventListener("mouseover", function(){
			video[i].style.display = "flex";
			thumbnail[i].style.display = "none";
			//movie[i].style.width = "330px";
			//movie[i].style.height = "300px";

		});
		
		movie[i].addEventListener("mouseout", function(){
			video[i].style.display = "none";
			thumbnail[i].style.display = "flex";
			//movie[i].style.width = "300px";
			//movie[i].style.height = "200px";
		});
	}
	
	</script>

</body>
</html>
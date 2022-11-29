<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OTT - Watch Video</title>
<style>
	.movie{
		border: 1px solid black;
		margin: 15px;
	}
	
	.thumbnail{
		display: flex;
		justify-content: center;
		align-items: center;
		width: 300px;
	}
	.movie:hover{
		box-shadow: 5px 5px 5px gray;
	}
	video{
		width: 450px;
		height: 300px;
		margin: 15px;
		border: 0;
		outline: 0;
		align-items: center;
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
            box-shadow: 0 8px 32px 0 rgba( 31, 38, 135, 0.37 );
            backdrop-filter: blur( 13.5px );
            -webkit-backdrop-filter: blur( 13.5px );
            border-radius: 10px;
            border: 1px solid rgba( 255, 255, 255, 0.18 );
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
        #modal .comment{
        	color: white;
        	font-size: 18px;
        	text-align: center;
        }
	
</style>
</head>
<body>
	<div id="container">
        
    </div>
    <div id="modal" class="modal-overlay">
        <div class="modal-window">
        <input type="hidden" id="videoTitle" disabled="disabled">
            <div class="title" id="modalTitle">
                
            </div>
            <div class="close-area">X</div>
            <div class="content" id="content">
			
            </div>
            <div class="comment" id="comment">
				
			</div>
        </div>
    </div>

	<div id="menu">
		<ul>
			<li id="logo">OTT</li>
			<li><a href="<c:url value='/'/>">Home</a></li>
			<li><a href="<c:url value='/board/list'/>">Board</a></li>
			<li><a href="<c:url value='${loginOutLink}'/>">${loginOut}</a></li>
			<li><a href="<c:url value='/register/signin'/>">Sign in</a></li>
			<li><a href=""><i class="fa fa-search"></i></a></li>
		</ul>
	</div>
	<div class="movies">
		<table>
			<tr>
				<td>
					<div class="movie"><img src="/img/Thumbnail1.png" class="thumbnail"></div>
					<div style="text-align: center; font-size: 20px;">TEST 1</div>
				</td>
				<td>
					<div class="movie"><img src="/img/Thumbnail2.png" class="thumbnail"></div>
					<div style="text-align: center; font-size: 20px;">TEST 2</div>
				</td>
				<td>
					<div class="movie"><img src="/img/Thumbnail3.png" class="thumbnail"></div>
					<div style="text-align: center; font-size: 20px;">TEST 3</div>
				</td>
				<td>
					<div class="movie"><img src="/img/Thumbnail4.png" class="thumbnail"></div>
					<div style="text-align: center; font-size: 20px;">TEST 4</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="movie"><img src="/img/Thumbnail5.png" class="thumbnail"></div>
					<div style="text-align: center; font-size: 20px;">TEST 5</div>
				</td>
				<td>
					<div class="movie"><img src="/img/Thumbnail6.png" class="thumbnail"></div>
					<div style="text-align: center; font-size: 20px;">TEST 6</div>
				</td>
				<td>
					<div class="movie"><img src="/img/Thumbnail7.png" class="thumbnail"></div>
					<div style="text-align: center; font-size: 20px;">TEST 7</div>
				</td>
				<td>
					<div class="movie"><img src="/img/Thumbnail8.png" class="thumbnail"></div>
					<div style="text-align: center; font-size: 20px;">TEST 8</div>
				</td>
			</tr>
		</table>
		
	</div>

	<script>
	
	const modal = document.getElementById("modal")
	
	const thumbnail = document.querySelectorAll(".thumbnail");
	const movie = document.querySelectorAll(".movie");
	const mvFile = document.querySelectorAll(".mvFile");
	const content = document.getElementById("content");
	const modalTitle = document.getElementById("modalTitle");
	const comment = document.getElementById("comment");
	
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
			
			modal.style.display = "flex"

			let num = i+1;
			
			console.log("click " + num);
			
			var test = document.getElementById("videoTitle").value = "test" + num + ".mp4";
			
			content.innerHTML = "<video src='/video/test" + num + ".mp4' autoplay='autoplay' muted='muted' class='mvFile' id='mvFile'></video>";
			
			modalTitle.innerHTML = "<h2>test" + num + ".mp4 미리보기<h2>";
			comment.innerHTML = "test" + num + "에 대한 동영상 설명란";
			
			var mvFile = document.getElementById("mvFile");
			mvFile.addEventListener("click", function(){
				location.href = "/video/" + test;
			});
			
		});
	}
	
	
	
	</script>

</body>
</html>
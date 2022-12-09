let videoPlayer = document.getElementById("videoPlayer");
let path = document.getElementById("e_path");
let membership = document.getElementById("membership");
let title = document.getElementById("title");
let e_start_sec = document.getElementById("e_start_sec");
let e_close_sec = document.getElementById("e_close_sec");
let pfCode = document.getElementById("pf_code");
let epicode = document.getElementById("e_code");
let historyKey = document.getElementById("history_key");

const basic = "M1";
const standard = "M2";
const premium = "M3";
const omega = "M4";

const header = document.getElementById("header");
	
	function beforePlayVideo(){
		if(e_start_sec.value > 1){
			let playVideoFromStopped = confirm("最後に終了した時から再生しますか？");
			if(playVideoFromStopped){
				// 마지막 종료 시점부터 시작
				videoPlayer.currentTime = e_start_sec.value;
			}else{
				// 처음부터 보기
				e_start_sec.value = 0;
				videoPlayer.currentTime = 0;
			}
		}
	}
	
	// 뒤로가기 버튼
	function onVideo(){
		header.style.display = "flex";
	}
	function outVideo(){
		header.style.display = "none";
	}
	
	if(membership.value === basic){
		path.value = basic + "/" + path.value;
	}else if(membership.value === standard || membership.value === premium){
		path.value = standard + "/" + path.value;
	}else if(membership.value === omega){
		path.value = omega + "/" + path.value;
	}

	videoPlayer.setAttribute("src", "/video/" + path.value);

	function setVideoTime(){
		e_close_sec.value = videoPlayer.currentTime;
	}
	
	window.onpopstate = function(){
		let endSec = videoPlayer.currentTime;
		$.ajax({
			type: "GET",
			url:"http://localhost:8000/content/quitVideo?history_key=" 
			+ historyKey.value + "&pf_code=" + pfCode.value + "&e_code=" + epicode.value + "&e_close_sec=" + endSec, 
			contentType: "application/json",
			dataType: "json",
			success: function() {
				
			},
			error: function(){
				
			}
		});
	}
	
	window.addEventListener("beforeunload", function(){
		let endSec = videoPlayer.currentTime;
		$.ajax({
			type: "GET",
			url:"http://localhost:8000/content/quitVideo?history_key=" 
			+ historyKey.value + "&pf_code=" + pfCode.value + "&e_code=" + epicode.value + "&e_close_sec=" + endSec, 
			contentType: "application/json",
			dataType: "json",
			success: function() {
				
			},
			error: function(){
				
			}
		});
	})
let videoPlayer = document.getElementById("videoPlayer");
let path = document.getElementById("e_path");
let membership = document.getElementById("membership");
let title = document.getElementById("title");
let h_close_at = document.getElementById("h_close_at");
let pfCode = document.getElementById("pf_code");
let epicode = document.getElementById("e_code");
let historyKey = document.getElementById("history_key");
let e_code = document.getElementById("e_code");
let ct_path = document.getElementById("path").value;
const url = new URL(location.href).searchParams;
let filePath;
let membershipJson = {
	basic: "M1",
	standard: "M2",
	premium: "M3",
	omega: "M4"
}
for(ms in membershipJson){
	if(membership.value ===membershipJson[ms]){
		filePath = "/video/"+membership.value + "/" + ct_path;
	}
}
const header = document.getElementById("header");
window.onload = beforePlayVideo();
function beforePlayVideo() {
	start_sec.value = url.get('h_close_at');
	if (start_sec.value > 1) {
		let playVideoFromStopped = confirm("最後に終了した時点("+start_sec.value+")から再生しますか？");
		if (playVideoFromStopped) {
			// 마지막 종료 시점부터 시작
			videoPlayer.currentTime = start_sec.value;
		} else {
			// 처음부터 보기
			start_sec.value = 0;
			videoPlayer.currentTime = 0;
		}
	}
}


// 뒤로가기 버튼
function onVideo() {
	header.style.display = "flex";
}
function outVideo() {
	header.style.display = "none";
}


videoPlayer.setAttribute("src", filePath);

function setVideoTime() {
	h_close_at.value = videoPlayer.currentTime;
	return h_close_at.value;
}
$(window).on('beforeunload', function() {
let endSec = setVideoTime();
	let sendURL = window.location.search;
	let index = sendURL.indexOf("h_close_at");
	if(index>=0){
		sendURL = sendURL.substring(0,index-1);
	}
	let ct_code = url.get("ct_code");
	$.ajax({
		type: "GET",
		url: "http://localhost:8000/quitVideo" +sendURL+ "&h_close_at=" + endSec  + "&pf_code=" + pfCode.value,
		success: function() {
		},
		error: function() {
		}
	});
});
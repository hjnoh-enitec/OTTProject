
const ct_code = document.getElementById("ct_code").value;
const e_code = document.getElementById("e_code").value;
const s_code = document.getElementById("s_code").value;
const e_number = document.getElementById("e_number").value;
const s_number = document.getElementById("s_number").value;
const ct_path = document.getElementById("ct_path").value;
const h_close_at = document.getElementById("h_close_at").value;
const membership = document.getElementById("membership");
const pf_code = document.getElementById("pf_code").value;
let videoPlayer = document.getElementById("videoPlayer");
const btn = document.getElementById("btn");

let membershipJson = {
	basic: "M1",
	standard: "M2",
	premium: "M3",
	omega: "M4"
}
for (ms in membershipJson) {
	if (membership.value === membershipJson[ms]) {
		filePath = "/video/" + membership.value + "/" + ct_path;
	}
}
const header = document.getElementById("header");
window.onload = beforePlayVideo();
function beforePlayVideo() {
	if (h_close_at > 1) {
		let playVideoFromStopped = confirm("最後に終了した時点(" + h_close_at + ")から再生しますか？");
		if (playVideoFromStopped) {
			// 마지막 종료 시점부터 시작
			videoPlayer.currentTime = h_close_at;
		} else {
			// 처음부터 보기
			start_sec.value = 0;
			videoPlayer.currentTime = 0;
		}
	}
}


// 뒤로가기 버튼
function onVideo() {
	btn.style.display = "flex";
}
function outVideo() {
	btn.style.display = "none";
}


videoPlayer.setAttribute("src", filePath);

function pageOut() {
	let endSec = videoPlayer.currentTime;
	const history = {
		"ct_code": ct_code,
		"pf_code": pf_code,
		"e_code": e_code,
		"s_code": s_code,
		"e_number": e_number,
		"s_number": s_number,
		"ct_path": ct_path,
		"h_close_at": endSec
	}
	let isRun;
	if (isRun == true) {
		return;
	}
	isRun == true;
	$.ajax({
		type: "post",
		async: false,
		contentType: 'application/json',
		data: JSON.stringify(history),
		url: "http://18.183.223.7:8000/quitVideo",
		success: function(data) {
			isRun == false;
			location.href = "http://18.183.223.7:8000" + data.url;
		},
		error: function() {
		}
	});
}

$(window).on('beforeunload', function() {
	pageOut();
});
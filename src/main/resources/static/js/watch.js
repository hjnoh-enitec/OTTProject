let videoPlayer = document.getElementById("videoPlayer");
let path = document.getElementById("e_path").value;
let membership = document.getElementById("membership").value;
let title = document.getElementById("title");
let e_start_sec = document.getElementById("e_start_sec").value;
let e_close_sec = document.getElementById("e_close_sec");
let pfCode = document.getElementById("pf_code").value;
let epicode = document.getElementById("e_code").value;

const basic = "M1";
const standard = "M2";
const premium = "M3";
const omega = "M4";

const backToMain = document.getElementById("backToMain");
	
	if(membership === basic){
		path = basic + "/" + path;
	}else if(membership === standard || membership === premium){
		path = standard + "/" + path;
	}else if(membership === omega){
		path = omega + "/" + path;
	}

	// 마지막 종료 시점부터 시작
	videoPlayer.currentTime = e_start_sec;

	videoPlayer.setAttribute("src", "/video/" + path);

	function setVideoTime(){
		e_close_sec.value = videoPlayer.currentTime;
	}
	
	// 뒤로가기 버튼
	//function onVideo(){
	//	backToMain.style.display = "flex";
	//}
	//function outVideo(){
	//	backToMain.style.display = "none";
	//}
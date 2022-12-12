let pfCode = document.getElementById("pf_code").value;
const defaultCloseTime = 0;

let loginID = document.getElementById("loginID").value;
let modal = document.getElementById("modal");

let thumbnail = document.querySelectorAll(".thumbnail");
let movie = document.querySelectorAll(".movie");
let mvFile = document.querySelectorAll(".mvFile");
let content = document.getElementById("content");
let modalTitle = document.getElementById("modalTitle");
let comment = document.getElementById("comment");
let contentForm = document.getElementById("contentForm");
let seasonInfo = document.getElementById("seasonInfo");
let seasonSelect = document.getElementById("seasonSelect");
let rating = document.getElementById("rating");

let append = document.getElementById("append");

let code = document.querySelectorAll(".video_code");
let title = document.querySelectorAll(".video_title");
let path = document.querySelectorAll(".video_path");
let info = document.querySelectorAll(".video_info");
let video = document.querySelectorAll(".video_video");
let genre = document.querySelectorAll(".video_g_code");

let closeBtn = modal.querySelector(".close-area");
closeBtn.addEventListener("click", e => {
	modal.style.display = "none"
});

modal.addEventListener("click", e => {
	let evTarget = e.target
	if (evTarget.classList.contains("modal-overlay")) {
		modal.style.display = "none"
	}
});

for (let i = 0; i < movie.length; i++) {
	
	movie[i].addEventListener("click", function() {

		modal.style.display = "flex"
		modalTitle.innerHTML = "<h2>" + title[i].value + "<h2>";
		comment.innerHTML = info[i].value;

		// 로그인, 멤버십 여부에 따라 각기 다른 페이지로 이동함
		if (loginID === 'Guest') {
			contentForm.innerHTML =
				"<video src='/video/M1/" + path[i].value + "'autoplay='autoplay' muted='muted' class='mvFile' id='mvFile'></video>";
		} else {
			contentForm.innerHTML =
				"<input type='hidden' name='pf_code' id='currentProfile' value='s45511071G_PF01'>" +
				"<video src='/video/M1/" + path[i].value + "'autoplay='autoplay' muted='muted' class='mvFile' id='mvFile'></video>";
		}

		// 시즌 선택창 표시 여부 (테스트용으로 특정 장르일 시에 시즌이 나오게 해 둠)
		if (genre[i].value === "10770") {
			seasonSelect.style.display = "flex";
		} else {
			seasonSelect.style.display = "none";
		}
		
		// 처음 모달창 클릭 시 컨텐츠 코드로 시즌 정보를 가져옴
		// http://localhost:8000/content/컨트롤러 매핑 이름?보낼 인자가 들어간 input태그의 name=보낼 값
		$.ajax({
			type: "GET",
			url: "http://localhost:8000/content/searchSeasonByCcode?ct_code=" + code[i].value,
			contentType: "application/json",
			dataType: "json",
			success: function(data) {
				str = '';
				$.each(data, function(i) {
					str += "<option value='" + data[i].s_code + "'>" + data[i].s_name + "</option>";
				});
				seasonSelect.innerHTML = str;

				append.innerHTML = "";
				
				// 시즌 정보를 가져온 후, 첫 번째 시즌의 코드를 가지고 에피소드 정보를 불러옴
				$.ajax({
					type: "GET",
					url: "http://localhost:8000/content/searchEpiBySeason?s_code=" + seasonSelect.value,
					contentType: "application/json",
					dataType: "json",
					success: function(data) {
						str = '';
						$.each(data, function(i) {
							str += "<div style='color: white;'>";
							str += "<form action='/content/watch', method='get'>";
							str += "<input type='hidden' name='e_code' id='epicode' value='"+ data[i].e_code +"'>";
							str += "<input type='hidden' name='h_close_at' id='h_close_at'>";
							str += "<button>"
							str += "<video src='/video/M1/" + data[i].e_path + "' class='season_video'></video>" + data[i].e_name;
							str += "</button></form></div>";
						});
						append.innerHTML = str;
						
						var epicode = document.getElementById("epicode");
		
						// 에피소드별 시청기록 가져오기
						$.ajax({
							type: "GET",
							url: "http://localhost:8000/content/findSecByPfcodeAndEcode?pf_code=" + pfCode + "&e_code=" + epicode.value,
							contentType: "application/json",
							dataType: "json",
							success: function(data){
								console.log("TEST : " + data);
								document.getElementById("h_close_at").value = data;
							},
							error: function(){
								
							}	
						});
					},
					error: function(status) {
						alert(status + "error!");
					}
				});
			},
			error: function(status) {
				alert(status + "error!");
			}
		});
		
		// 컨텐츠 별 평점 가져오기
		$.ajax({
			type: "GET",
			url: "http://localhost:8000/content/calcRatingByCtcode?ct_code=" + code[i].value,
			contentType: "application/json",
			dataType: "json",
			success: function(data) {
				// 평가가 존재할 시
				const fullScore = 10;
				rating.innerHTML = "★ " + data + " / " + fullScore;
			},
			error: function() {
				// 평가가 존재하지 않을 시
				rating.innerHTML = 'まだユーザー評価がございません。';
			}
		});

	});

}

let season_video = document.querySelectorAll(".season_video");
for(let i = 0; i < season_video.length; i++){
	season_video[i].addEventListener("click", function(){
	})
}

for (let i = 0; i < movie.length; i++) {
	movie[i].addEventListener("mouseover", function() {
		video[i].style.display = "flex";
		thumbnail[i].style.display = "none";
	});

	movie[i].addEventListener("mouseout", function() {
		video[i].style.display = "none";
		thumbnail[i].style.display = "flex";
	});
}

// 시즌제 컨텐츠에서 시즌 바꿀 시
function changeSeason(target) {
	append.innerHTML = "";
	$.ajax({
		type: "GET",
		url: "http://localhost:8000/content/searchEpiBySeason?s_code=" + target.value,
		contentType: "application/json",
		dataType: "json",
		success: function(data) {
			str = '';
			$.each(data, function(i) {
				str += "<div style='color: white;'><video src='/video/M1/" + data[i].e_path + "' class='season_video'></video>" + data[i].e_name + "</div>";
			});
			append.innerHTML = str;
		},
		error: function(status) {
			alert(status + "error!");
		}
	});
}
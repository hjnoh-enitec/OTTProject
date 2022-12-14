let scaling;                                         //컨텐츠에 마우스 올라갔을 때 배율 조정
let currentSliderCount;                              //이전 슬라이드 수
let videoCount;										//비디오 카운트
let showCount;
let sliderCount;
let controlsWidth;
let scollWidth;
let frameWidth;
let content;
let modal;
let modalContentTitle;
let modalContentPreview;
let modalContentOverview;
let modalContentAvg;
let modalWindow;
let playBtn;
let seasonSel;
let episodes;
let contentId;
let s_num;

window.onload = function() {
	//modal
	modal = document.getElementById("modal");
	modalContentTitle = document.getElementById("contentTitle");
	modalContentPreview = document.getElementById("contentPreview");
	modalContentOverview = document.getElementById("overview");
	modalContent = document.getElementById("content");
	modalWindow = document.getElementById("modalWindow");
	seasonSel = document.getElementById("seasonSelect");
	episodes = document.getElementById("episodes");
	//slideFrame
	scaling = 1.50;
	scollWidth = 0;
	currentSliderCount = 0;                                 //이전 슬라이드 수
	showCount = 10;
	videoCount = document.getElementsByClassName("slide s1").length;//비디오 카운트
	sliderCount = videoCount / showCount;
	controlsWidth = 40;
	content = document.querySelector(".slide");
	modalContentAvg = document.getElementById("avg");
	playBtn = document.getElementById("play");

	let win = $(window);
	let sliderFrame = $(".slider-frame");
	let sliderContainer = $(".slider-container");
	let slide = $(".slide");
	//counts

	$('.slide.s1:nth-last-child(-n+4)').prependTo('.slider-container.sc1');
	$('.slide.s2:nth-last-child(-n+4)').prependTo('.slider-container.sc2');
	//$(window).resize(function() {
	//	init();
	//});



	//sizes
	let windowWidth = win.width();
	frameWidth = win.width() - 80;
	let videoWidth = 200;
	let videoHeight = 300;
	let videoWidthDiff = (videoWidth * scaling) - videoWidth;
	let videoHeightDiff = (videoHeight * scaling) - videoHeight;



	//set sizes
	sliderFrame.width(windowWidth);



	sliderContainer.width((videoWidth * videoCount) + videoWidthDiff);
	sliderContainer.css("top", (videoHeightDiff / 2 - 45));
	sliderContainer.css("margin-left", (controlsWidth));

	slide.height(videoHeight);
	slide.width(videoWidth);
	//hover effect
	$(".slide").mouseover(function() {
		$(this).css("width", videoWidth + 20);
		$(this).css("height", videoHeight + 20);
		$(this).css("top", -20);
		if ($(".slide").index($(this)) == 0 || ($(".slide").index($(this))) % 4 == 0) {
			// do nothing
		}
		else if (($(".slide").index($(this)) + 1) % 4 == 0 && $(".slide").index($(this)) != 0) {
			$(this).parent().css("margin-left", -(videoWidthDiff - controlsWidth));
		}
		else {
			$(this).parent().css("margin-left", - (videoWidthDiff / 2));
		}

	}).mouseout(function() {
		$(this).css("width", videoWidth * 1);
		$(this).css("height", videoHeight * 1);
		$(this).css("top", 10);
		$(this).parent().css("margin-left", controlsWidth);
	});
}
function prev(num) {
	console.log(currentSliderCount);
	console.log(sliderCount);
	if (currentSliderCount == 0) {
		return false;
	}
	scollWidth -= frameWidth;
	console.log(scollWidth);
	$('.slider-container.sc' + num).animate({
		left: - scollWidth
	}, 300, function() {
		currentSliderCount--;
	});
	$(".slider-container.sc" + num).css("left", scollWidth);
}
function next(num) {
	console.log(currentSliderCount);
	console.log(sliderCount);
	if (currentSliderCount >= sliderCount) {
		return false;
	}
	scollWidth += frameWidth;

	$('.slider-container.sc' + num).animate({
		left: - scollWidth
	}, 300, function() {
		console.log(scollWidth);
		currentSliderCount++;
	});
}
let baseURL;
function clickImg(img, isTv) {
	window.scroll(0, 0);
	contentId = img.id;
	if (isTv === "true") {
		baseURL = "https://api.themoviedb.org/3/tv/"
	} else {
		baseURL = "https://api.themoviedb.org/3/movie/";
	}
	$.ajax({
		type: 'get',
		url: baseURL + contentId + "?api_key=638aa1b1cb8fa91819a382dabe206684&language=ja",
		async: false,
		success: function(data) {
			//메인 예고편의 재생을 멈춤
			mainPreview.contentWindow.postMessage(
				'{"event":"command","func":"' + 'pauseVideo' + '","args":""}',
				'*',
			);
			let title;
			if (isTv === "true") {
				title = data["original_name"];
				setSeason(data.seasons);
			} else {
				title = data["original_title"]
			}
			let overView = data["overview"];
			if (overView.length > 100) {
				overView = overView.substring(0, 200);
				overView += "...";
			}
			modalContentOverview.innerHTML = overView;
			modalContentTitle.innerHTML = title;
			modalContentAvg.innerHTML = "&nbsp" + data["vote_average"] + "点&nbsp";

			setPreview(data.id, data.poster_path, isTv);
			modal.style.display = "flex";
		},
		error: function(request, error) {
			alert("code:" + request.status + "\n" + "message:"
				+ request.responseText + "\n" + "error:" + error);
		}
	})
}
function setPreview(id, posterPath, isTv) {
	$.ajax({
		type: 'get',
		url: baseURL + id + "/videos?api_key=638aa1b1cb8fa91819a382dabe206684&language=ja",
		async: false,
		success: function(data) {
			if (data.results[0] === undefined) {
				const img = document.createElement("img");
				const discription = document.getElementById("discription")
				discription.style.position = "150";
				img.setAttribute("src", "https://image.tmdb.org/t/p/w500/" + posterPath);
				img.setAttribute("class", "contentPreviewImg");
				modalContentPreview.appendChild(img);
			} else {
				const iframe = document.createElement("iframe");
				iframe.setAttribute("src", "https://www.youtube.com/embed/" + data.results[0].key + "?controls=0&autoplay=1&mute=1")
				iframe.setAttribute("frameborder", "0");
				iframe.setAttribute("class", "contentPreviewVideo");
				modalWindow.style.top = "0px";
				modalContentPreview.appendChild(iframe);
			}
			if (isTv!=="true") {
				modalContent.setAttribute("onmouseover", "displayPlayBtn()");
				modalContent.setAttribute("onmouseout", "hidePlayBtn()");
			}
		},
		error: function(request, error) {
			alert("code:" + request.status + "\n" + "message:"
				+ request.responseText + "\n" + "error:" + error);
		}
	})
}

function closeModal() {
	modal.style.display = "none";
	//메인 예고편의 재생을 재개함
	mainPreview.contentWindow.postMessage(
		'{"event":"command","func":"' + 'playVideo' + '","args":""}',
		'*',
	);
	clearModal();
}
function clearModal() {
	modalContentTitle.innerHTML = "";
	modalContentPreview.innerHTML = "";
	modalContentOverview.innerHTML = "";
	modalContentAvg.innerHTML = "";
	episodes.innerHTML = "";
	seasonSel.innerHTML = "";
	modalContent.removeAttribute("onmouseover");
	modalContent.removeAttribute("onmouseout");
	playBtn.style.display = "none";
	seasonSel.style.display = "none";
	modalWindow.style.height = "500px";
	modalWindow.style.top = "0px";
}
function displayPlayBtn() {
	playBtn.style.display = "flex";
}
function hidePlayBtn() {
	playBtn.style.display = "none";

}
function setSeason(seasonInfo) {
	let seasonSel = document.getElementById("seasonSelect");
	seasonSel.style.display = "flex";
	modalWindow.style.height = "900px";
	modalWindow.style.top = "30px";
	for (let i = 0; i < seasonInfo.length; i++) {
		let option = document.createElement("option");
		option.setAttribute("value", seasonInfo[i].season_number)
		option.innerHTML = seasonInfo[i].name + "(総" + seasonInfo[i].episode_count + "のエピソード)";
		let sellWidth = seasonSel.style.width.replace("px", "");
		if (sellWidth / 17 < option.innerHTML.length) {
			seasonSel.style.width = option.innerHTML.length * 17 + "px";
		}
		if (i == 0) {
			setEpisonde(seasonInfo[i].season_number);
		}
		seasonSel.appendChild(option);
	}
	s_num = seasonSel.value;
}
function setEpisonde(seasonNum) {
	$.ajax({
		type: 'get',
		url: baseURL + contentId + "/season/" + seasonNum + "?api_key=638aa1b1cb8fa91819a382dabe206684&language=ja",
		async: false,
		success: function(data) {
			episodes.scroll(0, 0);
			for (let i = 0; i < data.episodes.length; i++) {
				let episodesData = data.episodes;
				let episode = document.createElement("div");
				episode.setAttribute("class", "episode");
				let title = document.createElement("h4");
				title.setAttribute("class", "episodeTitle");
				title.innerHTML = episodesData[i].name + "(" + episodesData[i].vote_average + ")";
				title.style.paddingTop = "20px";
				let tumbNail = document.createElement("img");
				tumbNail.style.marginLeft = "20px";
				tumbNail.setAttribute("src", "https://image.tmdb.org/t/p/w200/" + episodesData[i].still_path);
				tumbNail.setAttribute("onclick", "watchVideo(this)");
				tumbNail.setAttribute("id", episodesData[0].episode_number);
				let discription = document.createElement("h4");
				discription.innerHTML =
					episode.appendChild(title);
				episode.appendChild(tumbNail);
				episodes.appendChild(episode);
			}
		},
		error: function(request, error) {
			alert("code:" + request.status + "\n" + "message:"
				+ request.responseText + "\n" + "error:" + error);
		}
	})
}

function changeSeason() {
	s_num = seasonSel.value;
	episodes.innerHTML = "";
	setEpisonde(parseInt(s_num));
}
function watchVideo(episodes) {
	let e_number = "";
	if (episodes !== undefined) {
		e_number = episodes.id;
		hidePlayBtn();
 		location.href = "http://localhost:8000/content/watch?ct_code=" + contentId + "&e_number=" + e_number + "&s_num=" + s_num;
	}else{
		location.href = "http://localhost:8000/content/watch?ct_code=" + contentId;
	}
}
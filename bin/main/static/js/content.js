let scaling;                                      
let currentSliderCount;                             
let videoCount;										
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
let s_value;
let historyCnt;
const urlPath = document.getElementById("urlPath").value;
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
	scollWidth = {scollWidth1 : 0,scollWidth2 : 0,scollWidth3 : 0};
	currentSliderCount = {slideCnt1 : 0,slideCnt2 : 0,slideCnt3 : 0};                              
	showCount = 10;
	videoCount ={
		videoCount1 : document.getElementsByClassName("slide s1").length,
		videoCount2 : document.getElementsByClassName("slide s2").length,
		videoCount3 : document.getElementsByClassName("slide s3").length
		
	} 
	
	
	sliderCount ={
		sliderCount1 : videoCount["videoCount1"] / showCount,
		sliderCount2 : videoCount["videoCount2"] / showCount,
		sliderCount3 : videoCount["videoCount3"] / showCount,
		
	} 
	
	
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
	sliderFrame.width("100%");
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
	if (currentSliderCount["slideCnt"+num] == 0) {
		return false;
	}
	scollWidth["scollWidth"+num] -= frameWidth;
	$('.slider-container.sc' + num).animate({
		left: - scollWidth["scollWidth"+num]
	}, 300, function() {
		currentSliderCount["slideCnt"+num]--;
	});
	$(".slider-container.sc" + num).css("left", scollWidth["scollWidth"+num]);
}
function next(num) {
	if (currentSliderCount["slideCnt"+num] >= sliderCount["sliderCount"+num]) {
		return false;
	}
	scollWidth["scollWidth"+num] += frameWidth;
	$('.slider-container.sc' + num).animate({
		left: - scollWidth["scollWidth"+num]
	}, 300, function() {
		console.log(scollWidth["scollWidth"+num]);
		currentSliderCount["slideCnt"+num]++;
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
			if (isTv !== "true") {
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
	modalWindow.style.height = "920px";
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
	s_value = seasonSel.value;
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
				title.innerHTML = episodesData[i].name + "(" + Math.round(episodesData[i].vote_average) + ")";
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
	s_value = seasonSel.value;
	episodes.innerHTML = "";
	setEpisonde(parseInt(s_value));
}
function clickHistory(clickedContent, h_close_at, e_value, s_value, path) {
	contentId = clickedContent.id;
	if (isAPI(clickedContent.id)) {
		if (e_value == undefined && s_value == undefined) {
			location.href = urlPath+"/content/watch?ct_code=" + contentId + "&h_close_at=" + h_close_at+"&ct_path=" + path ;
		} else {
			location.href = urlPath+"/content/watch?ct_code=" + contentId + "&e_number=" + e_value + "&s_number=" + s_value + "&h_close_at=" + h_close_at+"&ct_path=" + path;
		}
	} else {
		if (e_value == undefined && s_value == undefined) {
			location.href = urlPath+"/content/watch?ct_code=" + contentId + "&h_close_at=" + h_close_at+"&ct_path=" + path;
		} else {
			location.href = urlPath+"/content/watch?ct_code=" + contentId + "&e_code=" + e_value + "&s_code=" + s_value + "&h_close_at=" + h_close_at+"&ct_path=" + path;
		}
	}
}
function isAPI(contentId) {
	return !contentId.startsWith('T');
}
function clickdbImg(content, ct_title, ct_info, ct_star, ct_path) {
	contentId = content.id;
	mainPreview.contentWindow.postMessage(
		'{"event":"command","func":"' + 'pauseVideo' + '","args":""}',
		'*',
	);
	if (contentId.startsWith('CT')) {
	} else {
		if (ct_info.length > 100) {
			ct_info = ct_info.substring(0, 200);
			ct_info += "...";
		}
		modalContentOverview.innerHTML = ct_info;
		modalContentTitle.innerHTML = ct_title;
		modalContentAvg.innerHTML = ct_star;
		const video = document.createElement("video");
		video.setAttribute("src", urlPath+"/video/M1/" + ct_path)
		modalContentPreview.appendChild(video);
		modal.style.display = "flex";
		modalContent.setAttribute("onmouseover", "displayPlayBtn()");
		modalContent.setAttribute("onmouseout", "hidePlayBtn()");
		playBtn.setAttribute("value",ct_path)
	}
}
function watchVideo(episodes) {
	let e_value = "";
	let ct_path = "test.mp4"
	if (contentId.startsWith('CT')) {
	} else if(contentId.startsWith('T')) {
		location.href = "/content/watch?ct_code=" + contentId+ "&ct_path="+ episodes.value;
	}
	else if (episodes.id!="play") {
		e_value = episodes.id;
		hidePlayBtn();
		if (contentId.startsWith('T')) {
			location.href = urlPath+"/content/watch?ct_code=" + contentId + "&e_code=" + e_value + "&s_code=" + s_value+ "&ct_path="+ ct_path;
		}
		location.href = urlPath+"/content/watch?ct_code=" + contentId + "&e_number=" + e_value + "&s_number=" + s_value+ "&ct_path="+ ct_path;
	} else {
		location.href = urlPath+"/content/watch?ct_code=" + contentId+ "&ct_path="+ ct_path;
	}
}

// main page preview영상 랜덤재생
var preViewVideos = ['zqhU76d690o', 'EzGDPZhPjRA', 'n800hOJmgWo', 'HghrzTldjpc', 'kFqJhAk4Ul0', 'k4xGqY5IDBE', 'rzKcrJ77wBY', 'YLDxwZHRP6o'];
	
		var mainPreview = document.getElementById("mainPreview");
	
		function choosePreviewVideo(min, max){
		    var videoNum = Math.floor(Math.random()*(max-min+1));
		    console.log(videoNum);
		    return videoNum;
		}
	
		mainPreview.setAttribute("src", "https://www.youtube.com/embed/" + preViewVideos[choosePreviewVideo(0, preViewVideos.length-1)] + "?enablejsapi=1&controls=0&autoplay=1&mute=1");
		console

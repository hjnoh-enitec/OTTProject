let scaling;                                         //컨텐츠에 마우스 올라갔을 때 배율 조정
let currentSliderCount;                                 //이전 슬라이드 수
let videoCount;//비디오 카운트
let showCount;
let sliderCount;
let controlsWidth;
let scollWidth;
let frameWidth;			
let sliderContainer1 = document.getElementById("sc1")
let sliderContainer2 = document.getElementById("sc2")

window.onload = function() {
	this.scaling = 1.50;                                         //컨텐츠에 마우스 올라갔을 때 배율 조정
	this.currentSliderCount = 0;                                 //이전 슬라이드 수
	this.videoCount = document.getElementsByClassName("slide s1").length;//비디오 카운트
	this.showCount = 10;
	this.sliderCount = videoCount / showCount;
	this.controlsWidth = 40;
	this.scollWidth = 0;

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
	if (windowWidth >= 0 && windowWidth <= 414) {
		showCount = 2;
	} else if (windowWidth >= 414 && windowWidth <= 768) {
		showCount = 3;
	} else {
		showCount = 4;
	}
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
	sliderContainer1.setAttribute("scollWidth", sliderContainer1.getAttribute("scollWidth")-frameWidth);
	console.log(scollWidth);
	$('.slider-container.sc'+num).animate({
		left: - scollWidth
	}, 300, function() {

		currentSliderCount--;
	});
	$(".slider-containe.sc"+num).css("left", scollWidth);
}
function next(num) {
	console.log(currentSliderCount);
	console.log(sliderCount);
	if (currentSliderCount >= sliderCount) {
		return false;
	}
	scollWidth += frameWidth;
	
	$('.slider-container.sc'+num).animate({
		left: - scollWidth
	}, 300, function() {
		console.log(scollWidth);
		currentSliderCount++;
	});
}



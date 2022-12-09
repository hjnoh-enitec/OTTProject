<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page session="false"%>
<%@ page import="java.net.URLDecoder"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/css/content.css">
<meta charset="UTF-8">
<title>contentPage</title>
</head>
<body>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="/js/content.js"></script>

	<!-- 윈도우 전체 -->
	<div id="modal" class="modal-overlay">
		<!-- 모달 컨텐츠 -->
		<div class="modal-window" id="modalWindow">
			<!-- 예고편 - 클릭하면 재생화면으로 넘어간다. -->
			<div class="content" id="content" onclick="watchVideo()">
				<!-- 컨텐츠 제목 -->
				<div class="discription" id="discription">
					<button class="play" id="play"></button>
					<div class="title">
						<h1 id="contentTitle"></h1>
						<h1 id=avg></h1>
					</div>
					<div class="comment" id="overview"></div>
				</div>
				<!-- 줄거리 -->

				<!-- 닫기버튼 -->
				<div class="close-area" onClick="closeModal()">X</div>
				<form:form id="contentPreview">
				</form:form>
			</div>
			<!-- 시즌정보 셀렉트 박스-->
			<div class="seasons">
				<select class="seasonSelect" id="seasonSelect"
					style="width: 200px; height: 50px; font-size: 17px; text-align: left;"
					onchange="changeSeason()">
				</select>
				<div class="episodes" id="episodes"></div>
			</div>
		</div>
	</div>
	<div>
		<iframe width="1900px" height="1100px" id="mainPreview"
			src="https://www.youtube.com/embed/jk7QSGwupPA?enablejsapi=1&controls=0&autoplay=1&mute=1"
			frameborder="0"></iframe>
		<div class="catalog">
			<h1 class="slideTitle">Ted様が観ていた物</h1>
			<div class="slider-frame sf1">
				<div class="btn prev bp1" onclick="prev(1)"></div>
				<div class="btn next bn1" onclick="next(1)"></div>
				<div class="slider-container sc1" id="sc1">
					<c:forEach items="${playedList}" var="content">
						<img class="slide s1" id="${content.ct_code}"
							onclick="clickImg(this,'false')"
							src="https://image.tmdb.org/t/p/w200${content.thumbnail}">
					</c:forEach>
				</div>
			</div>
			<h1 class="slideTitle">映画ランキング</h1>
			<div class="slider-frame sf1">
				<div class="btn prev bp1" onclick="prev(1)"></div>
				<div class="btn next bn1" onclick="next(1)"></div>
				<div class="slider-container sc1" id="sc1">
					<c:forEach items="${topRated}" var="content">
						<img class="slide s1" id="${content.ct_code}"
							onclick="clickImg(this,'false')"
							src="https://image.tmdb.org/t/p/w200${content.thumbnail}">
					</c:forEach>
				</div>
			</div>
			<h1 class="slideTitle">TVランキング</h1>
			<div class="slider-frame sf2">
				<div class="btn prev bp2" onclick="prev(2)"></div>
				<div class="btn next bn2" onclick="next(2)"></div>
				<div class="slider-container sc2" id="sc2">
					<c:forEach items="${myList}" var="content">
						<img class="slide s2" id="${content.ct_code}"
							onclick="clickImg(this,'true')"
							src="https://image.tmdb.org/t/p/w200${content.thumbnail}">
					</c:forEach>
				</div>
			</div>
		</div>

	</div>


</body>
</html>
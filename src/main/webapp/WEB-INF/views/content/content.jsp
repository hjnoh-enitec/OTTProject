<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page session="false"%>
<%@ page import="java.net.URLDecoder"%>
<%@ include file="/jsp/home/header.jsp"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:eval expression="@environment.getProperty('path.urlPath')"
	var="urlPath" />
<c:set var="profile"
	value="${request.getSession(false)=='' ? '' : pageContext.request.session.getAttribute('profile')}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>contentPage</title>
<link rel="stylesheet" href="/css/content.css">

</head>
<body>
<<<<<<< HEAD

	<input type="hidden" id="urlPath" value="${urlPath}">
=======
<input type="hidden" id="urlPath" value="${urlPath}">
>>>>>>> 087380a21262258fec94bd000c73446677d87e89
	<!-- 윈도우 전체 -->
	<div id="modal" class="modal-overlay">
		<!-- 모달 컨텐츠 -->
		<div class="modal-window" id="modalWindow">
			<!-- 예고편 - 클릭하면 재생화면으로 넘어간다. -->
			<div class="content" id="content">
				<!-- 컨텐츠 제목 -->
				<div class="discription" id="discription">
					<button class="play" id="play" onclick="watchVideo(this)"></button>
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
	<div style="text-align: center;">
		<input type="hidden" id="urlPath" value="${urlPath}">
		<iframe width="99%" height="1100px" id="mainPreview"
			src="https://www.youtube.com/embed/zqhU76d690o?enablejsapi=1&controls=0&autoplay=1&mute=1"
			frameborder="0"></iframe>
		<div class="catalog">
			<input type="hidden" id="pf_code" name="pf_code"
				value="${profile.pf_code}">
			<c:if test="${profile ne null}">
				<c:if test="${fn:length(playedList) ne 0}">
					<h1 class="slideTitle" style="float: left;">視聴中のコンテンツ -
						${profile.pf_name}</h1>
					<div class="slider-frame sf3">
						<div class="btn prev bp3" onclick="prev(3)" style="color: white;">
							P<br>R<br>E<br>V
						</div>
						<div class="btn next bn3" onclick="next(3)" style="color: white;">
							N<br>E<br>X<br>T
						</div>
						<div class="slider-container sc3" id="sc1">
							<c:forEach items="${playedList}" var="playedList">
								<c:if test="${playedList.e_number ne '-1'}">
									<c:if test="${playedList.e_code eq null}">
										<img class="slide s3" id="${playedList.ct_code}"
											onclick="clickHistory(this,'${playedList.h_close_at}','${playedList.e_number}','${playedList.s_number}','${playedList.path}')"
											src="${playedList.imgPath}">
									</c:if>
									<c:if test="${playedList.e_code ne null}">
										<img class="slide s3" id="${playedList.ct_code}"
											onclick="clickHistory(this,'${playedList.h_close_at}','${playedList.e_code}','${playedList.s_code}','${playedList.path}')"
											src="${playedList.imgPath}">
									</c:if>
								</c:if>
								<c:if test="${playedList.e_number eq '-1'}">
									<img class="slide s3" id="${playedList.ct_code}"
										onclick="clickHistory(this,'${playedList.h_close_at}','${playedList.e_code}','${playedList.s_code}','${playedList.path}')"
										src="${playedList.imgPath}">
								</c:if>

							</c:forEach>
						</div>
					</div>
				</c:if>
			</c:if>
			<h1 class="slideTitle" style="float: left;">映画ランキング</h1>
			<div class="slider-frame sf1">
				<div class="btn prev bp1" onclick="prev(1)" style="color: white;">
					P<br>R<br>E<br>V
				</div>
				<div class="btn next bn1" onclick="next(1)" style="color: white;">
					N<br>E<br>X<br>T
				</div>
				<div class="slider-container sc1" id="sc1">
					<c:forEach items="${dbMoiveList}" var="dbMoiveList">
						<img class="slide s1" id="${dbMoiveList.ct_code}"
							onclick="clickdbImg(
								this,'${dbMoiveList.ct_title}',
								'${dbMoiveList.ct_info}','${dbMoiveList.ct_star}','${dbMoiveList.ct_path}'		
							)"
							src="${dbMoiveList.ct_path_thumbnail}">
					</c:forEach>
					<c:forEach items="${topRated}" var="topRated">
						<img class="slide s1" id="${topRated.ct_code}"
							onclick="clickImg(this,'false')"
							src="https://image.tmdb.org/t/p/w200${topRated.thumbnail}">
					</c:forEach>
				</div>
			</div>
			<h1 class="slideTitle" style="float: left;">TVランキング</h1>
			<div class="slider-frame sf2">
				<div class="btn prev bp2" onclick="prev(2)" style="color: white;">
					P<br>R<br>E<br>V
				</div>
				<div class="btn next bn2" onclick="next(2)" style="color: white;">
					N<br>E<br>X<br>T
				</div>
				<div class="slider-container sc2" id="sc2">
					<c:forEach items="${myList}" var="myList">
						<img class="slide s2" id="${myList.ct_code}"
							onclick="clickImg(this,'true')"
							src="https://image.tmdb.org/t/p/w200${myList.thumbnail}">
					</c:forEach>
				</div>
			</div>
		</div>

	</div>
<<<<<<< HEAD

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="/js/content.js"></script>

=======
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="/js/content.js"></script>
>>>>>>> 087380a21262258fec94bd000c73446677d87e89
</body>
</html>
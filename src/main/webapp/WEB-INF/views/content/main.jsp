<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page session="false"%>
<%@ page import="java.net.URLDecoder"%>
<c:set var="profile" value="${request.getSession(false)=='' ? '' : pageContext.request.session.getAttribute('profile')}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OTT - Content Page</title>
<link rel="stylesheet" href="/css/content.css">
</head>
<body>

	<div id="container"></div>
	
	<!-- 모달 전체 (화면 흐려지는 곳) -->
	<div id="modal" class="modal-overlay">
		
		<!-- 본 모달창 -->
		<div class="modal-window">
			<!-- 컨텐츠 제목 -->
			<div class="title" id="modalTitle"></div>
			<div class="close-area">X</div>
			
			<!-- 미리보기 -->
			<div class="content" id="contentForm">
			
			</div>
			
			<!-- 평점 -->
			<div style="text-align: center; font-size: 15px; color: white;" id="rating"></div>
			
			<!-- 영상 설명 -->
			<div class="comment" id="comment"></div>
			
			<!-- 시즌이 있을 경우에 시즌을 고를 수 있는 선택창 -->
			<div>
				<select id="seasonSelect" style="width: 200px; height: 50px; font-size: 17px; text-align: left;" onchange="changeSeason(this)">
				</select>
			</div>
			
			<!-- 선택된 시즌에 포함된 에피소드들 -->
			<div id="append"></div>
			
		</div>

	</div>

	<div id="menu">
		<ul>
			<c:if test="${loginID != null}">
				<li>${loginID } 様</li>
				<li>${profile.pf_name }</li>
				<input type="hidden" value="${loginID }" id="loginID">
				<input type="hidden" value="${membership }" id="membership">
				<input type="hidden" value="${profile.pf_code }" id="pf_code">
			</c:if>
			<li><a href="<c:url value='/profile/select'/>">プロフィール選択</a></li>
			<li><a href="<c:url value='/login/logout'/>">ログアウト</a></li>
			<li><a href=""><i class="fa fa-search"></i></a></li>
		</ul>
	</div>
	<!-- 컨텐츠 목록 -->
	<div class="movies">
		<!-- 컨텐츠 하나하나 -->
		<c:forEach var="cList" items="${contentList}">
			<div class="movie">
				<input type="hidden" class="video_code" name="ct_code" value="<c:out value="${cList.ct_code}" />">
				<input type="hidden" class="video_title" value="<c:out value="${cList.ct_title}" />">
				<input type="hidden" class="video_path" value="<c:out value="${cList.ct_path}" />">
				<input type="hidden" class="video_g_code" value="<c:out value="${cList.g_code}" />">
				<input type="hidden" class="video_info" value="<c:out value="${cList.ct_info}" />">
				<div>
					<img src="<c:out value="${cList.ct_path_thumbnail}" />" class="thumbnail">
					<video src="<c:out value="/video/M1/${cList.ct_path}" />" autoplay="autoplay" muted="muted" class="video_video"></video>
				</div>
				<div style="text-align: center; font-size: 20px;"><c:out value="${cList.ct_title}" /></div>
			</div>
		</c:forEach>
	</div>
	
	<!-- https://www.youtube.com/embed/3WUw9thZR4k?autoplay=1&mute=1&controls=0&rel=0&disablekb=1&Loop=1 -->
	
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="/js/content.js"></script>

</body>
</html>
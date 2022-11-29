<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Netflix</title>

<script src="https://kit.fontawesome.com/c7adb7b803.js"
   crossorigin="anonymous"></script>
<!-- 폰트/ 아이콘 -->
<link
	href="<c:url value= "${pageContext.request.contextPath}/resources/css/video-js.css"/>"
	type="text/css" rel="stylesheet">
<script src="http://vjs.zencdn.net/c/video.js"></script>
<link href="<c:url value="/resources/css/reset.css?ver=1" />" rel="stylesheet">
<link href="<c:url value="/resources/css/main_top_style.css?ver=1" />"
   rel="stylesheet">
<link href="<c:url value="/css/mainStyle.css?ver=1" />"
   rel="stylesheet">
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<style>
.hide_menu {
   display: flex !important;
}
.main-table {
   display: table !important;
}
</style>
</head>
<body>

   <main id="main">

   <div class="popular_movie">
      <video  id="vid" muted="muted"
         poster="http://kghosting.dothome.co.kr/poster/spy_big.png">
         <source src="http://kghosting.dothome.co.kr/video/spy.mp4"
            type="video/mp4">
      </video>
      <div class="popular_movie_info_box">
         <div class="popular_movie_info">
            <div class="popular_movie_title">
               <img
                  src="http://kghosting.dothome.co.kr/logo/spy_logo.png"
                  alt="">
            </div>
            <div class="popular_movie_overview">스파이, 암살자 그리고 초능력자. 각자 다른 사정이 있는 세 사람이 
            서로에게 정제를 숨기고 가상 가족을 결성한다. 요즘 대세 애니메이션</div>
         </div>
         <div class="popular_btn_box">
            <button class="popular_movie_play popular_btn" onclick="hidden_video()">
               <i class="fas fa-play">재생</i>
            </button>
            <button class="popular_movie_infobtn popular_btn">
               <i class="fas fa-info-circle"> 상세정보</i>
            </button>
         </div>
      </div>
      <div class="popular_subbtn_box">
         <button class="popular_replay" onclick="restart()">

            <i class="fas fa-redo"></i>
         </button>
         <span class="movie_age">15+</span>
      </div>
   </div>
   <!-- movie end-->


   <div class="slider-frame">
      <h2>넷플릭스 인기 콘텐츠</h2>
      <div class="btn prev"></div>
      <div class="btn next"></div>
      <div class="slider-container">
         <c:forEach var="i" items="${contentsList}">
            <div class="slide"
            			data-email="${pageInfo.email}" 
            			data-content_id="${i.content_id }"
                    	data-content_title="${i.content_title }"
                  		data-content_rating="${i.content_rating }" 
                        data-summary="${i.summary }" 
                        data-genre_name="${i.genre_name }" 
                        data-director_name="${i.director_name }" 
                        data-actor_name="${i.actor_name }" 
                        data-imagequality="${i.imagequality }" 
                        data-characteristic="${i.characteristic }" 
                        data-english_title="${i.english_title }" >
               <div>
                  <video class="over_vid" muted="muted"
                     poster="http://kghosting.dothome.co.kr/poster/${i.english_title }.png">
                     <source
                        src="http://kghosting.dothome.co.kr/video/${i.english_title }.mp4"
                        type="video/mp4">
                  </video>


                  <div class="contents_btn">
                     <ul>
                        <li class="play_view"><i class="fas fa-play"></i></li>
                        <li class="pick_view"><i class="fas fa-plus"></i></li>
                        <li class="good_view"><i class="far fa-thumbs-up"></i></li>
                        <li class="hate_view"><i class="far fa-thumbs-down"></i></li>
                        <li class="more_view" onclick="hidden_video()" >
                        <i class="fas fa-chevron-down"></i></li>
                     </ul>
                  </div>
                  
                  <div class="context_info">
                     <span class="con_match">98% 일치</span> <span class="con_age">${i.content_rating }+</span>
                           <span class="con_season">시즌 1개</span> <span class="con_quality">${i.imagequality }</span>
                           <br><span>${i.characteristic }</span>
                  </div>
               </div>
            </div>
         </c:forEach>
      </div>
   </div>
   
   <!-- 랜덤 뿌리기 랜덤 뿌리기!! -->
   <!-- 랜덤 뿌리기 랜덤 뿌리기!! -->
   <!-- 랜덤 뿌리기 랜덤 뿌리기!! -->
   <!-- 랜덤 뿌리기 랜덤 뿌리기!! -->
<div class="slider-frame">
      <h2>지금 뜨는 콘텐츠</h2>
      <div class="btn prev"></div>
      <div class="btn next"></div>
      <div class="slider-container">
         <c:forEach var="i" items="${randomList}">
         
            <div class="slide" 
            			data-email="${pageInfo.email}"
            			data-content_id="${i.content_id }"
                    	data-content_title="${i.content_title }"
                  		data-content_rating="${i.content_rating }" 
                        data-summary="${i.summary }" 
                        data-genre_name="${i.genre_name }" 
                        data-director_name="${i.director_name }" 
                        data-actor_name="${i.actor_name }" 
                        data-imagequality="${i.imagequality }" 
                        data-characteristic="${i.characteristic }" 
                        data-english_title="${i.english_title }" >
               <div>
                  <video class="over_vid" muted="muted"
                     poster="http://kghosting.dothome.co.kr/poster/${i.english_title }.png">
                     <source
                        src="http://kghosting.dothome.co.kr/video/${i.english_title }.mp4"
                        type="video/mp4">
                  </video>


                  <div class="contents_btn">
                     <ul>
                        <li class="play_view"><i class="fas fa-play"></i></li>
                        <li class="pick_view"><i class="fas fa-plus"></i></li>
                        <li class="good_view"><i class="far fa-thumbs-up"></i></li>
                        <li class="hate_view"><i class="far fa-thumbs-down"></i></li>
                        <li class="more_view" onclick="hidden_video()" >
                        <i class="fas fa-chevron-down"></i></li>
                     </ul>
                  </div>
                  <div class="context_info">
                     <span class="con_match">98% 일치</span> <span class="con_age">${i.content_rating }+</span>
                           <span class="con_season">시즌 1개</span> <span class="con_quality">${i.imagequality }</span>
                           <br><span>${i.characteristic }</span>
                  </div>
               </div>
            </div>
         </c:forEach>
      </div>
   </div>



<div class="slider-frame">
      <h2>내가 찜한 콘텐츠</h2>
      <div class="btn prev"></div>
      <div class="btn next"></div>
      <div class="slider-container">
      
      <!--여기 items에서 가져오는 값 빼 다른거 건드시면 안됩니다!!!!!  -->
      <!--여기 items에서 가져오는 값 빼 다른거 건드시면 안됩니다!!!!!  -->
      <!--여기 items에서 가져오는 값 빼 다른거 건드시면 안됩니다!!!!!  -->
      <!--여기 items에서 가져오는 값 빼 다른거 건드시면 안됩니다!!!!!  -->
         <c:forEach var="i" items="${contentsList}">
         <c:forEach var="w" items="${wishLikeInfo}">
         <c:if test="${i.content_id == w.content_id && w.wish !=null}">
         
            <div class="slide" 
            			data-email="${pageInfo.email}" 
            			data-content_id="${i.content_id }"
                    	data-content_title="${i.content_title }"
                  		data-content_rating="${i.content_rating }" 
                        data-summary="${i.summary }" 
                        data-genre_name="${i.genre_name }" 
                        data-director_name="${i.director_name }" 
                        data-actor_name="${i.actor_name }" 
                        data-imagequality="${i.imagequality }" 
                        data-characteristic="${i.characteristic }" 
                        data-english_title="${i.english_title }" >
               <div>
                  <video class="over_vid" muted="muted"
                     poster="http://kghosting.dothome.co.kr/poster/${i.english_title }.png">
                     <source
                        src="http://kghosting.dothome.co.kr/video/${i.english_title }.mp4"
                        type="video/mp4">
                  </video>


                  <div class="contents_btn">
                     <ul>
                        <li class="play_view"><i class="fas fa-play"></i></li>
                        <li class="pick_view"><i class="fas fa-plus"></i></li>
                        <li class="good_view"><i class="far fa-thumbs-up"></i></li>
                        <li class="hate_view"><i class="far fa-thumbs-down"></i></li>
                        <li class="more_view" onclick="hidden_video()" >
                        <i class="fas fa-chevron-down"></i></li>
                     </ul>
                  </div>
                  <div class="context_info">
                     <span class="con_match">98% 일치</span> <span class="con_age">${i.content_rating }+</span>
                           <span class="con_season">시즌 1개</span> <span class="con_quality">${i.imagequality }</span>
                           <br><span>${i.characteristic }</span>
                  </div>
               </div>
            </div>
            </c:if>
         </c:forEach>
         </c:forEach>
      </div>
   </div>
   


   
  <div class="popup_layer">
      <div class="contents_layer">
         <div class="layer_moviebox">
      		
            <video id="vid_hidden" muted="muted" class="vid_hidden"
               poster="http://kghosting.dothome.co.kr/poster/exit_big.png">
               <source src="http://kghosting.dothome.co.kr/video/exit.mp4"
                  type="video/mp4">
            </video>
            <div class="layer_inner_info">
               <div class="layer_info_btn">
                  <ul>
                     <li><i class="fas fa-play"><a id="play_btn" href="http://localhost:8086/netflix/test">재생</a></i></li>
                     <li><i class="fas fa-plus"></i></li>
                     <li><i class="far fa-thumbs-up"></i></li>
                     <li><i class="far fa-thumbs-down"></i></li>
                  </ul>
               </div>
            </div>
            <i class="fas fa-times close_btn"></i>
             
         </div>
         <!--이미지부분 -->
         <div class="layer_info_box">
            <div class="layer_con_left">
               <div class="layer_content_info">
                  <span class="con_match">98% 일치</span> <span class="con_age">15+</span>
                  <span class="con_season">시즌 1개</span> <span class="con_quality">HD</span>
               </div>
               <div class="layer_contnet_text_box">
                  <span class="layer_content_text"></span>
               </div>
            </div>
            <div class="layer_con_right">
               <p>
                  출연:<span id="text_actor_name"></span><a href="">더보기</a>
               </p>
               <p>
                  장르: <span id="text_genre_name"></span>
               </p>
               <p>
                  프로그램 특징: <span id="text_characteristic"></span>
               </p>
            </div>
         
         </div>
      </div>
      <!--컨텐츠 박스-->
      <!--컨텐츠 박스-->
   </div> 

   </main>






   <script src="<c:url value="/resources/js/header.js" />"></script>
   <!--header 스크롤시 색변환 js-->
   <script src="<c:url value="/resources/js/main_slider.js" />"></script>
   <!--슬라이더 js -->
   <script src="<c:url value="/resources/js/video.js" />"></script>

   


 
   <script>
      /*       document.getElementById("vid").muted = ture;
       // 소리 끄기 
       //Muted Play중에 Muted을 없애면, 실행이 멈춥니다. 
       document.getElementById("vid").muted = false;
       // 소리 켜기
       */
   </script>







</body>
</html>
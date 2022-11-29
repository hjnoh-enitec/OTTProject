<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="stylesheet" href="../../resources/css/login.css">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>

<script>
	window.onload=start;
	function start(){
	 
		
		sessionStorage.setItem("vs","${confirm}");
		const v = sessionStorage.getItem("vs");
		
		if(v !== ""){
			
			nc = document.getElementById("emptycheck");
			
			nc.innerHTML = "아이디 또는 비밀번호가 일치하지 않습니다."
				
				setTimeout(function(){
					nc.innerHTML = " ";
				}, 1000);
			<%
			session.removeAttribute("confirm");
			%>
		}
		
		
	
	}
	
	function detail() {
		var con = document.getElementById("detail");
		if (con.style.display == 'none') {
			con.style.display = 'block';
			
		} else {
			con.style.display = 'none';
			
		}
	}
	
	function check() {
		id = document.getElementById("email");
		pw = document.getElementById("password");
		nc = document.getElementById("emptycheck");
		
		if(id.value == "" || pw.value == ""){
			nc.innerHTML = "아이디와 비밀번호를 입력해 주세요"
			
			setTimeout(function(){
				nc.innerHTML = " ";
			}, 1000);
			
			return;
		} 
		
		document.getElementById("f").submit();
	}
</script>
</head>
<body>
	
	<img src="../sample.png">
	<section class="LoginSection">
		<div class="LoginDiv">
			<div class="title">
				<h1>로그인</h1>
				
			</div>
			<div class="form">
				<form action="clientLogin.do" method="post" id="f">
					<p>
						<c:if test="${empty cookie.REMEMBER.value}" >
						<input type="text" id="email" name="email" placeholder="이메일 주소 또는 전화번호">
						</c:if>
						
						<c:if test="${not empty cookie.REMEMBER.value}" >
						<input type="text" id="email" name="email" value=${cookie.REMEMBER.value}>
						</c:if>
						<%-- <form:errors path="email"/> --%>
					</p>
					<p>
						<input type="password" id="password" name="password" placeholder="비밀번호">
						<%-- <form:errors path="password"/> --%>
						<br>
						<font color="white" id="emptycheck"></font>
					</p>
					<p>
					<input type="button" value="로그인" onclick="check();">
					<br>
					<c:if test="${empty cookie.REMEMBER.value}" >
					<input id="infoCk" type="checkbox" name="loginInfo" >
					<label for="infoCk">로그인정보 저장</label>
					</c:if>
					
					<c:if test="${not empty cookie.REMEMBER.value}" >
					<input id="infoCk" type="checkbox" name="loginInfo" checked>
					<label name="test" for="infoCk">로그인정보 저장</label>
					</c:if>
					<a class="admin_login" href="admin_login.ado">관리자 접속</a>
					<p>
					<br>
					<a href="https://kauth.kakao.com/oauth/authorize?client_id=289642e3276d5467b1195472081a807a&redirect_uri=http://localhost:8086/netflix/kakaoLogin&response_type=code">
			<img src="//k.kakaocdn.net/14/dn/btqCn0WEmI3/nijroPfbpCa4at5EIsjyf0/o.jpg" width="150px">
		</a>
					
					<a href="#">도움이 필요하신가요?</a>
					<!-- 회원정보찾는 페이지로 이동 -->
				</form>
			</div>
		
			
			<div class="joinQ">
				Netfilx 회원이 아닌가요?
				<!--누르면 회원가입으로 이동하게 함 -->
				<a href="#"> 지금 가입하세요</a>
				<!-- 회원가입페이지로 이동 -->
			</div>
			<div class="caution">
				<p>이 페이지는 Google reCAPTCHA의 보호를 받아 사용자가 로봇이 아님을 확인합니다.<a href="javascript:detail();">자세히 알아보기</a></p>
				
			</div>
			<div id=detail>Google reCAPTCHA가 수집하는 정보에는 Google 개인정보처리방침과
				서비스약관이 적용되며, 해당정보는 reCAPTCHA 서비스제공, 관리 및 개선과 일반적인 보안유지에 사용됩니다.
				(Google의 개인 맞춤광고에 사용 안함.</div>
		</div>
	</section>
</body>
</html>
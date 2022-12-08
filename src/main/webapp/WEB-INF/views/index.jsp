<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<c:set var="loginId" value="${request.getSession(false)=='' ? '' : pageContext.request.session.getAttribute('c_id')}"/>
<c:set var="name" value="${request.getSession(false)=='' ? '' : pageContext.request.session.getAttribute('c_name')}"/>
<c:set var="m_name" value="${request.getSession(false)=='' ? '' : pageContext.request.session.getAttribute('m_name')}"/>
<c:set var="loginOutLink" value="${loginId==null ? '/login/login?toURL=/' : '/login/logout'}"/>
<c:set var="loginOut" value="${loginId==null ? 'ログイン' : 'ログアウト'}"/>
<!DOCTYPE html>
<html>
<style>
#main a{
	color:black;
	text-decoration-line : none;
	font-size: 30px;
}
#main a:hover{
	color:orange;
}
#menu {
	float:left; 
	width:10%; 
}
#main {
	display:inline-block; 
	width:75%; 
	margin-left:10px;
}  
</style>
<head>
	<meta charset="UTF-8">
    <title>OTT</title>
    <link rel="stylesheet" href="<c:url value='/css/menu.css'/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>    
</head>
<body>
<div id="menu">
	<ul>
	    <li id="logo">OTT</li>
	    <li><a href="<c:url value='/'/>">Home</a></li>
	    <li><a href="<c:url value='${loginOutLink}'/>">${loginOut}</a></li>
	    <c:if test="${loginId == null}">
			<li><a href="<c:url value='/register/signup'/>">Sign in</a></li>
		</c:if>
		<c:if test="${loginId != null}">
			<li>${loginId}</li>
		</c:if>
	   	
	</ul> 
</div>
<div style="text-align:center" id="main">
	
	<br><br><br><br><br><br>
	<c:if test="${loginId != null}">
		<h1>ようこそ、${name}　様</h1>
		<br>
	</c:if>
	<h1><a href="/content/main" onclick="">動画</a></h1>
	<c:if test="${loginId == null}">
		<h1><a href="/register/signup">会員登録</a></h1>
	</c:if>
	<c:if test="${loginId != null}">
		<h1><a href="/customer/info">会員情報</a></h1>
	</c:if>
	
	<h1><a href='${loginOutLink }'>${loginOut }</a></h1>
</div>

	<script src="js/index.js"></script>
	
</body>
</html>
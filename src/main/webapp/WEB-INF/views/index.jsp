<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<c:set var="loginId" value="${request.getSession(false)=='' ? '' : pageContext.request.session.getAttribute('c_id')}"/>
<c:set var="loginOutLink" value="${loginId==null ? '/login/login?toURL=/' : '/login/logout'}"/>
<c:set var="loginOut" value="${loginId==null ? 'Login' : 'Logout'}"/>
<c:set var="customerName" value="${loginId==null ? '' : loginId}"/>
<!DOCTYPE html>
<html>
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
	    <li><a href="<c:url value='/register/signup'/>">Sign in</a></li>
	   	<li>${loginId}</li>
	</ul> 
</div>
<div style="text-align:center">
	<h1><a href="/register/signup">登録</a></h1>
	<h1><a href='${loginOutLink }'>${loginOut }</a></h1>
	<h1><a href="/modify/pwCheck">修正</a></h1>
	<h1><a href="/customer/info">info</a></h1>
	<h1>${loginId}</h1>
	dd
</div>
</body>
</html>
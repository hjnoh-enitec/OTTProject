<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <title>OTT</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>    
</head>
<body>
<%@ include file="./home/header.jsp" %>
<div style="text-align:center">
	<h1><a href="/register/signup">登録</a></h1>
	<h1><a href='${loginOutLink }'>${loginOut }</a></h1>
	<h1><a href="/modify/pwCheck">修正</a></h1>
	<h1><a href="/customer/info">info</a></h1>
	<h1>${loginId}</h1>

</div>
</body>
</html>
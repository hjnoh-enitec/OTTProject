<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OTT - Watch Video</title>
</head>
<body>
<%@ include file="/jsp/home/header.jsp"%>
	<video width="640" height="320" controls autoplay="autoplay">
		<source src="/video/test1.mp4" type="video/mp4">
	</video>
</body>
</html>
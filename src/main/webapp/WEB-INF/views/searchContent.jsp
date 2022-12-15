<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="/jsp/home/header.jsp"%>
	<ul>
		<c:forEach var="content" items="${search }" varStatus="status">
			<li>${content.ct_code }</li>
		</c:forEach>
	</ul>

</body>
</html>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page session="false"%>
<%@ page import="java.net.URLDecoder"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> </title>
</head>
<body>
	
	<div>
		<select id="selectSeason" onchange="changeValue(this)">
			<c:forEach var="sList" items="${seasonList}">
				<option value="<c:out value="${sList.s_code}" />"><c:out value="${sList.s_name}" /></option>
			</c:forEach>
		</select>
	</div>
	<input id="test" type="hidden">
	<div id="append">
	</div>
	
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	
	<script>
		
		
	
		var selectSeason = document.getElementById("selectSeason");
		var test = document.getElementById("test");
		var append = document.getElementById("append");
		
		console.log(selectSeason.value);
		
		$.ajax({
			type : "GET",
			url : "http://localhost:8000/content/searchEpiBySeason?s_code=" + selectSeason.value,
			contentType : "application/json",
			dataType : "json",
			success : function (data, status) {
				alert(status);
				str = '<select>'; 
                $.each(data , function(i){
                    str += "<option>" + data[i].e_name +  "</option>";
                });
                str += '</select>'
                append.innerHTML = str;
			},
			error : function(status){
				alert(status + "error!");
			}
		});
		
		function changeValue(target){
			test.value = target.value;
			append.innerHTML = "";
			
			$.ajax({
				type : "GET",
				url : "http://localhost:8000/content/searchEpiBySeason?s_code=" + target.value,
				contentType : "application/json",
				dataType : "json",
				success : function (data, status) {
					alert(status);
					str = '<select>'; 
                    $.each(data , function(i){
                        str += "<option>" + data[i].e_name +  "</option>";
                    });
                    str += '</select>'
                    append.innerHTML = str;
				},
				error : function(status){
					alert(status + "error!");
				}
			});
		}
		
		
		
	</script>
	
</body>
</html>
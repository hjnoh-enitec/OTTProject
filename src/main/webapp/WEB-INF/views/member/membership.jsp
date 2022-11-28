<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page import="java.net.URLDecoder"%>
<%@ page session="false" %>
<c:set var="loginId" value="${request.getSession(false)=='' ? '' : pageContext.request.session.getAttribute('c_id')}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>OTTProject - Membership Join</title>
	<link rel="stylesheet" href="<c:url value='/css/menu.css'/>">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
	<style>
		* { box-sizing:border-box; }
		a { text-decoration: none; }
		form {
			width:400px;
			height:600px;
			display : flex;
			flex-direction: column;
			align-items:center;
			position : absolute;
			top:50%;
			left:50%;
			transform: translate(-50%, -50%) ;
			border: 1px solid rgb(89,117,196);
			border-radius: 10px;
		}
		input[type='text'], input[type='password'] {
			width: 300px;
			height: 40px;
			border : 1px solid rgb(89,117,196);
			border-radius:5px;
			padding: 0 10px;
			margin-bottom: 10px;
		}
		button {
			background-color: rgb(89,117,196);
			color : white;
			width:300px;
			height:50px;
			font-size: 17px;
			border : none;
			border-radius: 5px;
			margin : 20px 0 30px 0;
		}
		#title {
			font-size : 50px;
			margin: 40px 0 30px 0;
		}
		#msg {
			height: 30px;
			text-align:center;
			font-size:16px;
			color:red;
			margin-bottom: 20px;
		}
		.td_No_1{
			width: 50px;
		}
		.td_No_2{
			width: 200px;
		}
		.td_No_3{
			width: 150px;
		}
	</style>
</head>
<body>
<div id="menu">
	<ul>
		<li id="logo">OTT</li>
		<li><a href="<c:url value='/'/>">Home</a></li>
		<li><a href="<c:url value='/board/list'/>">Board</a></li>
		<li><a href="<c:url value='${loginOutLink}'/>">${loginOut}</a></li>
		<li><a href="<c:url value='/register/add'/>">Sign in</a></li>
		<li><a href=""><i class="fa fa-search"></i></a></li>
	</ul>
</div>
	<form action="/customer/membershipSuccess" onsubmit="return doAction()" method="post">
	
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		
		<div class="title"><h2>Choose your Plan</h2></div>
		
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		
		<label for="">プランを選んでください。</label>
		
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		
		<c:if test="${membershipCode != null}">
			<h4>現在のプラン</h4>
			<h4>${membershipCode}</h4>
		</c:if>
		<div id="msg" class="msg">
			<p id="errorMsg"></p>
		</div>
		<input type="text" name ="c_id" value="${loginId}">
		<select name="m_code" id="planSelect" onchange="selectBoxChange(this.value);" style="width: 300px; height: 50px; font-size: 20px; text-align: center;">
				<option value="">未選択</option>
				<c:forEach var="msList" items="${ml}">
				<option value="<c:out value="${msList.m_code}" />"><c:out value="${msList.m_name}" /> (<c:out value="毎月 ¥${msList.m_price}" />)</option>
				</c:forEach>
		</select>
		<div id="msg" class="msg">
			<p id="planComment"></p>
		</div>		
		<button>申込</button>
	</form>
	<script>
	
		var plan = document.getElementById("planSelect").value;
	
		var selectBoxChange = function(value){
			
			var planComment = document.getElementById("planComment");
			
			plan = value;
			
			if(plan == "M1"){
				planComment.innerHTml = "1人プラン、最大画質 720P";
			}else if(plan == "M2"){
				planComment.innerHTml = "2人プラン、最大画質 1080P";
			}else if(plan == "M3"){
				planComment.innerHTml = "4人プラン、最大画質 1080P";
			}else if(plan == "M4"){
				planComment.innerHTml = "4人プラン、最大画質 2160P";
			}else if(plan == ''){
				planComment.innerHTml = "";
			}
		}

		function doAction(){
			
			var errMsg = document.getElementById("errorMsg");
			
			if(plan == ""){
				errMsg.innerHTml = "Check your plan";
				return false;
			}
			return true;
		}
		
	</script>
</body>
</html>
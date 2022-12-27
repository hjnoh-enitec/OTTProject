<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page import="java.net.URLDecoder"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OTTProject - UserInfo</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
<link rel="stylesheet" href="/css/customerInfo.css"/>
<link rel="shortcut icon" href="/img/logo.png">
</head>
<body>
<%@ include file="/jsp/home/header.jsp"%>
	<div id="main">
		<div class="title"><h2></h2></div>
		<form id="csForm">
		<table>
			<tr>
				<td><label for="">ID</label></td>
				<td><input class="input-field" type="text" name="id" id="id" value="${customer.c_id }" disabled="disabled" style="margin-left: 10px;"></td>
			</tr>
			<tr>
				<td><label for="">名前</label></td>
				<td><input class="input-field" type="text" name="name" id="name" value="${customer.c_name }" disabled="disabled" style="margin-left: 10px;"></td>
			</tr>
			<tr>
				<td><label for="">生年月日</label></td>
				<td><input class="input-field" type="text" name="birth" id="birth" value="${customer.c_birth }" disabled="disabled" style="margin-left: 10px;"></td>
			</tr>
			<tr>
				<td><label for="">電話番号</label></td>
				<td><input class="input-field" type="text" name="phone" id="phone" value="${customer.c_phone }" disabled="disabled" style="margin-left: 10px;"></td>
			</tr>
			<tr>
				<td><label for="">メンバーシップ</label></td>
				<td>
					<c:if test="${customer.m_code == null}">
						<input class="input-field" type="text" name="mcode" id="mcode" value="未加入" disabled="disabled" style="margin-left: 10px;">
					</c:if>
					<c:if test="${customer.m_code == 'M1'}">
						<input class="input-field" type="text" name="mcode" id="mcode" value="ペーシック" disabled="disabled" style="margin-left: 10px;">
					</c:if>
					<c:if test="${customer.m_code == 'M2'}">
						<input class="input-field" type="text" name="mcode" id="mcode" value="スタンダード" disabled="disabled" style="margin-left: 10px;">
					</c:if>
					<c:if test="${customer.m_code == 'M3'}">
						<input class="input-field" type="text" name="mcode" id="mcode" value="プレミアム" disabled="disabled" style="margin-left: 10px;">
					</c:if>
					<c:if test="${customer.m_code == 'M4'}">
						<input class="input-field" type="text" name="mcode" id="mcode" value="オメガ" disabled="disabled" style="margin-left: 10px;">
					</c:if>
				</td>
			</tr>
			<tr>
				<td><label for="">プランの期限</label></td>
				<td>
					<c:if test="${customer.m_code == null}">
						<input class="input-field" type="text" name="endDate" id="endDate" value="メンバーシップ未加入" disabled="disabled" style="margin-left: 10px;">
					</c:if>
					<c:if test="${customer.m_code != null}">
						<input class="input-field" type="text" name="endDate" id="endDate" value="${customer.m_start_date} ~ ${customer.m_end_date}" disabled="disabled" style="margin-left: 10px;">
					</c:if>
				</td>
			</tr>
			<tr>
				<td><label for="">引き落とし設定</label></td>
				<td>
				<c:if test="${customer.m_autopay == 'F' && customer.m_code == null}">
					<input class="input-field" type="text" name="autopay" id="autopay" value="メンバーシップ未加入" disabled="disabled" style="margin-left: 10px;">
				</c:if>
				<c:if test="${customer.m_autopay == 'T'}">
					<input class="input-field" type="text" name="autopay" id="autopay" value="はい" disabled="disabled" style="margin-left: 10px;">
				</c:if>
				<c:if test="${customer.m_autopay == 'F' && customer.m_code != null}">
					<input class="input-field" type="text" name="autopay" id="autopay" value="いいえ" disabled="disabled" style="margin-left: 10px;">
				</c:if>
				</td>
			</tr>
		</table>
		<p><p>
			<div style="text-align: center;">
				<div style="margin-bottom: 10px;"><input type="submit" onclick="javascript: form.action='http://localhost:8000/modify/modify'" value="会員情報修正"></div>
				<div style="margin-bottom: 10px;"><input type="submit" onclick="javascript: form.action='/customer/modifyMembership'" value="メンバーシップ契約＆修正"></div>
				<div style="margin-bottom: 10px;">
					<c:if test="${customer.m_code == null || customer.m_autopay == 'F'}">
					<input type="submit" value="メンバーシップ脱退" id="quitMembership" disabled="disabled">
				</c:if>
					
				<c:if test="${customer.m_code != null && customer.m_autopay == 'T'}">
					<input type="submit" onclick="javascript: form.action='/customer/withdrwal'" value="メンバーシップ解約" id="quitMembership">
				</c:if>
				</div>
			</div>
		</form>
	</div>

	<script src="/js/customerInfo.js"></script>
	
</body>
</html>
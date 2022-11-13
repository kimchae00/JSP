<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>user2::list</title>
	</head>
	<body>
		<h3>user2 목록</h3>
		<a href="/Ch09/index.jsp">처음으로</a>
		<a href="/Ch09/user2/register.do">user2 등록하기</a>
		<table border="1">
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>휴대폰</th>
				<th>나이</th>
				<th>관리</th>
			</tr>
			<c:forEach var="user" items="${users}">
				<tr>
					<td>${user.uid}</td>
					<td>${user.name}</td>
					<td>${user.hp}</td>
					<td>${user.age}</td>
					<td>
						<a href="/Ch09/user2/modify.do?uid=${user.uid}">수정</a>
						<a href="/Ch09/user2/delete.do?uid=${user.uid}">삭제</a>
					</td>
				</tr>
			</c:forEach>		
		</table>
	</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>customer::register</title>
	</head>
	<body>
		<h3>customer 등록</h3>
		
		<a href="../2_DBCPTest.jsp">처음으로</a>
		<a href="./list.jsp">customer 목록</a>
		
		<form action="./registerProc.jsp">
			<table border="1">
				<tr>
					<td>아이디</td>
					<td><input type="text" name="custid" placeholder="아이디 입력"/></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="name" placeholder="이름 입력"/></td>
				</tr>
				<tr>
					<td>휴대폰</td>
					<td><input type="text" name="hp" placeholder="휴대폰 입력"/></td>
				</tr>
				<tr>
					<td>주소</td>
					<td><input type="text" name="addr" placeholder="주소 입력"/></td>
				</tr>
				<tr>
					<td>입사일</td>
					<td><input type="date" name="rdate"/></td>
				</tr>
				<tr>
					<td colspan="2" align="right"></td>
					<td><input type="submit" value="등록"/></td>
				</tr>
			</table>
		</form>
	</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>book::register</title>
	</head>
	<body>
		<h3>도서등록</h3>
		<a href="/BookStore2/index.jsp">처음으로</a>
		<a href="/BookStore2/book/list.do">도서목록</a>
		
		<form action="/BookStore2/book/register.do" method="post">
			<table border="1">
				<tr>
					<td>도서번호</td>
					<td><input type="number" name="bookId" placeholder="도서번호 입력"/></td>
				</tr>
				<tr>
					<td>도서명</td>
					<td><input type="text" name="bookName" placeholder="도서명 입력"/></td>
				</tr>
				<tr>
					<td>출판사</td>
					<td><input type="text" name="publisher" placeholder="출판사 입력"/></td>
				</tr>
				<tr>
					<td>가격</td>
					<td><input type="number" name="price" placeholder="가격 입력"/></td>
				</tr>
				<tr>
					<td colspan="2" align="right"></td>
					<td><input type="submit" value="등록"/></td>
				</tr>
			</table>
		
		</form>
	</body>
</html>
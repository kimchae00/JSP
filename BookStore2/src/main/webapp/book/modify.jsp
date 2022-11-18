<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>book::modify</title>
	</head>
	<body>
		<h3>도서수정</h3>
		<a href="/BookStore2/index.jsp">처음으로</a>
		<a href="/BookStore2/book/list.do">도서목록</a>
		
		<form action="/BookStore2/book/modify.do" method="post">
			<table border="1">
				<tr>
					<td>도서번호</td>
					<td><input type="number" name="bookId" readonly value="${requestScope.vo.bookId}"/></td>
				</tr>
				<tr>
					<td>도서명</td>
					<td><input type="text" name="bookName" value="${vo.bookName}"/></td>
				</tr>
				<tr>
					<td>출판사</td>
					<td><input type="text" name="publisher" value="${vo.publisher}"/></td>
				</tr>
				<tr>
					<td>가격</td>
					<td><input type="number" name="price" value="${vo.price}"/></td>
				</tr>
				<tr>
					<td colspan="2" align="right"></td>
					<td><input type="submit" value="수정"/></td>
				</tr>
			</table>
		</form>
	</body>
</html>
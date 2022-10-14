<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="bean.CustomerBean"%>
<%@page import="java.util.List"%>
<%@page import="config.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%

	request.setCharacterEncoding("utf-8");
	
	List<CustomerBean> customers = new ArrayList<>(); 

	try{
		Connection conn = DBCP.getConnection("dbcp_java1_shop");
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("select * from `customer`");
		
		while(rs.next()){
			CustomerBean cb = new CustomerBean();
			cb.setCustid(rs.getString(1));
			cb.setName(rs.getString(2));
			cb.setHp(rs.getString(3));
			cb.setAddr(rs.getString(4));
			cb.setRdate(rs.getString(5));
			
			customers.add(cb);
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}

%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>customer::list</title>
	</head>
	<body>
		<h3>customer 목록</h3>
		
		<a href="../2_DBCPTest.jsp">처음으로</a>
		<a href="./register.jsp">customer 등록</a>
		
		<table border="1">
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>휴대폰</th>
				<th>주소</th>
				<th>입사일</th>
				<th>관리</th>
			</tr>
			<% for(CustomerBean cb : customers){ %>
			<tr>
				<td><%= cb.getCustid() %></td>
				<td><%= cb.getName() %></td>
				<td><%= cb.getHp() %></td>
				<td><%= cb.getAddr() %></td>
				<td><%= cb.getRdate() %></td>
				<td>
					<a href="./modify.jsp?uid=<%= cb.getCustid() %>">수정</a>
					<a href="./delete.jsp?uid=<%= cb.getCustid() %>">삭제</a>
				</td>
			</tr>
			<% } %>		
		</table>
	</body>
</html>
<%@page import="kr.co.shop.db.Sql"%>
<%@page import="kr.co.shop.bean.OrderBean"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="kr.co.shop.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	List<OrderBean> orders = new ArrayList<>(); 

	try{
		Connection conn = DBCP.getConnection();
		PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_ORDERS);
		ResultSet rs = psmt.executeQuery();
		
		while(rs.next()){
			OrderBean ob = new OrderBean();
			ob.setOrderNo(rs.getInt(1));
			ob.setOrderId(rs.getString(2));
			ob.setOrderProduct(rs.getInt(3));
			ob.setOrderCount(rs.getInt(4));
			ob.setOrderDate(rs.getString(5));
			ob.setName(rs.getString(6));
			ob.setProdName(rs.getString(7));
			
			orders.add(ob);
		}
		
		rs.close();
		psmt.close();
		conn.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}

%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Shop:order</title>
	</head>
	<body>
		<h3>주문목록</h3>
		
		<a href="./customer.jsp">고객목록</a>
		<a href="./order.jsp">주문목록</a>
		<a href="./product.jsp">상품목록</a>
		
		<table border="1">
			<tr>
				<th>주문번호</th>
				<th>주문자</th>
				<th>주문상품</th>
				<th>주문수량</th>
				<th>주문일</th>
			</tr>
			<% for(OrderBean ob : orders){ %>
			<tr>
				<td><%= ob.getOrderNo() %></td>
				<td><%= ob.getName() %></td>
				<td><%= ob.getProdName() %></td>
				<td><%= ob.getOrderCount() %></td>
				<td><%= ob.getOrderDate().substring(0,16) %></td>
			</tr>
			<% } %>		
		</table>
	</body>
</html>
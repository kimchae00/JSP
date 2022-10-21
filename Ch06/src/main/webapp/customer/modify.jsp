<%@page import="java.sql.PreparedStatement"%>
<%@page import="bean.CustomerBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="config.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String custid = request.getParameter("custid");
	
	CustomerBean cb = null;
	
	try{
		Connection conn = DBCP.getConnection("dbcp_java1_shop");
		
		String sql = "select * from `customer` where `custid`=?";
		
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, custid);
		ResultSet rs  = psmt.executeQuery();
		
		if(rs.next()){
			cb = new CustomerBean();
			cb.setCustid(rs.getString(1));
			cb.setName(rs.getString(2));
			cb.setHp(rs.getString(3));
			cb.setAddr(rs.getString(4));
			cb.setRdate(rs.getString(5));
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
		<title>customer::modify</title>
	</head>
	<body>
		<h3>customer 수정</h3>
		
		<a href="../2_DBCPTest.jsp">처음으로</a>
		<a href="./list.jsp">customer 목록</a>
		
		<form action="./modifyProc.jsp" method="get">
			<table border="1">
				<tr>
					<td>아이디</td>
					<td><input type="text" name="custid" value="<%= cb.getCustid() %>" readonly="readonly"/></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="name" value="<%= cb.getName() %>"/></td>
				</tr>
				<tr>
					<td>휴대폰</td>
					<td><input type="text" name="hp" value="<%= cb.getHp() %>"/></td>
				</tr>
				<tr>
					<td>주소</td>
					<td><input type="text" name="addr" value="<%= cb.getAddr() %>"/></td>
				</tr>
				<tr>
					<td>입사일</td>
					<td><input type="date" name="rdate" value="<%= cb.getRdate() %>"/></td>
				</tr>
				<tr>
					<td colspan="2" align="right"></td>
					<td><input type="submit" value="수정"/></td>
				</tr>
			</table>
		</form>
	</body>
</html>
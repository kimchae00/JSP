<%@page import="java.sql.PreparedStatement"%>
<%@page import="config.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%	
	request.setCharacterEncoding("utf-8");
	
	String custid = request.getParameter("custid");
	String name = request.getParameter("name");
	String hp = request.getParameter("hp");
	String addr = request.getParameter("addr");
	String rdate = request.getParameter("rdate");

	try{
		Connection conn = DBCP.getConnection("dbcp_java1_shop");
		PreparedStatement psmt = conn.prepareStatement("insert into `customer` values (?,?,?,?,?)");
		psmt.setString(1, custid);
		psmt.setString(2, name);
		psmt.setString(3, hp);
		psmt.setString(4, addr);
		psmt.setString(5, rdate);
		
		psmt.executeUpdate();
		
		psmt.close();
		conn.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}

	response.sendRedirect("./register.jsp");


%>
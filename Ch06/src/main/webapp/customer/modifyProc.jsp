<%@page import="java.sql.PreparedStatement"%>
<%@page import="config.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//전송 데이터 수신
	request.setCharacterEncoding("utf-8");
	
	String custid = request.getParameter("custid");
	String name = request.getParameter("name");
	String hp = request.getParameter("hp");
	String addr = request.getParameter("addr");
	String rdate = request.getParameter("rdate");

	try{
		Connection conn = DBCP.getConnection("dbcp_java1_shop");
		
		String sql = "update `customer` set `name`=?, `hp`=?, `addr`=?, `rdate`=?";
			   sql += "where `custid`=?";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, name);
		psmt.setString(2, hp);
		psmt.setString(3, addr);
		psmt.setString(4, rdate);
		psmt.setString(5, custid);
		
	 	psmt.executeUpdate();
	 	
	 	psmt.close();
	 	conn.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	response.sendRedirect("./list.jsp");


%>
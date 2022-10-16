<%@page import="java.sql.PreparedStatement"%>
<%@page import="config.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String custid = request.getParameter("custid");
	
	try{
		
		Connection conn = DBCP.getConnection("dbcp_java1_shop");
		
		String sql = "DELETE FROM `user5` WHERE `uid`=?";
	 	PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, custid);
		// 4단계
		psmt.executeUpdate();
		
		conn.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	response.sendRedirect("./list.jsp");
%>
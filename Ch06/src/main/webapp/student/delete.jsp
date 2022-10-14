<%@page import="config.JDBC"%>
<%@page import="bean.StudentBean"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="bean.UserBean"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String uid = request.getParameter("uid");

	
		
	StudentBean sb = null;
	
	try{
		// 2단계
		Connection conn = JDBC.getInstance().getConnection();
		// 3단계
		String sql = "DELETE FROM `student` WHERE `uid`=?";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, uid);
		// 4단계
		psmt.executeUpdate();
		
		// 6단계
		psmt.close();
		conn.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	response.sendRedirect("./list.jsp");
%>

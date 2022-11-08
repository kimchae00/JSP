<%@page import="java.sql.Statement"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String regStdNo = request.getParameter("regStdNo");
	String stdName = request.getParameter("stdName");
	String lecName = request.getParameter("lecName");

	int result = 0;
	
	try{
		Connection conn = DBCP.getConnection();
		String sql = "insert into `register` (`regStdNo`, `stdName`, `lecName`)";
			   sql += "values (?, ?, ?)";
			   
		Statement stmt = conn.createStatement();		   
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, regStdNo);
		psmt.setString(2, stdName);
		psmt.setString(3, lecName);

		result = psmt.executeUpdate();
		psmt.close();
		conn.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	// JSON 출력
	JsonObject json = new JsonObject();
	json.addProperty("result", result);
	
	String jsonData = json.toString();
	out.print(jsonData);
%>
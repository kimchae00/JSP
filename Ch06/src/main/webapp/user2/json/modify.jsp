<%@page import="com.google.gson.JsonObject"%>
<%@page import="bean.UserBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="config.JDBC"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	String uid = request.getParameter("uid");
	String name = request.getParameter("name");
	String hp = request.getParameter("hp");
	String age = request.getParameter("age");
	
	int result2 = 0;
	
	try{
		Connection conn = JDBC.getInstance().getConnection();
		
		Statement stmt = conn.createStatement();
		String sql = "select * from `user2` where `uid`=?";
		ResultSet rs = stmt.executeQuery(sql);
		
		if(rs.next()){
			UserBean ub = new UserBean();
			ub.setUid(rs.getString(1));
			ub.setName(rs.getString(2));
			ub.setHp(rs.getString(3));
			ub.setAge(rs.getInt(4));
		}
		
		
		rs.close();
		stmt.close();
		conn.close();
		
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	JsonObject json= new JsonObject();
	json.addProperty("result2", result2);
	
	String jsonData = json.toString();
	
	out.print(jsonData);
%>
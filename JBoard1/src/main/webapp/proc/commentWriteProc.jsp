<%@page import="com.google.gson.JsonObject"%>
<%@page import="kr.co.jboard1.bean.ArticleBean"%>
<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@page import="kr.co.jboard1.db.Sql"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.co.jboard1.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String pg      = request.getParameter("pg");
	String parent  = request.getParameter("parent");
	String content = request.getParameter("content");
	String uid 	   = request.getParameter("uid");
	String regip   = request.getRemoteAddr();
	
	ArticleBean comment = new ArticleBean();
	comment.setParent(parent);
	comment.setContent(content);
	comment.setUid(uid);
	comment.setRegip(regip);
	
	ArticleBean ab = ArticleDAO.getInstance().insertComment(comment);

	//response.sendRedirect("/JBoard1/view.jsp?no="+parent+"&pg="+pg);

	// JSON 출력
	JsonObject json = new JsonObject();
	json.addProperty("result", 1);
	json.addProperty("no", ab.getNo());
	json.addProperty("parent", ab.getParent());
	json.addProperty("nick", ab.getNick());
	json.addProperty("date", ab.getRdate());
	json.addProperty("content", ab.getContent());
	
	String jsonData = json.toString();
	out.print(jsonData);
%>
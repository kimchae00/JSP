<%@page import="kr.co.farmstory1.dao.ArticleDAO"%>
<%@page import="java.io.File"%>
<%@page import="com.google.gson.JsonObject"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String group = request.getParameter("group");
	String cate = request.getParameter("cate");
	String no = request.getParameter("no");
	String pg = request.getParameter("pg");
	
	ArticleDAO dao = ArticleDAO.getInstance();
	
	// 글 삭제 + 댓글 삭제
	dao.deleteArticle(no);
	 
	// 파일 삭제 (테이블)
	String fileName = dao.deleteFile(no);
	
	// 파일 삭제(디렉토리)
	if(fileName != null){
		
		String path = application.getRealPath("/file");
		
		File file = new File(path, fileName);
		
		if(file.exists()){
			file.delete();
		}
	}
	
	response.sendRedirect("/Farmstory1/board/list.jsp?group="+group+"&cate="+cate+"&pg="+pg);
%>
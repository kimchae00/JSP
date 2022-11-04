<%@page import="org.slf4j.LoggerFactory"%>
<%@page import="org.slf4j.Logger"%>
<%@page import="kr.co.jboard1.bean.UserBean"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 로거 생성
	Logger logger = LoggerFactory.getLogger(this.getClass());

	logger.debug("debug log...");
	logger.info("info log...");
	logger.warn("warn log...");
	logger.error("error log...");

	// 로그인 여부에 따라 페이지 분기
	UserBean sessUser = (UserBean)session.getAttribute("sessUser");
	
	if(sessUser == null){
		pageContext.forward("./user/login.jsp");
	}else{
		pageContext.forward("./list.jsp");
	}
%>
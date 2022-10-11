<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>내장 객체 - application</title>
	</head>
	<body>
		<h2>web.mxl에 설정한 내용 읽어오기</h2>
		초기화 매개변수 : <%= application.getInitParameter("INIT_PARAM") %>
		
		<h2>서버의 물리적 경로 얻어오기</h2>
		application 내장 객체 : <%= application.getRealPath("/ch02") %>
		
		<h2>선언부에서 application 내장 객체 사용하기</h2>
		<%!
		public String usech02() {
			return this.getServletContext().getRealPath("/ch02");
		}
		public String usech02(ServletContext app) {
			return app.getRealPath("/ch02");
		}
		%>
		<ul>
			<li>this 사용 : <%= usech02() %></li>
			<li>내장 객체를 인수로 전달 : <%= usech02(application) %></li>
		</ul>
	</body>
</html>
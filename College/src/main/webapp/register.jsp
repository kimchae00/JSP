<%@page import="java.sql.PreparedStatement"%>
<%@page import="bean.RegisterBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

    List<RegisterBean> registers = new ArrayList<>();	

	try{
		Connection conn = DBCP.getConnection();
		
		String sql = "SELECT a.*, b.`stdName`, c.`lecName` FROM `register` AS a "
					+"JOIN `student` AS b ON a.`regStdNo` = b.`stdNo` "
					+"JOIN `lecture` AS c ON a.`regLecNo` = c.`lecNo`";
		PreparedStatement psmt = conn.prepareStatement(sql);
		
		ResultSet rs = psmt.executeQuery();
		
		while(rs.next()){
			RegisterBean rb = new RegisterBean();
			rb.setRegStdNo(rs.getString(1));
			rb.setRegLecNo(rs.getInt(2));
			rb.setRegMidScore(rs.getInt(3));
			rb.setRegFinalScore(rs.getInt(4));
			rb.setRegTotalScore(rs.getInt(5));
			rb.setRegGrade(rs.getString(6));
			rb.setStdName(rs.getString(7));
			rb.setLecName(rs.getString(8));
			
			registers.add(rb);
		}
		
		rs.close();
		psmt.close();
		conn.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>College:register</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
		<script>
			$(function(){
				
				$('.btnReg').click(function(){
					
					let regStdNo = $(this).val();
					$('section').show().find('input[name=regStdNo]');
				});
				
				$('.btnClose').click(function(){
					$('section').hide();
				});
				
				// 최종 추가 버튼
				$('input[type=submit]').click(function(){
					
					let regStdNo     = $('input[name=regStdNo]').val();
					let stdName   = $('input[name=stdName]').val();
					let lecName = $('select[name=lecName]').val();
					
					let jsonData = {
						"regStdNo": regStdNo,
						"stdName": stdName,
						"lecName": lecName
					};
					
					console.log('jsonData : ' + jsonData);
					
					$.ajax({
						url: './registerProc.jsp',
						type: 'POST',
						data: jsonData,
						dataType: 'json',
						success:function(data){
							if(data.result == 1){
								alert('등록완료!');
							}else{
								alert('등록실패!');
							}
						}
					});
				});
			});
		</script>
	</head>
	<body>
		<h3>수강관리</h3>
		
		<a href="./lecture.jsp">강좌관리</a>
		<a href="./register.jsp">수강관리</a>
		<a href="./student.jsp">학생관리</a>
		
		<h4>수강현황</h4>
		
		<input type="search" placeholder="학번입력"> <button>검색</button> <button class="btnReg">수강신청</button>
			
		<table border="1">
			
			<tr>
				<th>학번</th>
				<th>이름</th>
				<th>강좌명</th>
				<th>강좌코드</th>
				<th>중간시험</th>
				<th>기말시험</th>
				<th>총점</th>
				<th>등급</th>
			</tr>
			<% for(RegisterBean rb : registers){ %>
			<tr>
				<td><%= rb.getRegStdNo() %></td>
				<td><%= rb.getStdName() %></td>
				<td><%= rb.getLecName() %></td>
				<td><%= rb.getRegLecNo() %></td>
				<td><%= rb.getRegMidScore()%></td>
				<td><%= rb.getRegFinalScore() %></td>
				<td><%= rb.getRegTotalScore() %></td>
				<td><%= rb.getRegGrade() %></td>
				
			</tr>
			<% } %>
		</table>
		
		<section style="display: none">
			<h4>수강신청</h4>
			<button class="btnClose">닫기</button>
			<table border="1">
				<tr>
					<td>학번</td>
					<td><input type="text" name="regStdNo"/></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="stdName"/></td>
				</tr>
				<tr>
					<td>신청강좌</td>
					<td>
						<select name="lecName">
							<option value="none" selected="selected">강좌선택</option>
							<option value="1">운영체제론</option>
							<option value="2">무역영문</option>
							<option value="3">세법개론</option>
							<option value="4">빅데이터 개론</option>
							<option value="5">컴퓨팅사고와 코딩</option>
							<option value="6">사회복지 마케팅</option>
							<option value="7">컴퓨터 구조론</option>
						</select> 
					</td>
				</tr>
				<tr>
					<td colspan="2" align="right"><input type="submit" value="신청"/></td>
				</tr>
			</table>
		</section>
	</body>
</html>